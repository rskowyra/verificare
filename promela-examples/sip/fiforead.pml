/* ========================================================================
FIFO MODEL OF INVITE DIALOGS IN SIP, WITH SOME ASSERTIONS

Copyright AT&T Laboratories, Inc., 2008.

PROVENANCE

This model is based on "transraw.pml", the model of invite dialogs in SIP
with transmitted messages ordered by transactions.  The difference is that
this model uses exactly one TCP connection per dialog instead of two.  As 
a result, all of the messages traveling in the same direction between the
two UAs are received in FIFO order.

In transraw.pml, message-ordering problems 1 and 3 remain despite the fact
that some ordering has been imposed on message transmission.  Use of FIFO
transmission eliminates these problems.

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

chan c2s = [7] of {mtype,mtype}; /* maximal queue length */
chan s2c = [9] of {mtype,mtype}; /* maximal queue length */

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
/* state of acknowledgments */
   byte prackRspDiff = 0;
   bool updRsped = true;
   byte ackDiff = 0;
   bool infoRsped = true;    /* should be Diff, but infos limited to one */
/* state for limiting numbers of messages */
   bool infoSent = false;
           do
           :: c2s!invite,offer; media = offering; initOffering = true;
              goto inviting
           :: c2s!invite,none; goto inviting
           od;
inviting:  do
           :: s2c?update,sdp; 
              assert(dialog && !initOffering && !relProvBuffered && 
                                                             sdp == offer);
              if
              :: media == offering; c2s!updFail,none
              :: media == flow; c2s!updSucc,answer
              fi
           :: s2c?info,none; assert(dialog); c2s!infoRsp,none
           :: s2c?unProv,none; dialog = true
           :: s2c?relProv,sdp; assert(!relProvBuffered); dialog = true;
              if
              :: (media == noFlow || media == flow) && sdp != none;
                 assert(!initOffering && sdp == offer);
                 c2s!prack,answer; prackRspDiff++; media = flow
              :: media == offering && sdp != none;
                 if
                 :: !initOffering;                      /* SIP problem 6 */
                    assert(sdp == offer); relProvBuffered = true
                 :: initOffering; assert(sdp == answer);
                    initOffering = false;
                    if
                    :: true; c2s!prack,offer; prackRspDiff++; 
                             media = offering
                    :: true; c2s!prack,none; prackRspDiff++; media = flow
                    fi
                 fi
              :: sdp == none; c2s!prack,none; prackRspDiff++
              fi
           :: s2c?prackRsp,sdp; assert(dialog && prackRspDiff > 0); 
              prackRspDiff--;
              if
              :: media == offering && sdp != none; assert(sdp == answer); 
                 media = flow
              :: media == offering && sdp == none
              :: media != offering; assert(sdp == none)
              fi;
           :: s2c?updSucc,sdp; 
              assert(dialog && !updRsped && sdp == answer &&
                   !relProvBuffered && !initOffering && media == offering);
              media = flow; updRsped = true
           :: s2c?updFail,none;                         /* SIP problem 6 */
              assert(dialog && !updRsped && !initOffering &&
                                                        media == offering);
              media = flow; updRsped = true;
              if 
              :: relProvBuffered; c2s!prack,answer; prackRspDiff++; 
                 relProvBuffered = false
              :: else
              fi;
           :: s2c?invFail,none; goto end
           :: s2c?invSucc,sdp; assert(!relProvBuffered); dialog = true;
              if
              :: media == noFlow; assert(!initOffering && sdp == offer);
                 c2s!ack,answer; media = flow
              :: media == flow; assert(!initOffering && sdp == none);
                 c2s!ack,none
              :: media == offering && sdp == none; 
                 assert(!initOffering); c2s!ack,none
              :: media == offering && sdp != none; 
                 assert(initOffering && sdp == answer);
                 c2s!ack,none; media = flow
              fi;
              goto confirmed   
           :: s2c?infoRsp,none; assert(dialog && !infoRsped); 
              infoRsped = true
           :: dialog && media == flow && updRsped;
              c2s!update,offer; media = offering; updRsped = false
           :: dialog && !infoSent; c2s!info,none; infoSent = true;
              infoRsped = false
           :: c2s!cancel,none; goto canceling
           :: dialog; c2s!bye,none; goto byeing            /* SIP note 5 */
           od;
confirmed: do
           :: s2c?invite,sdp; assert(!reInvited);
              if
              :: reInviting; c2s!invFail,none
              :: !reInviting; assert(media == flow); reInvited = true;
                 if
                 :: sdp != none; assert(sdp == offer); media = offered
                 :: sdp == none
                 fi
              fi
           :: s2c?info,none; c2s!infoRsp,none
           :: s2c?bye,none; c2s!byeRsp,none; goto end
           :: s2c?unProv,none
           :: s2c?updSucc,sdp; 
              assert(!reInviting && !reInvited && !updRsped && 
                                       sdp == answer && media == offering);
              media = flow; updRsped = true
           :: s2c?invFail,none; assert(reInviting && !reInvited);
              reInviting = false;
              if :: media == offering; media = flow :: else fi
           :: s2c?invSucc,sdp; 
              assert(reInviting && !reInvited && sdp != none);
              if
              :: media == flow; assert(sdp == offer); media = offered
              :: media == offering; assert(sdp == answer);
                 c2s!ack,none; media = flow; reInviting = false;
              fi
           :: s2c?ack,sdp; assert(ackDiff > 0); ackDiff--;
              assert( !reInviting || (reInviting && sdp == none) ); 
              if
              :: sdp != none; 
                 assert(!reInvited && media == offering && sdp == answer);
                 media = flow
              :: sdp == none
              fi
           :: s2c?infoRsp,none; assert(dialog && !infoRsped); 
              infoRsped = true
           :: !infoSent; c2s!info,none; infoSent = true; infoRsped = false
           :: reInviting && media == offered;
              c2s!ack,answer; media = flow; reInviting = false
           :: !reInviting && !reInvited && media == flow;
              c2s!invite,offer; reInviting = true; media = offering
           :: !reInviting && !reInvited && media == flow;
              c2s!invite,none; reInviting = true           /* SIP note 2 */
           :: reInvited; reInvited = false; ackDiff++;
              if
              :: media == flow; c2s!invSucc,offer; media = offering
              :: media == offered; c2s!invSucc,answer; media = flow
              fi
           :: c2s!bye,none; goto byeing
           od; 
canceling: do
           :: s2c?update,sdp
           :: s2c?info,none
           :: s2c?unProv,none
           :: s2c?relProv,sdp
           :: s2c?prackRsp,sdp; assert(prackRspDiff > 0); prackRspDiff--
           :: s2c?cancRsp,none
           :: s2c?updSucc,sdp; assert(!updRsped); updRsped = true
           :: s2c?updFail,sdp; assert(!updRsped); updRsped = true
           :: s2c?invFail,none; goto end
           :: s2c?invSucc,sdp; c2s!bye,none; goto byeing
           :: s2c?infoRsp,none; assert(!infoRsped); infoRsped = true
           od;
byeing:    do
           :: s2c?invite,sdp
           :: s2c?update,sdp
           :: s2c?info,none
           :: s2c?bye,none; c2s!byeRsp,none
           :: s2c?unProv,none
           :: s2c?relProv,sdp
           :: s2c?prackRsp,sdp; assert(prackRspDiff > 0); prackRspDiff--
           :: s2c?cancRsp,none
           :: s2c?updSucc,sdp; assert(!updRsped); updRsped = true
           :: s2c?updFail,sdp; assert(!updRsped); updRsped = true
           :: s2c?invFail,none
           :: s2c?invSucc,sdp
           :: s2c?ack,sdp; assert(ackDiff > 0); ackDiff--
           :: s2c?infoRsp,none; assert(!infoRsped); infoRsped = true
           :: s2c?byeRsp,none; goto end
           od;
end:       skip
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
           c2s?invite,sdp;
           if
           :: sdp != none; assert(sdp == offer); media = offered
           :: sdp == none
           fi;
invited:   do
           :: c2s?prack,sdp; assert(dialog && relOut); 
              relOut = false; canSucc = true;
              if
              :: media == flow && sdp != none; assert(sdp == offer);
                 s2c!prackRsp,answer
              :: media == offering && sdp != none; assert(sdp == answer);
                 s2c!prackRsp,none; media = flow
              :: sdp == none; s2c!prackRsp,none
              fi; 
           :: c2s?update,sdp; assert(dialog && sdp == offer);
              if
              :: media == offering && !canSucc; assert(updRsped);
                 s2c!updFail,none                       /* SIP problem 6 */
              :: media == offering && !updRsped; assert(canSucc);
                 s2c!updFail,none 
              :: media == flow; s2c!updSucc,answer
              fi
           :: c2s?info,none; assert(dialog); s2c!infoRsp,none
           :: c2s?bye,none; s2c!byeRsp,none; goto end
           :: c2s?cancel,none; s2c!cancRsp,none; s2c!invFail,none; goto end
           :: c2s?updSucc,sdp; 
              assert(dialog && canSucc && !updRsped && sdp == answer &&
                                                        media == offering);
              media = flow; updRsped = true
           :: c2s?updFail,none;                         /* SIP problem 6 */
              assert(dialog && canSucc && !updRsped && media == offering);
              media = flow; updRsped = true
           :: c2s?infoRsp,none; assert(!infoRsped); infoRsped = true
           :: !unProvSent; s2c!unProv,none; dialog = true; 
              unProvSent = true
           :: !relOut;
              if
              :: media == noFlow; s2c!relProv,offer; media = offering;
                 dialog = true; relOut = true; canSucc = false
              :: media == offered; s2c!relProv,answer; media = flow;
                 dialog = true; relOut = true; canSucc = false
              :: media == flow; s2c!relProv,offer; media = offering;
                 dialog = true; relOut = true; canSucc = false
              :: (media==flow || media==offered || media==offering);
                 s2c!relProv,none; dialog = true; relOut = true
              fi
           :: dialog && media == flow && canSucc;
              s2c!update,offer; media = offering; updRsped = false
           :: s2c!invFail,none; goto end
           :: canSucc && media == noFlow; s2c!invSucc,offer; 
              media = offering; ackDiff++; goto confirmed
           :: canSucc && media == offered; s2c!invSucc,answer; 
              media = flow; ackDiff++; goto confirmed
           :: canSucc && media == flow; s2c!invSucc,none; 
              ackDiff++; goto confirmed
           :: dialog && !infoSent; s2c!info,none; infoSent = true;
              infoRsped = false
           od;
confirmed: do
           :: c2s?invite,sdp; assert(!reInvited);
              if
              :: reInviting; s2c!invFail,none
              :: !reInviting; assert(media == flow); reInvited = true;
                 if
                 :: sdp != none; assert(sdp == offer); media = offered
                 :: sdp == none
                 fi
              fi
           :: c2s?prack,sdp; assert(sdp == none)
           :: c2s?update,sdp;
              assert(!reInvited && sdp == offer);
              if
              :: media == flow; s2c!updSucc,answer
              fi
           :: c2s?info,none; s2c!infoRsp,none
           :: c2s?bye,none; s2c!byeRsp,none; goto end
           :: c2s?cancel,none; s2c!cancRsp,none         /* SIP problem 2 */
           :: c2s?invFail,none; assert(reInviting); reInviting = false;
              if :: media == offering; media = flow :: else fi
           :: c2s?invSucc,sdp; assert(reInviting);
              if
              :: media == flow; assert(sdp == offer); media = offered
              :: media == offering; assert(sdp == answer); 
                 s2c!ack,none; media = flow; reInviting = false
              fi
           :: c2s?ack,sdp; assert(ackDiff > 0); ackDiff--;
              assert( !reInviting || (reInviting && sdp == none) ); 
              canBye = true;
              if
              :: media == offering && sdp != none; 
                 assert(sdp == answer && !reInvited); media = flow
              :: media == offering && sdp == none
              :: media == flow || media == offered; assert(sdp == none);
              fi
           :: c2s?infoRsp,none; assert(!infoRsped); infoRsped = true
           :: !infoSent; s2c!info,none; infoSent = true; infoRsped = false
           :: reInviting && media == offered;
              s2c!ack,answer; media = flow; reInviting = false
           :: !reInviting && !reInvited && canBye && media == flow;
              s2c!invite,offer; reInviting = true; media = offering
           :: !reInviting && !reInvited && canBye && media == flow;
              s2c!invite,none; reInviting = true           /* SIP note 2 */
           :: reInvited; reInvited = false; ackDiff++;
              if
              :: media == flow; s2c!invSucc,offer; media = offering
              :: media == offered; s2c!invSucc,answer; media = flow
              fi
           :: canBye; s2c!bye,none; goto byeing            /* SIP note 1 */
           od;
byeing:    do
           :: c2s?invite,sdp
           :: c2s?info,none
           :: c2s?bye,none; s2c!byeRsp,none
           :: c2s?invFail,none
           :: c2s?invSucc,sdp
           :: c2s?ack,sdp; assert(ackDiff > 0); ackDiff--
           :: c2s?infoRsp,none; assert(!infoRsped); infoRsped = true
           :: c2s?byeRsp,none; goto end
           od;
end:       do
           :: c2s?prack,sdp
           :: c2s?update,sdp
           :: c2s?info,none
           :: c2s?bye,none; s2c!byeRsp,none
           :: c2s?cancel,none
           :: c2s?updSucc,sdp; assert(!updRsped); updRsped = true
           :: c2s?updFail,sdp; assert(!updRsped); updRsped = true
           :: c2s?infoRsp,none; assert(!infoRsped); infoRsped = true
           od
}

init { atomic { run UAC();
                run UAS()
              } }
