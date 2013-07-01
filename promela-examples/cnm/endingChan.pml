/* ========================================================================
MODEL OF A TRANSIENT CHANNEL WITH DATA AND SUSPENSION
                                                 Copyright AT&T, 2011,2012.

This model is an appendix to the paper "Compositional Network Mobility"
by Pamela Zave and Jennifer Rexford.

WHAT IS MODELED?

This model is derived from "combinedChan.pml" by giving the upper endpoints
the ability to destroy the channel.  Lower endpoints do not have the power
to destroy a channel on their own volition.  The purpose of this model is
to show how the channel can be terminated cleanly and correctly.

The "progress" label has been removed from the upper endpoint, because this
model requires only safety checking.

An upper endpoint can choose to destroy the channel at a time when it is 
suspended at that endpoint.  In this case, the lower endpoint cannot 
complete its cleanup duties until network connectivity is restored.

This model introduces two new messages which are used for communication
both between upper and lower processes at the same end of the channel, and
between the two endpoints of the channel.  Because these messages share the
network channels with data messages, possible reordering of messages in
transit becomes significant.  For this reason, the lower endpoint processes
simulate reordering of messages in transit.

See below for information about what is verified, and how.
======================================================================== */

mtype = { data, ackData,
          suspend, ackSuspend, resume,
          endChan, ackEnd
        }

chan conUp  [2] = [2] of {mtype};
chan conDown[2] = [2] of {mtype};
chan dataUp  [2] = [2] of {mtype};
chan dataDown[2] = [2] of {mtype};
chan netTo[2] = [2] of {mtype,bit};

bool highSuspended[2]; 
bool lowSuspended[2]; 

proctype higherEndpoint (bit id) {

   bool thisSuspendedOnce = true;            /* for limiting suspensions */
   bool suspendAcked = true;                 /* for limiting resumptions */
   highSuspended[id] = false;       /* initialization of global variable */
Linked:
   do                                                
   :: nfull(dataDown[id]) && nfull(dataUp[id])              /* send data */
      -> dataDown[id]!data

   :: dataUp[id]?data                                    /* receive data */

   :: ! highSuspended[id] && ! thisSuspendedOnce              /* suspend */
      -> conDown[id]!suspend; suspendAcked = false;
         highSuspended[id] = true; thisSuspendedOnce = true

   :: highSuspended[id] && suspendAcked                        /* resume */
      -> conDown[id]!resume; highSuspended[id] = false

   :: conUp[id]?ackSuspend -> suspendAcked = true         /* receive ack */

   :: conUp[id]?suspend                                  /* be suspended */
      -> if
         :: ! highSuspended[id]
            -> conDown[id]!ackSuspend; highSuspended[id] = true;
         :: else
            -> suspendAcked = true  /* racing suspensions eliminate acks */
         fi;

   :: conUp[id]?resume                                     /* be resumed */
      -> if
         :: highSuspended[id] && suspendAcked -> highSuspended[id] = false
         :: else                         /* obsolete resumes are ignored */
         fi

   :: conDown[id]!endChan; goto Ending                    /* end channel */

   :: conUp[id]?endChan; conDown[id]!ackEnd; goto end        /* be ended */
   od;
Ending:
   do
   :: conUp[id]?ackEnd; goto end
   :: conUp[id]?endChan; conDown[id]!ackEnd
   :: conUp[id]?suspend
   :: conUp[id]?ackSuspend
   :: conUp[id]?resume
   :: dataUp[id]?data
   od;
end: 
   do
   :: dataUp[id]?data
   od
}

proctype lowerEndpoint (bit id, notId) {
                                         /* reliability protocol:        */
   bit sendSeq = 0;                         /* sending sequence number   */
   bit recvSeq = 0;                         /* receiving sequence number */
   bit inputSeq = 0;                        /* temporary storage         */
   bool waiting = false;                    /* waiting for sent data ack */
                                  /* temporary storage for reordering    */
   mtype tempm1, tempm2;             /* swap message type                */
   bit temps1, temps2;               /* swap sequence number             */

   bool reorderedOnce = false;               /* for limiting reorderings */
   bool thisSuspendedOnce = false;           /* for limiting suspensions */
   bool suspendAcked = true;                 /* for limiting resumptions */
   lowSuspended[id] = false;        /* initialization of global variable */

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
      :: else                 /* code reachable only if waiting; Promela */
         -> netTo[notId]!ackData,inputSeq /* timeouts not 100% realistic */
      fi

   :: ! thisSuspendedOnce ->                                  /* suspend */
         conUp[id]!suspend; suspendAcked = false; thisSuspendedOnce = true;
         lowSuspended[id] = true; goto Suspended

   :: conDown[id]?suspend ->                             /* be suspended */
         conUp[id]!ackSuspend; lowSuspended[id] = true; goto Suspended

   :: conDown[id]?resume                     /* obsolete resume, ignored */

   :: conDown[id]?endChan; netTo[notId]!endChan,0; goto Ending
   :: netTo[id]?endChan,_; conUp[id]!endChan; goto Ended

   :: atomic{       /* simulate network's reordering messages in transit */
      ! reorderedOnce && len(netTo[id]) == 2
      -> netTo[id]?tempm1,temps1; netTo[id]?tempm2,temps2;
         if
         :: tempm1 == endChan || tempm1 == ackEnd ||
            tempm2 == endChan || tempm2 == ackEnd
            -> netTo[id]!tempm2,temps2; netTo[id]!tempm1,temps1;
               reorderedOnce = true
         :: else  /* reordering data messages has no effect, don't do it */
            -> netTo[id]!tempm1,temps1; netTo[id]!tempm2,temps2;
         fi
      } /* end atomic */
   od;
:: waiting ->
   do
   :: netTo[id]?ackData,inputSeq ->                  /* receive data ack */
      -> sendSeq = 1-sendSeq; waiting = false; goto Active

   :: timeout ->                           /* retransmit data on timeout */
         netTo[notId]!data,sendSeq

   :: netTo[id]?data,inputSeq ->                 /* receive and ack data */
      if
      :: inputSeq == recvSeq 
         -> netTo[notId]!ackData,inputSeq; dataUp[id]!data;
            recvSeq = 1-recvSeq
      :: else                            /* ackData was lost, retransmit */
         -> netTo[notId]!ackData,inputSeq
      fi

   :: ! thisSuspendedOnce ->                                  /* suspend */
         conUp[id]!suspend; suspendAcked = false; thisSuspendedOnce = true;
         lowSuspended[id] = true; goto Suspended

   :: conDown[id]?suspend ->                             /* be suspended */
         conUp[id]!ackSuspend; lowSuspended[id] = true; goto Suspended

   :: conDown[id]?resume                     /* obsolete resume, ignored */

   :: conDown[id]?endChan; netTo[notId]!endChan,0; goto Ending
   :: netTo[id]?endChan,_; conUp[id]!endChan; goto Ended

   :: atomic{       /* simulate network's reordering messages in transit */
      ! reorderedOnce && len(netTo[id]) == 2
      -> netTo[id]?tempm1,temps1; netTo[id]?tempm2,temps2;
         if
         :: tempm1 == endChan || tempm1 == ackEnd ||
            tempm2 == endChan || tempm2 == ackEnd
            -> netTo[id]!tempm2,temps2; netTo[id]!tempm1,temps1;
               reorderedOnce = true
         :: else  /* reordering data messages has no effect, don't do it */
            -> netTo[id]!tempm1,temps1; netTo[id]!tempm2,temps2;
         fi
      } /* end atomic */
   od;
fi;
Suspended:
   do
   :: netTo[id]?data,inputSeq          /* message lost during suspension */

   :: netTo[id]?ackData,inputSeq       /* message lost during suspension */

   :: conDown[id]?ackSuspend -> suspendAcked = true /* finish suspension */

   :: conDown[id]?suspend -> suspendAcked = true    /* racing suspension */
                                    /* racing suspensions eliminate acks */

   :: suspendAcked ->                                          /* resume */
         conUp[id]!resume; lowSuspended[id] = false; goto Active

   :: conDown[id]?resume ->                                /* be resumed */
      if
      :: suspendAcked -> lowSuspended[id] = false; goto Active
      :: else                            /* obsolete resumes are ignored */
      fi

   :: netTo[id]?endChan,_              /* message lost during suspension */

   :: conDown[id]?endChan -> goto EndingSuspended
   od; 
EndingSuspended:
   do
   :: netTo[id]?data,inputSeq          /* message lost during suspension */
   :: netTo[id]?ackData,inputSeq       /* message lost during suspension */
   :: netTo[id]?endChan,_              /* message lost during suspension */
   :: netTo[notId]!endChan,0  -> goto Ending    /* executable only when  */
                                                /* connectivity restored */
   :: atomic{       /* simulate network's reordering messages in transit */
      ! reorderedOnce && len(netTo[id]) == 2
      -> netTo[id]?tempm1,temps1; netTo[id]?tempm2,temps2;
         if
         :: tempm1 == endChan || tempm1 == ackEnd ||
            tempm2 == endChan || tempm2 == ackEnd
            -> netTo[id]!tempm2,temps2; netTo[id]!tempm1,temps1;
               reorderedOnce = true
         :: else  /* reordering data messages has no effect, don't do it */
            -> netTo[id]!tempm1,temps1; netTo[id]!tempm2,temps2;
         fi
      } /* end atomic */
   od;       
Ending:
   do
   :: netTo[id]?ackEnd,_ -> conUp[id]!ackEnd; goto end
   :: netTo[id]?endChan,_ -> netTo[notId]!ackEnd,0
   :: netTo[id]?data,inputSeq
   :: netTo[id]?ackData,inputSeq
   :: timeout -> netTo[notId]!endChan,0   /* retransmit lost end message */

   :: atomic{       /* simulate network's reordering messages in transit */
      ! reorderedOnce && len(netTo[id]) == 2
      -> netTo[id]?tempm1,temps1; netTo[id]?tempm2,temps2;
         if
         :: tempm1 == endChan || tempm1 == ackEnd ||
            tempm2 == endChan || tempm2 == ackEnd
            -> netTo[id]!tempm2,temps2; netTo[id]!tempm1,temps1;
               reorderedOnce = true
         :: else  /* reordering data messages has no effect, don't do it */
            -> netTo[id]!tempm1,temps1; netTo[id]!tempm2,temps2;
         fi
      } /* end atomic */
   od;
Ended:
   do
   :: conDown[id]?ackEnd -> netTo[notId]!ackEnd,0; goto end
   :: conDown[id]?suspend
   :: conDown[id]?ackSuspend
   :: conDown[id]?resume
   :: conDown[id]?endChan -> conUp[id]!ackEnd
   od;
end: 
   do
   :: dataDown[id]?data       /* clean dataDown, regardless of how ended */
   :: netTo[id]?data,_
   :: netTo[id]?ackData,_
   :: netTo[id]?endChan,_ -> netTo[notId]!ackEnd,0
   od;
}

init { atomic { 
                run higherEndpoint(0);  
                run lowerEndpoint(0,1);
                run lowerEndpoint(1,0);
                run higherEndpoint(1);
      }       }

/* ========================================================================
WHAT IS VERIFIED, AND HOW?

For this model, only safety properties are important.  Once one of the
upper endpoint processes has decided to destroy the channel, progress is no
longer expected or required.

For the first time in this series of models, we expect some executions to
terminate and care about final states.  In Promela, the name of a valid
final state of a process begins with the string "end".  An execution trace
with a final state--in which no further execution is possible--is 
considered valid if and only if every process is in an "end-" state.

As an addition to this, safety checks should be run with the -q extra
run-time option (under Advanced Parameters).  With this option, for a final
execution state to be valid, all its queues must be empty.  With this extra
check, we know that the model accounts for every possible message.

===========================================================================
Here is an abbreviated report on a safety check without reordering:

   (Spin Version 6.1.0 -- 4 May 2011)
	+ Partial Order Reduction

   Full statespace search for:
	never claim         	- (not selected)
	assertion violations	+
	cycle checks       	- (disabled by -DSAFETY)
	invalid end states	+

   State-vector 164 byte, depth reached 73153, errors: 0
        1.0508768e+09 transitions (= states stored + states matched)

   Stats on memory usage (in Megabytes):
        52427.236	total actual memory usage

   pan: elapsed time 2.52e+03 seconds
===========================================================================
Once reordering is allowed, it becomes very difficult to analyze this
model.  We report on two approaches here.  First, here is a complete report
on a normal safety check with collapse compression.  For this run, we 
altered the model so that there could only be reordering at one endpoint.
Note that advanced parameters were set as follows:
   Physical memory 65536
   State space size 100000000 (100 M)
   Search depth 10000000 (10 M)
   Extra run-time options -q
Although this run did not complete because it ran out of memory, at least
analysis reached every statement in the code.

pan: reached -DMEMLIM bound
	6.87194e+10 bytes used
	102400 bytes more needed
	6.87195e+10 bytes limit
hint: to reduce memory, recompile with
  -DMA=164   # better/slower compression, or
  -DBITSTATE # supertrace, approximation

(Spin Version 6.1.0 -- 4 May 2011)
Warning: Search not completed
	+ Partial Order Reduction
	+ Compression

Full statespace search for:
	never claim         	- (not selected)
	assertion violations	+
	cycle checks       	- (disabled by -DSAFETY)
	invalid end states	+

State-vector 164 byte, depth reached 578827, errors: 0
1.1438511e+09 states, stored
2.3679552e+09 states, matched
3.5118063e+09 transitions (= stored+matched)
2.2383236e+08 atomic steps
hash conflicts: 1.8164076e+09 (resolved)

Stats on memory usage (in Megabytes):
209445.399	equivalent memory usage for states (stored*(State-vector + overhead))
48618.852	actual memory usage for states (compression: 23.21%)
         	state-vector as stored = 17 byte + 28 byte overhead
16384.000	memory used for hash table (-w31)
  534.058	memory used for DFS stack (-m10000000)
65535.968	total actual memory usage

nr of templates: [ globals chans procs ]
collapse counts: [ 2403725 28 6111 2 ]

pan: elapsed time 1.3e+04 seconds
No errors found -- did you verify all claims?
===========================================================================
Second, here is a complete report of a supertrace run with reordering at
both ends.  Supertrace does heuristic, rather than exhaustive, search of
the state space.  To get this output, the advanced parameters were:
   Physical memory 65536
   State space size 100000000 (100 M)
   Search depth 10000000 (10 M)
   Nr hash-functions 4
   Extra run-time options -q

Although this run completed, the coverage of the model is not great, as
indicated by both the "hash factor" and the unreached code.

(Spin Version 6.1.0 -- 4 May 2011)
	+ Partial Order Reduction

Bit statespace search for:
	never claim         	- (not selected)
	assertion violations	+
	cycle checks       	- (disabled by -DSAFETY)
	invalid end states	+

State-vector 164 byte, depth reached 4585054, errors: 0
2.7118939e+10 states, stored
5.7763391e+10 states, matched
8.488233e+10 transitions (= stored+matched)
5.2014608e+09 atomic steps

hash factor: 5.06801 (best if > 100.)

bits set per state: 4 (-k4)

Stats on memory usage (in Megabytes):
4758724.920	equivalent memory usage for states (stored*(State-vector + overhead))
16384.000	memory used for hash array (-w37)
  762.939	memory used for bit stack
 5340.576	memory used for DFS stack (-m100000000)
  812.651	other (proc and chan stacks)
23300.992	total actual memory usage

unreached in proctype higherEndpoint
	endingChan.pml:59, state 6, "conDown[id]!suspend"
	endingChan.pml:59, state 7, "suspendAcked = 0"
	endingChan.pml:60, state 8, "highSuspended[id] = 1"
	endingChan.pml:60, state 9, "thisSuspendedOnce = 1"
	endingChan.pml:65, state 14, "suspendAcked = 1"
	endingChan.pml:72, state 20, "suspendAcked = 1"
	endingChan.pml:98, state 52, "-end-"
	(7 of 52 states)
unreached in proctype lowerEndpoint
	endingChan.pml:128, state 13, "netTo[notId]!ackData,inputSeq"
	endingChan.pml:136, state 23, "conUp[id]!ackSuspend"
	endingChan.pml:136, state 24, "lowSuspended[id] = 1"
	endingChan.pml:152, state 41, "netTo[id]!tempm1,temps1"
	endingChan.pml:152, state 42, "netTo[id]!tempm2,temps2"
	endingChan.pml:162, state 55, "netTo[notId]!data,sendSeq"
	endingChan.pml:170, state 62, "netTo[notId]!ackData,inputSeq"
	endingChan.pml:178, state 72, "conUp[id]!ackSuspend"
	endingChan.pml:178, state 73, "lowSuspended[id] = 1"
	endingChan.pml:207, state 105, "suspendAcked = 1"
	endingChan.pml:279, state 188, "-end-"
	(11 of 188 states)
unreached in init
	(0 of 6 states)

pan: elapsed time 2.6e+05 seconds (72 hours)
===========================================================================
Finally, note that we tried a safety check with both minimized automata and
collapse compression.  It was so slow that it ran for 3 weeks, then died
because of a system failure.
======================================================================== */
