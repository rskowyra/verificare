/* ========================================================================
DESCRIPTION

This model runs one invite dialog, in which a caller UA and a callee UA
communicate through two FIFO message channels.

This model uses a formal definition of user agents according to the basic
version of SIP as documented by RFC 3261, with the single addition of Info
requests.  The user agents are modeled at the level of the transaction 
user, so 100 messages, retransmissions, and acks sent in response to invite
failures are not included.
======================================================================== */

mtype = { 
   /* SIP messages */
      invite, ack, cancel, info, bye,
      prov18x, dialog183,
      inv200, invFail, invDVR, inv491, ackTimeout, canc200, cancDVR,
      infoDVR, infoRsp, bye200, byeDVR,
   /* SDP types */
      none, offer, answer,
   /* media states of a UA */
      noFlow, offering, offered, flow
}

chan left = [7] of {mtype,mtype};       /* these are maximum queue sizes */
chan right = [7] of {mtype,mtype};

#include "ua.pml"

init { atomic { run callerUA(left,right);
                run calleeUA(right,left)
              } }

/* ========================================================================
ANALYSIS

(Spin Version 5.1.3 -- 11 December 2007)
	+ Partial Order Reduction

Full statespace search for:
	never claim         	- (not selected)
	assertion violations	+
	cycle checks       	- (disabled by -DSAFETY)
	invalid end states	+

State-vector 80 byte, depth reached 7195, errors: 0
  1213057 states, stored
   905184 states, matched
  2118241 transitions (= stored+matched)
        1 atomic steps
hash conflicts:    936128 (resolved)

Stats on memory usage (in Megabytes):
  124.941	equivalent memory usage for states (stored*(State-vector + overhead))
  111.397	actual memory usage for states (compression: 89.16%)
         	state-vector as stored = 68 byte + 28 byte overhead
    4.000	memory used for hash table (-w19)
    4.578	memory used for DFS stack (-m100000)
  119.906	total actual memory usage
======================================================================== */
