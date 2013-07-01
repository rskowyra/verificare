/* ========================================================================
MODEL OF A PERSISTENT CHANNEL WITH DATA AND SUSPENSION
                                                 Copyright AT&T, 2011,2012.

This model is an appendix to the paper "Compositional Network Mobility"
by Pamela Zave and Jennifer Rexford.

WHAT IS MODELED?

This model combines "dataChan.pml" and "controlChan.pml", resulting in a
persistent channel that can be suspended at either endpoint.

When the channel is suspended at an endpoint, that endpoint does not send
messages through the network, and messages in transit to it through the
network are lost.  The loss behavior is simulated at the suspended 
endpoint, when the messages are received.

To simplify the model, network message reordering (which causes no
problems) and loss of network messages to active endpoints (which is
handled satisfactorily by the protocol) have been removed.  These were
removed from the part of the modeled inherited from "dataChan.pml".

To simplify the model, we have also removed parts of the model inherited
from "controlChan.pml".  We have removed the distinction between "detached"
and "dislocated" suspended states, and everything necessary to maintain
that distinction.  We have also removed all the atomicity machinery needed
to check the invariant on endpoint control states.  

Finally, "thisSuspendedOnce" in the higher endpoint is initialized to true.
This means that a higher endpoint cannot initiate suspension.  Each lower
endpoint can initiate a suspension, and it makes no difference to data
transmission which part of an endpoint initiates suspension.

See below for information about what is verified, and how.
======================================================================== */

mtype = { data, ackData,
          suspend, ackSuspend, resume 
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

   do                                                
   :: nfull(dataDown[id]) && nfull(dataUp[id])              /* send data */
      -> dataDown[id]!data

   :: dataUp[id]?data -> progress: skip                  /* receive data */

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
   od;
}

proctype lowerEndpoint (bit id, notId) {
                                         /* reliability protocol:        */
   bit sendSeq = 0;                         /* sending sequence number   */
   bit recvSeq = 0;                         /* receiving sequence number */
   bit inputSeq = 0;                        /* temporary storage         */
   bool waiting = false;                    /* waiting for sent data ack */

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

The model passes the same basic safety and progress checks as
"dataChan.pml".  The results of these checks are summarized below.

Just as "dataChan.pml" would not pass a progress check if it had unbounded
message losses, this model would not pass a progress check it had unbounded
suspensions.  For that reason, each of the two endpoints can initiate a
suspension at most once.

In this context, it might seem strange that this model has no counters to
bound the number of message losses due to suspension.  The number of
message losses is already bounded, however, by the behavior of the model.
A suspended endpoint sends no network messages.  The other endpoint cannot
send new data and acknowledgments without receiving acknowledgments and
data.  So, after a short time, a suspended endpoint runs out of messages
to lose.

This model passed the progress check on the first try.  This is gratifying,
but it is always best to be skeptical.  What if there is a flaw in the
model such that passing the progress check is meaningless?  To guard
against that possibility, it is best to introduce a deliberate error, run
the check again, and make sure that it fails.  

To perform this model-validation step, we can introduce the deliberate 
error that once an endpoint has been suspended, after it resumes, the lower
endpoint "forgets" to pass correctly received data to the higher endpoint.
Sure enough, the altered model fails the progress check.  Once an endpoint 
has been suspended, execution can start in a reachable state, send data to
that endpoint, and return to the same reachable state, without visiting a
progress label.  This means that the modeled system could traverse that
loop infinitely often without making progress.

Here is a partial report on the safety check:

   (Spin Version 6.1.0 -- 4 May 2011)
	+ Partial Order Reduction

   Full statespace search for:
	never claim         	- (not selected)
	assertion violations	+
	cycle checks       	- (disabled by -DSAFETY)
	invalid end states	+

   State-vector 164 byte, depth reached 150089, errors: 0
   4.3112144e+08 transitions (= states stored + states matched)

   Stats on memory usage (in Megabytes):
   22985.265	total actual memory usage

   pan: elapsed time 971 seconds

Here is a partial report on the progress check.  Note that compression was
used to save space.  It causes relatively little slowdown.

   (Spin Version 6.1.0 -- 4 May 2011)
	+ Partial Order Reduction
	+ Compression

   Full statespace search for:
	never claim         	+ (:np_:)
	assertion violations	+ (if within scope of claim)
	non-progress cycles 	+ (fairness disabled)
	invalid end states	- (disabled by never claim)

   State-vector 172 byte, depth reached 366456, errors: 0
   1.859088e+09 transitions (= states visited + states matched)

   Stats on memory usage (in Megabytes):
   25979.214	total actual memory usage

   pan: elapsed time 6.02e+03 seconds
======================================================================== */
