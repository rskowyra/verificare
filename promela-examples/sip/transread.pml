/* ========================================================================
TRANSACTION-ORDERED MODEL OF INVITE DIALOGS IN SIP, WITH SOME ASSERTIONS

Copyright AT&T Laboratories, Inc., 2008.

PROVENANCE

This model is based on "basicraw.pml", the basic model of invite dialogs in
SIP.  The difference is that this model follows the recommendations in
Section 18 of RFC 3261 that:
 * TCP should be used for signal transport.
 * An invite dialog should have at most two TCP connections at any time,
   one for transactions initiated by the UAC, and one for transactions
   initiated by the UAS.

In the basic model, Problems 1, 3, 4, and 5 are due to the re-ordering of
messages in transit from one UA to the other.  The change from the basic
model to this model eliminates Problems 4 and 5, but does not eliminate
Problems 1 and 3.

DEFINITION OF MESSAGE TYPES

Requests
   invite
   prack
   update
   ack
   cancel
   info
   bye

Provisional Responses
   unProv (any unreliable 1xx in response to an invite)
   relProv (any reliable 1xx in response to an invite)

Final Responses                                            ** SIP note 4 **
   invSucc (any 2xx in response to an invite)
   invFail (any 3xx-6xx message in response to an invite)
   prackRsp (200(OK) in response to a prack)
   cancRsp (200(OK) in response to a cancel)
   updSucc (200(OK) in response to an update)
   updFail (491 in response to an update)
   infoRsp (200(OK) in response to an info)
   byeRsp (200(OK) in response to a bye)

OMISSIONS
 * A UAS never sends a subsequent relProv until it has received a prack
   for the previous one.  This is recommended by RFC 3262.
 * A user agent does not send update requests within confirmed dialogs,
   using re-invites instead.  This is recommended by RFC 3311.
 * Unreliable provisional responses do not have SDP fields.  RFC 3262 says
   that reliability is required for offer/answer exchange, and that
   reliability is available in the form of reliable provisional responses.

MODEL CHECKING of transraw.pml

For purposes of model-checking only, 
... a UAS is limited to one unreliable provisional response,
... a UA is limited to one info request.
======================================================================== */

mtype = {
   /* SIP messages */
      invite, prack, update, ack, cancel, info, bye, unProv, relProv,
      invSucc, invFail, prackRsp, cancRsp, updSucc, updFail,
      infoRsp, byeRsp,
   /* SDP types needed */
      none, offer, answer,
   /* media states of a UA */
      noFlow, offering, offered, flow }

chan cc2s = [6] of {mtype,mtype}; /* maximal queue length */
chan cs2c = [7] of {mtype,mtype}; /* maximal queue length */
chan ss2c = [4] of {mtype,mtype}; /* maximal queue length */
chan sc2s = [3] of {mtype,mtype}; /* maximal queue length */

proctype UAC() {
/* media state */
   mtype media = noFlow;
   mtype sdp, bufsdp;
/* state relevant to the inviting phase */
   bool dialog = false;
   bool initOffering = false;
   bool relProvBuffered = false;
/* state relevant to the confirmed phase (at most one is true) */
   bool reInviting = false;
   bool reInvited = false;
   bool reInviteBuffered = false;
/* state of acknowledgments */
   byte prackRspDiff = 0;
   bool updRsped = true;
   byte ackDiff = 0;
   bool infoRsped = true;    /* should be Diff, but infos limited to one */
/* state for limiting numbers of messages */
   bool infoSent = false;
           do
           :: cc2s!invite,offer; media = offering; initOffering = true;
              goto inviting
           :: cc2s!invite,none; goto inviting
           od;
inviting:  do
           :: ss2c?update,sdp; 
              assert(dialog && !initOffering && !relProvBuffered && 
                                                             sdp == offer);
              if
              :: media == offering; sc2s!updFail,none
              :: media == flow; sc2s!updSucc,answer
              fi
           :: ss2c?info,none;
              if
              :: dialog; cc2s!infoRsp,none
              :: !dialog; cc2s!infoRsp,none             /* SIP problem 1 */
              fi
           :: cs2c?unProv,none; dialog = true
           :: cs2c?relProv,sdp; assert(!relProvBuffered); dialog = true;
              if
              :: (media == noFlow || media == flow) && sdp != none;
                 assert(!initOffering && sdp == offer);
                 cc2s!prack,answer; prackRspDiff++; media = flow
              :: media == offering && sdp != none;
                 if
                 :: !initOffering;                      /* SIP problem 6 */
                    assert(sdp == offer); relProvBuffered = true
                 :: initOffering; assert(sdp == answer);
                    initOffering = false;
                    if
                    :: true; cc2s!prack,offer; prackRspDiff++; 
                             media = offering
                    :: true; cc2s!prack,none; prackRspDiff++; media = flow
                    fi
                 fi
              :: sdp == none; cc2s!prack,none; prackRspDiff++
              fi
           :: cs2c?prackRsp,sdp; assert(dialog && prackRspDiff > 0); 
              prackRspDiff--;
              if
              :: media == offering && sdp != none; assert(sdp == answer); 
                 media = flow
              :: media == offering && sdp == none
              :: media != offering; assert(sdp == none)
              fi
           :: cs2c?updSucc,sdp; 
              assert(dialog && !updRsped && sdp == answer &&
                   !relProvBuffered && !initOffering && media == offering);
              media = flow; updRsped = true
           :: cs2c?updFail,none;                        /* SIP problem 6 */
              assert(dialog && !updRsped && !initOffering &&
                                                        media == offering);
              media = flow; updRsped = true;
              if 
              :: relProvBuffered; cc2s!prack,answer; prackRspDiff++; 
                 relProvBuffered = false
              :: else
              fi
           :: cs2c?invFail,none; goto end
           :: cs2c?invSucc,sdp; assert(!relProvBuffered); dialog = true;
              if
              :: media == noFlow; assert(!initOffering && sdp == offer);
                 cc2s!ack,answer; media = flow
              :: media == flow; assert(!initOffering && sdp == none);
                 cc2s!ack,none
              :: media == offering && sdp == none; 
                 assert(!initOffering); cc2s!ack,none
              :: media == offering && sdp != none; 
                 assert(initOffering && sdp == answer);
                 cc2s!ack,none; media = flow
              fi;
              goto confirmed   
           :: cs2c?infoRsp,none; assert(dialog && !infoRsped); 
              infoRsped = true
           :: dialog && media == flow && updRsped;
              cc2s!update,offer; media = offering; updRsped = false
           :: dialog && !infoSent; cc2s!info,none; infoSent = true;
              infoRsped = false
           :: cc2s!cancel,none; goto canceling
           :: dialog; cc2s!bye,none; goto byeing           /* SIP note 5 */
           od;
confirmed: do
           :: ss2c?invite,sdp; assert(!reInviteBuffered && !reInvited);
              if
              :: reInviting; sc2s!invFail,none
              :: !reInviting && media != flow;          /* SIP problem 3 */
                 reInviteBuffered = true; bufsdp = sdp
              :: !reInviting && media == flow; reInvited = true;
                 if
                 :: sdp != none; assert(sdp == offer); media = offered
                 :: sdp == none
                 fi
              fi
           :: ss2c?info,none; cc2s!infoRsp,none
           :: ss2c?bye,none; sc2s!byeRsp,none; goto end
           :: cs2c?unProv,none
           :: cs2c?updSucc,sdp; 
              assert(!reInviting && !reInvited && !updRsped && 
                                       sdp == answer && media == offering);
              media = flow; updRsped = true; goto unbuffring
           :: cs2c?invFail,none; 
              assert(reInviting && !reInvited && !reInviteBuffered);
              reInviting = false;
              if :: media == offering; media = flow :: else fi
           :: cs2c?invSucc,sdp; 
              assert(reInviting && !reInvited && !reInviteBuffered && 
                                                              sdp != none);
              if
              :: media == flow; assert(sdp == offer); media = offered
              :: media == offering; assert(sdp == answer);
                 cc2s!ack,none; media = flow; reInviting = false;
              fi
           :: ss2c?ack,sdp; assert(ackDiff > 0); ackDiff--;
              assert( !reInviting || (reInviting && sdp == none) ); 
              if
              :: sdp != none; 
                 assert(!reInvited && media == offering && sdp == answer);
                 media = flow
              :: sdp == none
              fi;
              goto unbuffring
           :: cs2c?infoRsp,none; assert(dialog && !infoRsped); 
              infoRsped = true
           :: !infoSent; cc2s!info,none; infoSent = true; infoRsped = false
           :: reInviting && media == offered;
              cc2s!ack,answer; media = flow; reInviting = false
           :: !reInviting && !reInvited && media == flow;
              cc2s!invite,offer; reInviting = true; media = offering
           :: !reInviting && !reInvited && media == flow;
              cc2s!invite,none; reInviting = true          /* SIP note 2 */
           :: reInvited; reInvited = false; ackDiff++;
              if
              :: media == flow; sc2s!invSucc,offer; media = offering
              :: media == offered; sc2s!invSucc,answer; media = flow
              fi
           :: cc2s!bye,none; goto byeing
           od; 
unbuffring:if
           :: reInviteBuffered && media == flow; reInvited = true; 
              reInviteBuffered = false;
              if
              :: bufsdp != none; assert(bufsdp == offer); media = offered
              :: bufsdp == none
              fi
           :: reInviteBuffered && media != flow
           :: !reInviteBuffered
           fi; 
           goto confirmed;
canceling: do
           :: ss2c?update,sdp
           :: ss2c?info,none
           :: cs2c?unProv,none
           :: cs2c?relProv,sdp
           :: cs2c?prackRsp,sdp; assert(prackRspDiff > 0); prackRspDiff--
           :: cs2c?cancRsp,none
           :: cs2c?updSucc,sdp; assert(!updRsped); updRsped = true
           :: cs2c?updFail,sdp; assert(!updRsped); updRsped = true
           :: cs2c?invFail,none; goto end
           :: cs2c?invSucc,sdp; cc2s!bye,none; goto byeing
           :: cs2c?infoRsp,none; assert(!infoRsped); infoRsped = true
           od;
byeing:    do
           :: ss2c?invite,sdp
           :: ss2c?update,sdp
           :: ss2c?info,none
           :: ss2c?bye,none; sc2s!byeRsp,none
           :: cs2c?unProv,none
           :: cs2c?relProv,sdp
           :: cs2c?prackRsp,sdp; assert(prackRspDiff > 0); prackRspDiff--
           :: cs2c?cancRsp,none
           :: cs2c?updSucc,sdp; assert(!updRsped); updRsped = true
           :: cs2c?updFail,sdp; assert(!updRsped); updRsped = true
           :: cs2c?invFail,none
           :: cs2c?invSucc,sdp
           :: ss2c?ack,sdp; assert(ackDiff > 0); ackDiff--
           :: cs2c?infoRsp,none; assert(!infoRsped); infoRsped = true
           :: cs2c?byeRsp,none; goto end
           od;
end:       do
           :: ss2c?invite,sdp
           :: ss2c?update,sdp
           :: ss2c?info,none
           :: ss2c?bye,none; sc2s!byeRsp,none
           :: cs2c?updSucc,sdp; assert(!updRsped); updRsped = true
           :: cs2c?invFail,none
           :: cs2c?invSucc,sdp
           :: ss2c?ack,sdp; assert(ackDiff > 0); ackDiff--
           :: cs2c?infoRsp,none; assert(!infoRsped); infoRsped = true
           od
}

proctype UAS() {
/* media state */
   mtype media = noFlow;
   mtype sdp, bufsdp;
/* state relevant to the invited phase */
   bool dialog = false;
   bool relOut = false;                              /* relOut => dialog */
   bool canSucc = true;                            /* !relOut => canSucc */
/* state relevant to the confirmed phase */
   bool canBye = false;                                    /* SIP note 1 */
/* state relevant to the confirmed phase (at most one is true) */
   bool reInviting = false;
   bool reInvited = false;
/* state of acknowledgments */
   bool updRsped = true;
   byte ackDiff = 0;
   bool infoRsped = true;    /* should be Diff, but infos limited to one */
/* state for limiting numbers of messages */
   bool unProvSent = false;
   bool infoSent = false;
           cc2s?invite,sdp;
           if
           :: sdp != none; assert(sdp == offer); media = offered
           :: sdp == none
           fi;
invited:   do
           :: cc2s?prack,sdp; assert(dialog && relOut); 
              relOut = false; canSucc = true;
              if
              :: media == flow && sdp != none; assert(sdp == offer);
                 cs2c!prackRsp,answer
              :: media == offering && sdp != none; assert(sdp == answer);
                 cs2c!prackRsp,none; media = flow
              :: sdp == none; cs2c!prackRsp,none
              fi; 
           :: cc2s?update,sdp; assert(dialog && sdp == offer);
              if
              :: media == offering && !canSucc; assert(updRsped);
                 cs2c!updFail,none                      /* SIP problem 6 */
              :: media == offering && !updRsped; assert(canSucc);
                 cs2c!updFail,none 
              :: media == flow; cs2c!updSucc,answer
              fi
           :: cc2s?info,none; assert(dialog); cs2c!infoRsp,none
           :: cc2s?bye,none; cs2c!byeRsp,none; goto end
           :: cc2s?cancel,none; cs2c!cancRsp,none; cs2c!invFail,none; 
              goto end
           :: sc2s?updSucc,sdp; 
              assert(dialog && canSucc && !updRsped && sdp == answer &&
                                                        media == offering);
              media = flow; updRsped = true
           :: sc2s?updFail,none;                        /* SIP problem 6 */
              assert(dialog && canSucc && !updRsped && media == offering);
              media = flow; updRsped = true
           :: cc2s?infoRsp,none; assert(!infoRsped); infoRsped = true
           :: !unProvSent; cs2c!unProv,none; dialog = true; 
              unProvSent = true
           :: !relOut;
              if
              :: media == noFlow; cs2c!relProv,offer; media = offering;
                 dialog = true; relOut = true; canSucc = false
              :: media == offered; cs2c!relProv,answer; media = flow;
                 dialog = true; relOut = true; canSucc = false
              :: media == flow; cs2c!relProv,offer; media = offering;
                 dialog = true; relOut = true; canSucc = false
              :: (media==flow || media==offered || media==offering);
                 cs2c!relProv,none; dialog = true; relOut = true
              fi
           :: dialog && media == flow && canSucc;
              ss2c!update,offer; media = offering; updRsped = false
           :: cs2c!invFail,none; goto end
           :: canSucc && media == noFlow; cs2c!invSucc,offer; 
              media = offering; ackDiff++; goto confirmed
           :: canSucc && media == offered; cs2c!invSucc,answer; 
              media = flow; ackDiff++; goto confirmed
           :: canSucc && media == flow; cs2c!invSucc,none; 
              ackDiff++; goto confirmed
           :: dialog && !infoSent; ss2c!info,none; infoSent = true;
              infoRsped = false
           od;
confirmed: do
           :: cc2s?invite,sdp; assert(!reInvited);
              if
              :: reInviting; cs2c!invFail,none
              :: !reInviting; assert(media == flow); reInvited = true;
                 if
                 :: sdp != none; assert(sdp == offer); media = offered
                 :: sdp == none
                 fi
              fi
           :: cc2s?prack,sdp; assert(sdp == none)
           :: cc2s?update,sdp;
              assert(!reInvited && sdp == offer);
              if
              :: media == flow; cs2c!updSucc,answer
              fi
           :: cc2s?info,none; cs2c!infoRsp,none
           :: cc2s?bye,none; cs2c!byeRsp,none; goto end
           :: cc2s?cancel,none; cs2c!cancRsp,none       /* SIP problem 2 */
           :: sc2s?invFail,none; assert(reInviting); reInviting = false;
              if :: media == offering; media = flow :: else fi
           :: sc2s?invSucc,sdp; assert(reInviting);
              if
              :: media == flow; assert(sdp == offer); media = offered
              :: media == offering; assert(sdp == answer); 
                 ss2c!ack,none; media = flow; reInviting = false
              fi
           :: cc2s?ack,sdp; assert(ackDiff > 0); ackDiff--;
              assert( !reInviting || (reInviting && sdp == none) ); 
              canBye = true;
              if
              :: media == offering && sdp != none; 
                 assert(sdp == answer && !reInvited); media = flow
              :: media == offering && sdp == none
              :: media == flow || media == offered; assert(sdp == none);
              fi
           :: cc2s?infoRsp,none; assert(!infoRsped); infoRsped = true
           :: !infoSent; ss2c!info,none; infoSent = true; infoRsped = false
           :: reInviting && media == offered;
              ss2c!ack,answer; media = flow; reInviting = false
           :: !reInviting && !reInvited && canBye && media == flow;
              ss2c!invite,offer; reInviting = true; media = offering
           :: !reInviting && !reInvited && canBye && media == flow;
              ss2c!invite,none; reInviting = true          /* SIP note 2 */
           :: reInvited; reInvited = false; ackDiff++;
              if
              :: media == flow; cs2c!invSucc,offer; media = offering
              :: media == offered; cs2c!invSucc,answer; media = flow
              fi
           :: canBye; ss2c!bye,none; goto byeing           /* SIP note 1 */
           od;
byeing:    do
           :: cc2s?invite,sdp
           :: cc2s?info,none
           :: cc2s?bye,none; cs2c!byeRsp,none
           :: sc2s?invFail,none
           :: sc2s?invSucc,sdp
           :: cc2s?ack,sdp; assert(ackDiff > 0); ackDiff--
           :: cc2s?infoRsp,none; assert(!infoRsped); infoRsped = true
           :: sc2s?byeRsp,none; goto end
           od;
end:       do
           :: cc2s?invite,sdp
           :: cc2s?prack,sdp
           :: cc2s?update,sdp
           :: cc2s?info,none
           :: cc2s?bye,none; cs2c!byeRsp,none
           :: cc2s?cancel,none
           :: sc2s?updSucc,sdp; assert(!updRsped); updRsped = true
           :: sc2s?updFail,sdp; assert(!updRsped); updRsped = true
           :: sc2s?invFail,none
           :: sc2s?invSucc,sdp
           :: cc2s?ack,sdp; assert(ackDiff > 0); ackDiff--
           :: cc2s?infoRsp,none; assert(!infoRsped); infoRsped = true
           od
}

init { atomic { run UAC();
                run UAS()
              } }
