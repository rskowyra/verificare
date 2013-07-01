/* ========================================================================
MODEL OF A PERSISTENT CHANNEL WITH DATA          Copyright AT&T, 2011,2012.

This model is an appendix to the paper "Compositional Network Mobility"
by Pamela Zave and Jennifer Rexford.

WHAT IS MODELED?

The Promela code describes a two-way data channel between two processes.
At each end there is a "higher endpoint" process that acts as a source and
sink of data, and a "lower endpoint" process that interfaces with a network
to send and receive messages.

The higher and lower processes at one end of the channel are on the same
machine, and communicate through the operating system of that machine.
Specifically, they communicate through a pair of buffers "dataUp" and
"dataDown".  The distinct content of data messages is not modeled.

The channel is persistent, in the sense that it is neither created nor
destroyed in this model.

The network can lose messages in transit.  It can also reorder messages, so
that messages with the same source and destination are not received in the
order sent.  These properties of the network are simulated by code in the
lower endpoint processes.  Loss and reordering are nondeterministic, but
can only happen twice and once (respectively) at each endpoint.

To make up for these deficiencies of the network, the lower endpoints
implement a simple protocol for reliable transmission.  An endpoint does
not send new data until the last data message has been acknowledged.  
Binary sequence numbers are used to detect message loss and duplication.  
Lost messages are re-transmitted, while duplicates are discarded.  It turns
out that message reordering does not cause any problems, because there is
at most one data message and one ack message in transit in the same
direction simultaneously, and they are independent.

An endpoint learns that a message has been lost when it times out waiting
for a data acknowledgment.  This is modeled using the built-in predicate
"timeout", which is true when and only when no other actions in the model
are executable.  The timeout predicate is convenient, but not completely
general, because in the real world a timeout can occur when other actions
are still executable (they are not being executed at the moment for
reasons outside the model).  It is possible to model timeouts correctly,
but takes considerably more work.

See below for information about what is verified, and how.
======================================================================== */

mtype = { data, ackData };

chan dataUp  [2] = [2] of {mtype};      
chan dataDown[2] = [2] of {mtype};      
chan netTo[2] = [2] of {mtype,bit};

proctype higherEndpoint (bit id) {

   do
   :: nfull(dataDown[id]) && nfull(dataUp[id])              /* send data */
      -> dataDown[id]!data  

   :: dataUp[id]?data -> progress: skip                  /* receive data */
   od;
}

proctype lowerEndpoint (bit id, notId) {
                                         /* reliability protocol:        */
   bit sendSeq = 0;                         /* sending sequence number   */
   bit recvSeq = 0;                         /* receiving sequence number */
   bit inputSeq = 0;                        /* temporary storage         */
   bool waiting = false;                    /* waiting for sent data ack */
                                  /* limits on nondeterministic failures */
   byte lossCount = 0;               /* messages lost                    */
   bit reorderCount = 0;             /* instances of reordering          */
                                  /* temporary storage for reordering    */
   mtype tempm1, tempm2;             /* swap message type                */
   bit temps1, temps2;               /* swap sequence number             */

Active:
if
:: ! waiting -> 
   do
   :: dataDown[id]?data ->                                  /* send data */
      netTo[notId]!data,sendSeq; waiting = true; goto Active

   :: netTo[id]?data,inputSeq ->                 /* receive and ack data */
      if
      :: inputSeq == recvSeq 
         -> netTo[notId]!ackData,inputSeq; dataUp[id]!data; 
            recvSeq = 1-recvSeq
      :: inputSeq != recvSeq  /* code reachable only if waiting; Promela */
         -> netTo[notId]!ackData,inputSeq /* timeouts not 100% realistic */
      :: lossCount < 2               
         -> lossCount++                /* simulate network's losing data */
      fi
   od;
:: waiting ->
   do
   :: netTo[id]?ackData,inputSeq ->                  /* receive data ack */
      assert(inputSeq == sendSeq);
      if              
      :: true -> sendSeq = 1-sendSeq; waiting = false; goto Active
      :: lossCount < 2              /* simulate network's losing ackData */
         -> lossCount++
      fi

   :: timeout                              /* retransmit data on timeout */
      -> netTo[notId]!data,sendSeq

   :: netTo[id]?data,inputSeq ->                 /* receive and ack data */
      if
      :: inputSeq == recvSeq 
         -> netTo[notId]!ackData,inputSeq; dataUp[id]!data; 
            recvSeq = 1-recvSeq
      :: inputSeq != recvSeq             /* ackData was lost, retransmit */
         -> netTo[notId]!ackData,inputSeq
      :: lossCount < 2                 /* simulate network's losing data */
         -> lossCount++
      fi

   :: atomic{       /* simulate network's reordering messages in transit */
      reorderCount == 0 && len(netTo[id]) == 2
      -> netTo[id]?tempm1,temps1; netTo[id]?tempm2,temps2;
         netTo[id]!tempm2,temps2; netTo[id]!tempm1,temps1;
         reorderCount++
      } /* end atomic */
   od;
fi;
}

init { atomic { 
                run higherEndpoint(0);
                run lowerEndpoint(0,1);
                run lowerEndpoint(1,0);
                run higherEndpoint(1);
      }       }

/* ========================================================================
WHAT IS VERIFIED, AND HOW?  

The model passes a Spin safety check, which proves that assertions are 
satisfied and that the model has no invalid end states such as would be 
caused by deadlocks.  The check can be run on ispin with all default 
settings except for the following advanced parameters: Physical Memory 
Available 8192, Maximum Search Depth 1000000 (one million).

If you would like to look at the trace for any particular scenario,
simply put "assert(false)" in the code at the point where the scenario is 
detected and you want the trace to stop, then run a safety check.  The 
assertion will force Spin to report an error at that point, and you can
view the trace.

The safety check also yields a report of unreachable code.  Only one
guarded command is reported unreachable (noted in code), and that is 
because of the fact that Spin timeouts are not completely general (see
explanation above).  Another guarded command playing the same role in the
protocol is reachable, so the model is sufficiently general overall.

Here is a partial report on the safety check:

   (Spin Version 6.1.0 -- 4 May 2011)
	+ Partial Order Reduction
   Full statespace search for:
	never claim         	- (not selected)
	assertion violations	+
	cycle checks       	- (disabled by -DSAFETY)
	invalid end states	+

   State-vector 124 byte, depth reached 209483, errors: 0
   1.1832663e+08 transitions (= states stored + states matched)

   Stats on memory usage (in Megabytes):
   5772.984	total actual memory usage

   pan: elapsed time 231 seconds

In general, we would expect the size of the two network queues netTo[0] and
netTo[1] to be proportional to the network delay in relation to the speed
of the endpoints.  By limiting this size to 2, are we eliminating any
possible behaviors?  No, because there can never be more than two messages
in transit in either direction.  This is verified by raising the channel
size to 3 and re-running the safety check.  In this extra check, the size
of the reachable state space is exactly the same as before.

Last but not least, we must prove that the protocol always makes progress.
In the upper endpoint code, there is a "progress" label visited whenever
data is received.  A progress check in Spin verifies that the label is
visited infinitely often.  More specifically, this means that there are no
infinite loops in which the label is not visited.  Note that the model
would fail this check if message losses or reorderings were unbounded.

Here is a partial report on the progress check.

   (Spin Version 6.1.0 -- 4 May 2011)
	+ Partial Order Reduction
   Full statespace search for:
	never claim         	+ (:np_:)
	assertion violations	+ (if within scope of claim)
	non-progress cycles 	+ (fairness disabled)
	invalid end states	- (disabled by never claim)

   State-vector 132 byte, depth reached 614056, errors: 0
   3.4814127e+08 transitions (= states visited + states matched)

   Stats on memory usage (in Megabytes):
   11627.941	total actual memory usage

   pan: elapsed time 682 seconds
======================================================================== */
