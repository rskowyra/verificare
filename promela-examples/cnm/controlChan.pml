/* ========================================================================
MODEL OF A PERSISTENT CHANNEL WITH SUSPENSION
                                                 Copyright AT&T, 2011,2012.

This model is an appendix to the paper "Compositional Network Mobility"
by Pamela Zave and Jennifer Rexford.

WHAT IS MODELED?

Like the model in "dataChan.pml", this Promela code describes a two-way
data channel between two processes.  At each end there is a "higher
endpoint" process that acts as a source and sink of data, and a "lower
endpoint" process that interfaces with a network to send and receive 
messages.  The higher and lower processes at one end of the channel are on
the same machine, and communicate through the operating system of that 
machine.

The model "dataChan.pml" described how the processes behave in sending and
receiving data through the network.  This model leaves data out completely.
Rather, it focuses on the ability of the endpoint processes to suspend and
resume the channel at their endpoint.

To do this, the processes communicate through a pair of buffers "conUp" and
"conDown", on which they send control signals to each other.  It is not
possible to use a more synchronous mechanism such as procedure calls, 
because changes in the control status of an endpoint can be initiated by
either the higher or lower endpoint process.

Each control signal has two fields.  The first must be one of { suspend,
resume, suspendAck, convert }.  The second must be one of { detached,
attached, destroy, create }.  Their meaning is best understood from
Figure 7 of the paper, which shows the control states of a lower endpoint
and the transitions between them.  The second field of a control signal
corresponds to the labels in the figure.

If the first field of a control signal is one of { suspend, resume, 
convert } then it corresponds in Figure 7 to whether the transition goes
from an active state to a suspended state (suspend), from a suspended
state to an active state (resume), or from the suspended state "detached"
to the suspended state "dislocated" (convert).

If the first field of a control signal is "suspendAck", then the second
field does not matter and the signal does not appear in Figure 7.  A
process cannot resume after suspending until its "suspend" signal has been
acknowledged.  Otherwise a process could loop forever generating rapid
suspend/resume pairs.

A higher endpoint has fewer capabilities than a lower endpoint, but it has
the same control states.  This model is correct if the higher and lower
endpoints have the same control state, after signaling delays have been
taken into account.

The style of the lower endpoint may seem somewhat convoluted.  This is
necessitated by verification, as explained below, where we document what is
verified, and how.
======================================================================== */

mtype = { suspend, ackSuspend, resume, convert,         /* message types */
          detached, attached, destroy, create       /* message modifiers */
        }

chan conUp  [2] = [2] of {mtype,mtype};
chan conDown[2] = [2] of {mtype,mtype};

bool highSuspended[2]; 
bool lowSuspended[2]; 
bool highDislocated[2];  /* state variables only relevant when suspended */
bool lowDislocated[2];   /* dislocation takes precedence over detachment */

proctype higherEndpoint (bit id) {

   mtype inputType;                                 /* temporary storage */
   bool suspendAcked = true;                 /* for limiting resumptions */
   highSuspended[id] = false;       /* initialization of global variable */

   do                                                
   :: ! highSuspended[id]                                     /* suspend */
      -> conDown[id]!suspend,destroy; suspendAcked = false;
         highSuspended[id] = true; highDislocated[id] = true

   :: highSuspended[id] && highDislocated[id] && suspendAcked  /* resume */
      -> conDown[id]!resume,create; highSuspended[id] = false

   :: conUp[id]?ackSuspend,_ -> suspendAcked = true       /* receive ack */

   :: conUp[id]?suspend,inputType                        /* be suspended */
      -> if
         :: ! highSuspended[id]
            -> conDown[id]!ackSuspend,inputType; highSuspended[id] = true;
               if
               :: inputType == destroy -> highDislocated[id] = true
               :: inputType == detached -> highDislocated[id] = false
               fi
         :: else           
            -> suspendAcked = true; /* racing suspensions eliminate acks */
               assert(highDislocated[id])           /* dislocation takes */
         fi;                                 /* precedence, so no change */

   :: conUp[id]?resume,_                                   /* be resumed */
      -> if
         :: highSuspended[id] && suspendAcked -> highSuspended[id] = false
         :: else                         /* obsolete resumes are ignored */
         fi

   :: conUp[id]?convert,destroy -> highDislocated[id] = true       /* be */
                                             /* converted to dislocation */
   :: atomic{
      empty(conUp[id]) && empty(conDown[id])        /* check correctness */
      -> assert(highSuspended[id] == lowSuspended[id]);
      assert(!highSuspended[id] || (highDislocated[id]==lowDislocated[id]))
      }
   od;
}

proctype lowerEndpoint (bit id, notId) {

   mtype inputType;                                 /* temporary storage */
   bool suspendAcked = true;                 /* for limiting resumptions */
   lowSuspended[id] = false;        /* initialization of global variable */

Active:
assert(! lowSuspended[id]);
atomic {
if
:: nfull(conUp[id]) ->
   if                                             /* two ways to suspend */
   :: conUp[id]!suspend,detached
      -> suspendAcked = false; lowSuspended[id] = true; 
         lowDislocated[id] = false; goto Suspended

   :: conUp[id]!suspend,destroy
      -> suspendAcked = false; lowSuspended[id] = true; 
         lowDislocated[id] = true; goto Suspended
   fi

:: nempty(conDown[id]) && nfull(conUp[id]) ->
   if
   :: conDown[id]?resume,_                   /* obsolete resume, ignored */

   :: conDown[id]?suspend,destroy                        /* be suspended */
      -> conUp[id]!ackSuspend,destroy; lowSuspended[id] = true;
         lowDislocated[id] = true; goto Suspended
   fi

:: full(conUp[id]) && empty(conDown[id])      /* wait for upper endpoint */
fi;
} /* end atomic */
goto Active;
Suspended:
assert(lowSuspended[id]);
atomic {
if
:: nfull(conUp[id]) ->
   if
   :: ! lowDislocated[id]                      /* convert to dislocation */
      -> conUp[id]!convert,destroy; lowDislocated[id] = true

   :: suspendAcked && ! lowDislocated[id]                      /* resume */
      -> conUp[id]!resume,attached; lowSuspended[id] = false; 
         goto Active

   :: suspendAcked && lowDislocated[id]                        /* resume */
      -> conUp[id]!resume,create; lowSuspended[id] = false; goto Active

   :: else
   fi
:: nempty(conDown[id]) ->
   if
   :: conDown[id]?ackSuspend,_                      /* finish suspension */
      -> suspendAcked = true 

   :: conDown[id]?suspend,destroy                   /* racing suspension */
      -> suspendAcked = true;       /* racing suspensions eliminate acks */
         lowDislocated[id] = true        /* dislocation takes precedence */

   :: conDown[id]?resume,create                            /* be resumed */
      -> if
         :: suspendAcked -> lowSuspended[id] = false; goto Active
         :: else                         /* obsolete resumes are ignored */
         fi
   fi 
:: full(conUp[id]) && empty(conDown[id])      /* wait for upper endpoint */
fi; 
} /* end atomic */
goto Suspended
}

init { atomic { 
                run higherEndpoint(0);  
                run lowerEndpoint(0,1);
      }       }

/* ========================================================================
WHAT IS VERIFIED, AND HOW?

In this model the two channel endpoints do not communicate with each other.
Because they are modeled by the same Promela code, we know that their
behavior is identical.  Therefore we only check one endpoint with Spin.

As stated above, the model is correct if higher and lower processes have
the same control state.  This invariant can be checked with the following
two assertions:

   assert(highSuspended[id] == lowSuspended[id]);
   assert(!highSuspended[id] || (highDislocated[id] == lowDislocated[id]))

The detached/dislocated value only matters when the endpoint is suspended.
The control states of the endpoints are stored in global variables so that
any process can read them.  For convenience, the higher endpoint checks
the invariant at nondeterministically chosen times.

The difficulty is that we cannot expect the invariant to hold when there
are control signals in the buffers.  Similarly, we cannot expect the
invariant to hold after a process has read a control signal, but before it
has processed the signal by updating its control state.  Most of the
complexity in this model arises from the need to check the invariant only
at the right times, to avoid false negatives.

In the higher endpoint process, the invariant should only be checked when
both control buffers are empty.  Also, it should not be possible to run
another process between ascertaining that the buffers are empty and
actually checking the invariant.  In Promela both goals are accomplished
with this guarded command:

   :: atomic{
      empty(conUp[id]) && empty(conDown[id]) -> CHECK INVARIANT
      }

Surrounding code with "atomic{ }" is very useful, but it must be used with
extreme care to achieve the desired effect.  Consider the following
guarded command:

   :: atomic{
      conUp[id]!suspend,destroy
      -> lowSuspended[id] = true; lowDislocated[id] = true
      }

It might seem safe to assume that the invariant will not be checked between
execution of the two lines of code, but this assumption would be false.  
The write statement "conUp[id]!suspend,destroy" might be temporarily not
executable because buffer "conUp[id]" is full.  If Spin execution enters 
this statement at a time that the write statement is not executable, then
THE ATOMICITY IS LOST.  Later, the write statement will become executable 
and the entire guarded command will be executed, but it will not be
executed atomically.

To prevent such anomalies, the code for the lower endpoint is structured
in such a way that execution never enters an atomic region unless it is
guaranteed that a guarded command within the region is immediately 
executable.  This is done by checking ahead that buffers to be read are not
empty, and buffers to be written are not full.

The control buffers must be at least length 2 to prevent deadlock.  They
can be bigger, with the advantage of reducing blocking, and the 
disadvantage of increasing the delay of synchronization between upper and
lower endpoint states.

Correctness of this model is a safety property, i.e., that the invariant
is never violated.  It can be verified with a default safety check in
ispin.  Here is a partial report on the safety check:

(Spin Version 6.1.0 -- 4 May 2011)
	+ Partial Order Reduction
   Full statespace search for:
	never claim         	- (not selected)
	assertion violations	+
	cycle checks       	- (disabled by -DSAFETY)
	invalid end states	+

   State-vector 84 byte, depth reached 715, errors: 0
      3776 transitions (= states stored + states matched)

   Stats on memory usage (in Megabytes):
      4.827	total actual memory usage

   pan: elapsed time 0.01 seconds
======================================================================== */
