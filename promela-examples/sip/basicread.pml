/* ========================================================================
BASIC MODEL OF INVITE DIALOGS IN SIP, WITH SOME ASSERTIONS

Copyright AT&T Laboratories, Inc., 2008.

ON DOCUMENTATION

General documentation of this model, including scope, modeling style, and
validation/verification techniques, can be found in the paper 
"Understanding SIP Through Model-Checking".

However, the omissions (Section 4.1 of that paper) and some SIP problems
(Section 4.5.1 of that paper) are now obsolete.  They are superseded by the
information in this file and in the file "notes.txt", where the notes are.

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

Maximum sizes for queues reqs and reqc are guesses, as they cannot be
verified (with 128 Gbytes of memory or less).
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

/* inputs to UAC */
chan reqs = [4] of {mtype,mtype};  /* carries FIFO invite, update, info, 
                                      bye, 3 is minimum size */
chan acks = [2] of {mtype,mtype};  /* carries ack */
chan unps = [1] of {mtype};        /* carries unProv */
chan rlps = [1] of {mtype,mtype};  /* carries relProv */
chan irps = [1] of {mtype,mtype};  /* carries invFail, invSucc */
chan prps = [2] of {mtype,mtype};  /* carries prackRsp */
chan crps = [1] of {mtype};        /* carries cancRsp */
chan urps = [1] of {mtype,mtype};  /* carries updSucc, updFail */
chan frps = [1] of {mtype};        /* carries infoRsp */
chan brps = [1] of {mtype};        /* carries byeRsp */

/* inputs to UAS */
chan reqc = [6] of {mtype,mtype};  /* carries FIFO invite, prack, update,
                                      info, bye; 3 is minimum size */
chan canc = [1] of {mtype};        /* carries cancel */
chan urpc = [1] of {mtype,mtype};  /* carries updSucc, updFail */
chan irpc = [1] of {mtype,mtype};  /* carries invFail, invSucc */
chan ackc = [2] of {mtype,mtype};  /* carries ack */
chan frpc = [1] of {mtype};        /* carries infoRsp */
chan brpc = [1] of {mtype};        /* carries byeRsp */

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
           :: reqc!invite,offer; media = offering; initOffering = true;
              goto inviting
           :: reqc!invite,none; goto inviting
           od;
inviting:  do
           :: reqs?update,sdp; 
              assert(dialog && !initOffering && !relProvBuffered && 
                                                             sdp == offer);
              if
              :: media == offering; urpc!updFail,none
              :: media == flow; urpc!updSucc,answer
              fi
           :: reqs?info,none;
              if
              :: dialog; frpc!infoRsp
              :: !dialog; frpc!infoRsp                  /* SIP problem 1 */
              fi
           :: unps?unProv; dialog = true
           :: rlps?relProv,sdp; assert(!relProvBuffered); dialog = true;
              if
              :: (media == noFlow || media == flow) && sdp != none;
                 assert(!initOffering && sdp == offer);
                 reqc!prack,answer; prackRspDiff++; media = flow
              :: media == offering && sdp != none;
                 if
                 :: !initOffering;                  /* SIP problems 4, 6 */
                    assert(sdp == offer); relProvBuffered = true
                 :: initOffering; assert(sdp == answer);
                    initOffering = false;
                    if
                    :: true; reqc!prack,offer; prackRspDiff++; 
                             media = offering
                    :: true; reqc!prack,none; prackRspDiff++; media = flow
                    fi
                 fi
              :: sdp == none; reqc!prack,none; prackRspDiff++
              fi
           :: prps?prackRsp,sdp; assert(dialog && prackRspDiff > 0); 
              prackRspDiff--;
              if
              :: media == offering && sdp != none; assert(sdp == answer); 
                 media = flow
              :: media == offering && sdp == none
              :: media != offering; assert(sdp == none)
              fi;
              goto unbufferng 
           :: urps?updSucc,sdp; 
              assert(dialog && !updRsped && sdp == answer &&
                                       !initOffering && media == offering);
              media = flow; updRsped = true; goto unbufferng
           :: urps?updFail,none;                        /* SIP problem 6 */
              assert(dialog && !updRsped && !initOffering &&
                                                        media == offering);
              media = flow; updRsped = true; goto unbufferng
           :: irps?invFail,none; goto end
           :: irps?invSucc,sdp; assert(!relProvBuffered); dialog = true;
              if
              :: media == noFlow; assert(!initOffering && sdp == offer);
                 ackc!ack,answer; media = flow
              :: media == flow; assert(!initOffering && sdp == none);
                 ackc!ack,none
              :: media == offering && sdp == none; 
                 assert(!initOffering); ackc!ack,none
              :: media == offering && sdp != none; 
                 assert(initOffering && sdp == answer);
                 ackc!ack,none; media = flow
              fi;
              goto confirmed   
           :: frps?infoRsp; assert(dialog && !infoRsped); infoRsped = true
           :: dialog && media == flow && updRsped;
              reqc!update,offer; media = offering; updRsped = false
           :: dialog && !infoSent; reqc!info,none; infoSent = true;
              infoRsped = false
           :: canc!cancel; goto canceling
           :: dialog; reqc!bye,none; goto byeing           /* SIP note 5 */
           od;
unbufferng:if 
           :: relProvBuffered; reqc!prack,answer; prackRspDiff++; 
              relProvBuffered = false
           :: else
           fi;
           goto inviting;
confirmed: do
           :: reqs?invite,sdp; assert(!reInviteBuffered && !reInvited);
              if
              :: reInviting; irpc!invFail,none
              :: !reInviting && media != flow;      /* SIP problems 3, 5 */
                 reInviteBuffered = true; bufsdp = sdp
              :: !reInviting && media == flow; reInvited = true;
                 if
                 :: sdp != none; assert(sdp == offer); media = offered
                 :: sdp == none
                 fi
              fi
           :: reqs?info,none; frpc!infoRsp
           :: reqs?bye,none; brpc!byeRsp; goto end
           :: unps?unProv
           :: rlps?relProv,sdp; assert(sdp == none)
           :: prps?prackRsp,sdp; assert(prackRspDiff > 0);
              prackRspDiff--;
              if
              :: sdp != none; 
                 assert(!reInviting && !reInvited && media == offering && 
                                                            sdp == answer);
                 media = flow
              :: sdp == none
              fi; 
              goto unbuffring
           :: urps?updSucc,sdp; 
              assert(!reInviting && !reInvited && !updRsped && 
                                       sdp == answer && media == offering);
              media = flow; updRsped = true; goto unbuffring
           :: urps?updFail,none; 
              assert(!reInviting && !reInvited && !updRsped && 
                                                        media == offering);
              media = flow; updRsped = true; goto unbuffring
           :: irps?invFail,none; 
              assert(reInviting && !reInvited && !reInviteBuffered);
              reInviting = false;
              if :: media == offering; media = flow :: else fi
           :: irps?invSucc,sdp; 
              assert(reInviting && !reInvited && !reInviteBuffered && 
                                                              sdp != none);
              if
              :: media == flow; assert(sdp == offer); media = offered
              :: media == offering; assert(sdp == answer);
                 ackc!ack,none; media = flow; reInviting = false;
              fi
           :: acks?ack,sdp; assert(ackDiff > 0); ackDiff--;
              assert( !reInviting || (reInviting && sdp == none) ); 
              if
              :: sdp != none; 
                 assert(!reInvited && media == offering && sdp == answer);
                 media = flow
              :: sdp == none
              fi;
              goto unbuffring
           :: frps?infoRsp; assert(dialog && !infoRsped); infoRsped = true
           :: !infoSent; reqc!info,none; infoSent = true; infoRsped = false
           :: reInviting && media == offered;
              ackc!ack,answer; media = flow; reInviting = false
           :: !reInviting && !reInvited && media == flow;
              reqc!invite,offer; reInviting = true; media = offering
                                                           /* SIP note 3 */
           :: !reInviting && !reInvited && media == flow;
              reqc!invite,none; reInviting = true      /* SIP notes 2, 3 */
           :: reInvited; reInvited = false; ackDiff++;
              if
              :: media == flow; irpc!invSucc,offer; media = offering
              :: media == offered; irpc!invSucc,answer; media = flow
              fi
           :: reqc!bye,none; goto byeing
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
           :: reqs?update,sdp
           :: reqs?info,none
           :: unps?unProv
           :: rlps?relProv,sdp
           :: prps?prackRsp,sdp; assert(prackRspDiff > 0); prackRspDiff--
           :: crps?cancRsp
           :: urps?updSucc,sdp; assert(!updRsped); updRsped = true
           :: urps?updFail,sdp; assert(!updRsped); updRsped = true
           :: irps?invFail,none; goto end
           :: irps?invSucc,sdp; reqc!bye,none; goto byeing
           :: frps?infoRsp; assert(!infoRsped); infoRsped = true
           od;
byeing:    do
           :: reqs?invite,sdp
           :: reqs?update,sdp
           :: reqs?info,none
           :: reqs?bye,none; brpc!byeRsp
           :: unps?unProv
           :: rlps?relProv,sdp
           :: prps?prackRsp,sdp; assert(prackRspDiff > 0); prackRspDiff--
           :: crps?cancRsp
           :: urps?updSucc,sdp; assert(!updRsped); updRsped = true
           :: urps?updFail,sdp; assert(!updRsped); updRsped = true
           :: irps?invFail,none
           :: irps?invSucc,sdp
           :: acks?ack,sdp; assert(ackDiff > 0); ackDiff--
           :: frps?infoRsp; assert(!infoRsped); infoRsped = true
           :: brps?byeRsp; goto end
           od;
end:       do
           :: reqs?invite,sdp
           :: reqs?update,sdp
           :: reqs?info,none
           :: reqs?bye,none; brpc!byeRsp
           :: unps?unProv
           :: rlps?relProv,sdp
           :: prps?prackRsp,sdp; assert(prackRspDiff > 0); prackRspDiff--
           :: crps?cancRsp
           :: urps?updSucc,sdp; assert(!updRsped); updRsped = true
           :: urps?updFail,sdp; assert(!updRsped); updRsped = true
           :: irps?invFail,none
           :: irps?invSucc,sdp
           :: acks?ack,sdp; assert(ackDiff > 0); ackDiff--
           :: frps?infoRsp; assert(!infoRsped); infoRsped = true
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
   bool reInviteBuffered = false;
/* state of acknowledgments */
   bool updRsped = true;
   byte ackDiff = 0;
   bool infoRsped = true;    /* should be Diff, but infos limited to one */
/* state for limiting numbers of messages */
   bool unProvSent = false;
   bool infoSent = false;
           reqc?invite,sdp;
           if
           :: sdp != none; assert(sdp == offer); media = offered
           :: sdp == none
           fi;
invited:   do
           :: reqc?prack,sdp; assert(dialog && relOut); 
              relOut = false; canSucc = true;
              if
              :: media == flow && sdp != none; assert(sdp == offer);
                 prps!prackRsp,answer
              :: media == offering && sdp != none; assert(sdp == answer);
                 prps!prackRsp,none; media = flow
              :: (media == noFlow || media == offered) && sdp != none;
              :: sdp == none; prps!prackRsp,none
              fi; 
           :: reqc?update,sdp; assert(dialog && sdp == offer);
              if
              :: media == offering && !canSucc; assert(updRsped);
                 urps!updFail,none                      /* SIP problem 6 */
              :: media == offering && !updRsped; assert(canSucc);
                 urps!updFail,none 
              :: media == flow; urps!updSucc,answer
              fi
           :: reqc?info,none; assert(dialog); frps!infoRsp
           :: reqc?bye,none; brps!byeRsp; goto end
           :: canc?cancel; crps!cancRsp; irps!invFail,none; goto end
           :: urpc?updSucc,sdp; 
              assert(dialog && canSucc && !updRsped && sdp == answer &&
                                                        media == offering);
              media = flow; updRsped = true
           :: urpc?updFail,none;                        /* SIP problem 6 */
              assert(dialog && canSucc && !updRsped && media == offering);
              media = flow; updRsped = true
           :: frpc?infoRsp; assert(!infoRsped); infoRsped = true
           :: !unProvSent; unps!unProv; dialog = true; unProvSent = true
           :: !relOut;
              if
              :: media == noFlow; rlps!relProv,offer; media = offering;
                 dialog = true; relOut = true; canSucc = false
              :: media == offered; rlps!relProv,answer; media = flow;
                 dialog = true; relOut = true; canSucc = false
              :: media == flow; rlps!relProv,offer; media = offering;
                 dialog = true; relOut = true; canSucc = false
              :: (media==flow || media==offered || media==offering);
                 rlps!relProv,none; dialog = true; relOut = true
              fi
           :: dialog && media == flow && canSucc;
              reqs!update,offer; media = offering; updRsped = false
           :: irps!invFail,none; goto end
           :: canSucc && media == noFlow; irps!invSucc,offer; 
              media = offering; ackDiff++; goto confirmed
           :: canSucc && media == offered; irps!invSucc,answer; 
              media = flow; ackDiff++; goto confirmed
           :: canSucc && media == flow; irps!invSucc,none; 
              ackDiff++; goto confirmed
           :: dialog && !infoSent; reqs!info,none; infoSent = true;
              infoRsped = false
           od;
confirmed: do
           :: reqc?invite,sdp; assert(!reInvited && !reInviteBuffered);
              if
              :: reInviting; irps!invFail,none
              :: !reInviting && media != flow;          /* SIP problem 3 */
                 reInviteBuffered = true; bufsdp = sdp
              :: !reInviting && media == flow; reInvited = true;
                 if
                 :: sdp != none; assert(sdp == offer); media = offered
                 :: sdp == none
                 fi
              fi
           :: reqc?prack,sdp; assert(sdp == none)
           :: reqc?update,sdp; 
              assert(!reInvited && !reInviteBuffered && sdp == offer);
              if
              :: media == flow; urps!updSucc,answer   /*can be reInviting*/
              :: media == offering; assert(reInviting); urps!updFail,none
              fi
           :: reqc?info,none; frps!infoRsp
           :: reqc?bye,none; brps!byeRsp; goto end
           :: canc?cancel; crps!cancRsp                 /* SIP problem 2 */
           :: irpc?invFail,none; assert(reInviting); reInviting = false;
              if :: media == offering; media = flow :: else fi
           :: irpc?invSucc,sdp; assert(reInviting);
              if
              :: media == flow; assert(sdp == offer); media = offered
              :: media == offering; assert(sdp == answer); 
                 acks!ack,none; media = flow; reInviting = false
              fi
           :: ackc?ack,sdp; assert(ackDiff > 0); ackDiff--;
              assert( !reInviting || (reInviting && sdp == none) ); 
              canBye = true;
              if
              :: media == offering && sdp != none; 
                 assert(sdp == answer && !reInvited); media = flow
              :: media == offering && sdp == none
              :: media == flow || media == offered; assert(sdp == none);
              fi;
              if
              :: reInviteBuffered && media == flow; reInvited = true; 
                 reInviteBuffered = false;
                 if
                 :: bufsdp != none; assert(bufsdp == offer); 
                    media = offered
                 :: bufsdp == none
                 fi
              :: reInviteBuffered && media != flow
              :: !reInviteBuffered
              fi
           :: frpc?infoRsp; assert(!infoRsped); infoRsped = true
           :: !infoSent; reqs!info,none; infoSent = true; infoRsped = false
           :: reInviting && media == offered;
              acks!ack,answer; media = flow; reInviting = false
           :: !reInviting && !reInvited && canBye && media == flow;
              reqs!invite,offer; reInviting = true; media = offering
                                                           /* SIP note 3 */
           :: !reInviting && !reInvited && canBye && media == flow;
              reqs!invite,none; reInviting = true      /* SIP notes 2, 3 */
           :: reInvited; reInvited = false; ackDiff++;
              if
              :: media == flow; irps!invSucc,offer; media = offering
              :: media == offered; irps!invSucc,answer; media = flow
              fi
           :: canBye; reqs!bye,none; goto byeing           /* SIP note 1 */
           od;
byeing:    do
           :: reqc?invite,sdp
           :: reqc?prack,sdp
           :: reqc?update,sdp
           :: reqc?info,none
           :: reqc?bye,none; brps!byeRsp
           :: irpc?invFail,none
           :: irpc?invSucc,sdp
           :: ackc?ack,sdp; assert(ackDiff > 0); ackDiff--
           :: frpc?infoRsp; assert(!infoRsped); infoRsped = true
           :: brpc?byeRsp; goto end
           od;
end:       do
           :: reqc?invite,sdp
           :: reqc?prack,sdp
           :: reqc?update,sdp
           :: reqc?info,none
           :: reqc?bye,none; brps!byeRsp
           :: canc?cancel
           :: urpc?updSucc,sdp; assert(!updRsped); updRsped = true
           :: urpc?updFail,sdp; assert(!updRsped); updRsped = true
           :: irpc?invFail,none
           :: irpc?invSucc,sdp
           :: ackc?ack,sdp; assert(ackDiff > 0); ackDiff--
           :: frpc?infoRsp; assert(!infoRsped); infoRsped = true
           od
}

init { atomic { run UAC();
                run UAS()
              } }
