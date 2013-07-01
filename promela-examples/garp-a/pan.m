	switch (t->forw) {
	default: Uerror("bad forward move");

		 /* PROC :init: */
	case  1: /* STATE 1 - line 16 "pan_in" - [(run macuser(0))] */
		IfNotBlocked
		if (!(addproc(0, 0)))
			continue;
		m = 3; goto P999;
	case  2: /* STATE 2 - line 16 "pan_in" - [(run macuser1(1))] */
		IfNotBlocked
		if (!(addproc(1, 1)))
			continue;
		m = 3; goto P999;
	case  3: /* STATE 3 - line 17 "pan_in" - [(run llc())] */
		IfNotBlocked
		if (!(addproc(2, 0)))
			continue;
		m = 3; goto P999;
	case  4: /* STATE 4 - line 18 "pan_in" - [(run applicant(0))] */
		IfNotBlocked
		if (!(addproc(3, 0)))
			continue;
		m = 3; goto P999;
	case  5: /* STATE 5 - line 18 "pan_in" - [(run applicant(1))] */
		IfNotBlocked
		if (!(addproc(3, 1)))
			continue;
		m = 3; goto P999;
	case  6: /* STATE 6 - line 19 "pan_in" - [(run registrar(0))] */
		IfNotBlocked
		if (!(addproc(4, 0)))
			continue;
		m = 3; goto P999;
	case  7: /* STATE 7 - line 20 "pan_in" - [(run leaveallpro(0))] */
		IfNotBlocked
		if (!(addproc(5, 0)))
			continue;
		m = 3; goto P999;
	case  8: /* STATE 9 - line 22 "pan_in" - [-end-] */
		IfNotBlocked
		if (!delproc(1, II)) continue;
		m = 3; goto P999;

		 /* PROC leaveallpro */
	case  9: /* STATE 1 - line 11 "leaveall" - [leavealltimer = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P5 *)this)->leavealltimer);
		((P5 *)this)->leavealltimer = 1;
#ifdef VAR_RANGES
		logval("leaveallpro:leavealltimer", ((int)((P5 *)this)->leavealltimer));
#endif
		;
		m = 3; goto P999;
	case  10: /* STATE 6 - line 19 "leaveall" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  11: /* STATE 2 - line 14 "leaveall" - [llc_to_leaveall?type] */
		if (q_zero(now.llc_to_leaveall))
		{	if (boq != now.llc_to_leaveall) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(now.llc_to_leaveall) == 0) continue;
	{
		int XX=1;
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
		if (t->atom&2)
#endif
			sv_save((char *)&now);
		((P5 *)this)->type = qrecv(now.llc_to_leaveall, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("leaveallpro:type", ((int)((P5 *)this)->type));
#endif
		;
	}
		if (q_zero(now.llc_to_leaveall)) boq = -1;
		m = 4; goto P999;
	case  12: /* STATE 7 - line 13 "leaveall" - [break] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  13: /* STATE 8 - line 19 "leaveall" - [-end-] */
		IfNotBlocked
		if (!delproc(1, II)) continue;
		m = 3; goto P999;
	case  14: /* STATE 3 - line 16 "leaveall" - [((empty(llc_to_leaveall)&&(leavealltimer==1)))] */
		IfNotBlocked
		if (!(((q_len(now.llc_to_leaveall)==0)&&(((int)((P5 *)this)->leavealltimer)==1))))
			continue;
		m = 3; goto P999;
	case  15: /* STATE 4 - line 17 "leaveall" - [leaveall_to_llc!leaveall] */
		IfNotBlocked
		if (q_full(now.leaveall_to_llc))
		{ nlost++; m=3; goto P999; }

		qsend(now.leaveall_to_llc, 0, 1);
		if (q_zero(now.leaveall_to_llc)) { boq = now.leaveall_to_llc; };
		m = 2; goto P999;

		 /* PROC registrar */
	case  16: /* STATE 1 - line 10 "registrar" - [state = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->state);
		((P4 *)this)->state = 1;
#ifdef VAR_RANGES
		logval("registrar:state", ((int)((P4 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  17: /* STATE 47 - line 57 "registrar" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  18: /* STATE 2 - line 13 "registrar" - [llc_to_regist?type] */
		if (q_zero(now.llc_to_regist))
		{	if (boq != now.llc_to_regist) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(now.llc_to_regist) == 0) continue;
	{
		int XX=1;
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
		if (t->atom&2)
#endif
			sv_save((char *)&now);
		((P4 *)this)->type = qrecv(now.llc_to_regist, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("registrar:type", ((int)((P4 *)this)->type));
#endif
		;
	}
		if (q_zero(now.llc_to_regist)) boq = -1;
		m = 4; goto P999;
	case  19: /* STATE 3 - line 15 "registrar" - [((type==join))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->type)==3)))
			continue;
		m = 3; goto P999;
	case  20: /* STATE 4 - line 17 "registrar" - [((state==1))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->state)==1)))
			continue;
		m = 3; goto P999;
	case  21: /* STATE 5 - line 18 "registrar" - [member_exist = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->member_exist);
		((P4 *)this)->member_exist = 1;
#ifdef VAR_RANGES
		logval("registrar:member_exist", ((int)((P4 *)this)->member_exist));
#endif
		;
		m = 3; goto P999;
	case  22: /* STATE 6 - line 19 "registrar" - [state = 4] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->state);
		((P4 *)this)->state = 4;
#ifdef VAR_RANGES
		logval("registrar:state", ((int)((P4 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  23: /* STATE 17 - line 29 "registrar" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  24: /* STATE 7 - line 20 "registrar" - [((state==2))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->state)==2)))
			continue;
		m = 3; goto P999;
	case  25: /* STATE 8 - line 21 "registrar" - [leavetimer = 0] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->leavetimer);
		((P4 *)this)->leavetimer = 0;
#ifdef VAR_RANGES
		logval("registrar:leavetimer", ((int)((P4 *)this)->leavetimer));
#endif
		;
		m = 3; goto P999;
	case  26: /* STATE 9 - line 22 "registrar" - [state = 4] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->state);
		((P4 *)this)->state = 4;
#ifdef VAR_RANGES
		logval("registrar:state", ((int)((P4 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  27: /* STATE 33 - line 44 "registrar" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  28: /* STATE 48 - line 12 "registrar" - [break] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  29: /* STATE 49 - line 57 "registrar" - [-end-] */
		IfNotBlocked
		if (!delproc(1, II)) continue;
		m = 3; goto P999;
	case  30: /* STATE 10 - line 23 "registrar" - [((state==3))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->state)==3)))
			continue;
		m = 3; goto P999;
	case  31: /* STATE 11 - line 24 "registrar" - [leavetimer = 0] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->leavetimer);
		((P4 *)this)->leavetimer = 0;
#ifdef VAR_RANGES
		logval("registrar:leavetimer", ((int)((P4 *)this)->leavetimer));
#endif
		;
		m = 3; goto P999;
	case  32: /* STATE 12 - line 25 "registrar" - [state = 4] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->state);
		((P4 *)this)->state = 4;
#ifdef VAR_RANGES
		logval("registrar:state", ((int)((P4 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  33: /* STATE 13 - line 26 "registrar" - [((state==4))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->state)==4)))
			continue;
		m = 3; goto P999;
	case  34: /* STATE 14 - line 27 "registrar" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  35: /* STATE 15 - line 27 "registrar" - [assert(0)] */
		IfNotBlocked
		assert(0, "0", II, tt, t);
		m = 3; goto P999;
	case  36: /* STATE 18 - line 29 "registrar" - [(((type==leave)||(type==leaveall)))] */
		IfNotBlocked
		if (!(((((int)((P4 *)this)->type)==2)||(((int)((P4 *)this)->type)==1))))
			continue;
		m = 3; goto P999;
	case  37: /* STATE 19 - line 31 "registrar" - [((state==1))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->state)==1)))
			continue;
		m = 3; goto P999;
	case  38: /* STATE 30 - line 41 "registrar" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  39: /* STATE 20 - line 32 "registrar" - [((state==2))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->state)==2)))
			continue;
		m = 3; goto P999;
	case  40: /* STATE 21 - line 33 "registrar" - [leavetimer = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->leavetimer);
		((P4 *)this)->leavetimer = 1;
#ifdef VAR_RANGES
		logval("registrar:leavetimer", ((int)((P4 *)this)->leavetimer));
#endif
		;
		m = 3; goto P999;
	case  41: /* STATE 22 - line 34 "registrar" - [((state==3))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->state)==3)))
			continue;
		m = 3; goto P999;
	case  42: /* STATE 23 - line 35 "registrar" - [leavetimer = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->leavetimer);
		((P4 *)this)->leavetimer = 1;
#ifdef VAR_RANGES
		logval("registrar:leavetimer", ((int)((P4 *)this)->leavetimer));
#endif
		;
		m = 3; goto P999;
	case  43: /* STATE 24 - line 36 "registrar" - [((state==4))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->state)==4)))
			continue;
		m = 3; goto P999;
	case  44: /* STATE 25 - line 37 "registrar" - [leavetimer = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->leavetimer);
		((P4 *)this)->leavetimer = 1;
#ifdef VAR_RANGES
		logval("registrar:leavetimer", ((int)((P4 *)this)->leavetimer));
#endif
		;
		m = 3; goto P999;
	case  45: /* STATE 26 - line 38 "registrar" - [state = 2] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->state);
		((P4 *)this)->state = 2;
#ifdef VAR_RANGES
		logval("registrar:state", ((int)((P4 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  46: /* STATE 27 - line 39 "registrar" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  47: /* STATE 28 - line 39 "registrar" - [assert(0)] */
		IfNotBlocked
		assert(0, "0", II, tt, t);
		m = 3; goto P999;
	case  48: /* STATE 31 - line 41 "registrar" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  49: /* STATE 34 - line 45 "registrar" - [((empty(llc_to_regist)&&(leavetimer==1)))] */
		IfNotBlocked
		if (!(((q_len(now.llc_to_regist)==0)&&(((int)((P4 *)this)->leavetimer)==1))))
			continue;
		m = 3; goto P999;
	case  50: /* STATE 35 - line 47 "registrar" - [((state==2))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->state)==2)))
			continue;
		m = 3; goto P999;
	case  51: /* STATE 36 - line 48 "registrar" - [regist_to_llc!leave] */
		IfNotBlocked
		if (q_full(now.regist_to_llc))
		{ nlost++; m=3; goto P999; }

		qsend(now.regist_to_llc, 0, 2);
		if (q_zero(now.regist_to_llc)) { boq = now.regist_to_llc; };
		m = 2; goto P999;
	case  52: /* STATE 37 - line 49 "registrar" - [state = 3] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->state);
		((P4 *)this)->state = 3;
#ifdef VAR_RANGES
		logval("registrar:state", ((int)((P4 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  53: /* STATE 45 - line 56 "registrar" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  54: /* STATE 38 - line 50 "registrar" - [((state==3))] */
		IfNotBlocked
		if (!((((int)((P4 *)this)->state)==3)))
			continue;
		m = 3; goto P999;
	case  55: /* STATE 39 - line 51 "registrar" - [leavetimer = 0] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->leavetimer);
		((P4 *)this)->leavetimer = 0;
#ifdef VAR_RANGES
		logval("registrar:leavetimer", ((int)((P4 *)this)->leavetimer));
#endif
		;
		m = 3; goto P999;
	case  56: /* STATE 40 - line 52 "registrar" - [member_exist = 0] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->member_exist);
		((P4 *)this)->member_exist = 0;
#ifdef VAR_RANGES
		logval("registrar:member_exist", ((int)((P4 *)this)->member_exist));
#endif
		;
		m = 3; goto P999;
	case  57: /* STATE 41 - line 53 "registrar" - [state = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P4 *)this)->state);
		((P4 *)this)->state = 1;
#ifdef VAR_RANGES
		logval("registrar:state", ((int)((P4 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  58: /* STATE 42 - line 54 "registrar" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  59: /* STATE 43 - line 54 "registrar" - [assert(0)] */
		IfNotBlocked
		assert(0, "0", II, tt, t);
		m = 3; goto P999;

		 /* PROC applicant */
	case  60: /* STATE 1 - line 10 "applicant" - [state = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 1;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  61: /* STATE 80 - line 90 "applicant" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  62: /* STATE 2 - line 13 "applicant" - [user_to_appl[n]?type] */
		if (q_zero(now.user_to_appl[ Index(((int)((P3 *)this)->n), 2) ]))
		{	if (boq != now.user_to_appl[ Index(((int)((P3 *)this)->n), 2) ]) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(now.user_to_appl[ Index(((int)((P3 *)this)->n), 2) ]) == 0) continue;
	{
		int XX=1;
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
		if (t->atom&2)
#endif
			sv_save((char *)&now);
		((P3 *)this)->type = qrecv(now.user_to_appl[ Index(((int)((P3 *)this)->n), 2) ], XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("applicant:type", ((int)((P3 *)this)->type));
#endif
		;
	}
		if (q_zero(now.user_to_appl[ Index(((int)((P3 *)this)->n), 2) ])) boq = -1;
		m = 4; goto P999;
	case  63: /* STATE 3 - line 15 "applicant" - [((type==reqjoin))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->type)==5)))
			continue;
		m = 3; goto P999;
	case  64: /* STATE 4 - line 17 "applicant" - [((state==1))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==1)))
			continue;
		m = 3; goto P999;
	case  65: /* STATE 5 - line 18 "applicant" - [jointimer = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->jointimer);
		((P3 *)this)->jointimer = 1;
#ifdef VAR_RANGES
		logval("applicant:jointimer", ((int)((P3 *)this)->jointimer));
#endif
		;
		m = 3; goto P999;
	case  66: /* STATE 6 - line 19 "applicant" - [appl_to_llc[n]!join] */
		IfNotBlocked
		if (q_full(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]))
		{ nlost++; m=3; goto P999; }

		qsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ], 0, 3);
		if (q_zero(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ])) { boq = now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]; };
		m = 2; goto P999;
	case  67: /* STATE 7 - line 20 "applicant" - [state = 2] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 2;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  68: /* STATE 14 - line 26 "applicant" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  69: /* STATE 8 - line 21 "applicant" - [((state==2))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==2)))
			continue;
		m = 3; goto P999;
	case  70: /* STATE 34 - line 45 "applicant" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  71: /* STATE 81 - line 12 "applicant" - [break] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  72: /* STATE 82 - line 90 "applicant" - [-end-] */
		IfNotBlocked
		if (!delproc(1, II)) continue;
		m = 3; goto P999;
	case  73: /* STATE 9 - line 22 "applicant" - [((state==3))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==3)))
			continue;
		m = 3; goto P999;
	case  74: /* STATE 10 - line 23 "applicant" - [((state==4))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==4)))
			continue;
		m = 3; goto P999;
	case  75: /* STATE 11 - line 24 "applicant" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  76: /* STATE 12 - line 24 "applicant" - [assert(0)] */
		IfNotBlocked
		assert(0, "0", II, tt, t);
		m = 3; goto P999;
	case  77: /* STATE 15 - line 26 "applicant" - [((type==reqleave))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->type)==4)))
			continue;
		m = 3; goto P999;
	case  78: /* STATE 16 - line 28 "applicant" - [((state==1))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==1)))
			continue;
		m = 3; goto P999;
	case  79: /* STATE 31 - line 42 "applicant" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  80: /* STATE 17 - line 29 "applicant" - [((state==2))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==2)))
			continue;
		m = 3; goto P999;
	case  81: /* STATE 18 - line 30 "applicant" - [jointimer = 0] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->jointimer);
		((P3 *)this)->jointimer = 0;
#ifdef VAR_RANGES
		logval("applicant:jointimer", ((int)((P3 *)this)->jointimer));
#endif
		;
		m = 3; goto P999;
	case  82: /* STATE 19 - line 31 "applicant" - [appl_to_llc[n]!leave] */
		IfNotBlocked
		if (q_full(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]))
		{ nlost++; m=3; goto P999; }

		qsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ], 0, 2);
		if (q_zero(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ])) { boq = now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]; };
		m = 2; goto P999;
	case  83: /* STATE 20 - line 32 "applicant" - [state = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 1;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  84: /* STATE 21 - line 33 "applicant" - [((state==3))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==3)))
			continue;
		m = 3; goto P999;
	case  85: /* STATE 22 - line 34 "applicant" - [appl_to_llc[n]!leave] */
		IfNotBlocked
		if (q_full(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]))
		{ nlost++; m=3; goto P999; }

		qsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ], 0, 2);
		if (q_zero(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ])) { boq = now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]; };
		m = 2; goto P999;
	case  86: /* STATE 23 - line 35 "applicant" - [state = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 1;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  87: /* STATE 24 - line 36 "applicant" - [((state==4))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==4)))
			continue;
		m = 3; goto P999;
	case  88: /* STATE 25 - line 37 "applicant" - [jointimer = 0] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->jointimer);
		((P3 *)this)->jointimer = 0;
#ifdef VAR_RANGES
		logval("applicant:jointimer", ((int)((P3 *)this)->jointimer));
#endif
		;
		m = 3; goto P999;
	case  89: /* STATE 26 - line 38 "applicant" - [appl_to_llc[n]!leave] */
		IfNotBlocked
		if (q_full(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]))
		{ nlost++; m=3; goto P999; }

		qsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ], 0, 2);
		if (q_zero(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ])) { boq = now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]; };
		m = 2; goto P999;
	case  90: /* STATE 27 - line 39 "applicant" - [state = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 1;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  91: /* STATE 28 - line 40 "applicant" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  92: /* STATE 29 - line 40 "applicant" - [assert(0)] */
		IfNotBlocked
		assert(0, "0", II, tt, t);
		m = 3; goto P999;
	case  93: /* STATE 32 - line 42 "applicant" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  94: /* STATE 35 - line 45 "applicant" - [llc_to_appl[n]?type] */
		if (q_zero(now.llc_to_appl[ Index(((int)((P3 *)this)->n), 2) ]))
		{	if (boq != now.llc_to_appl[ Index(((int)((P3 *)this)->n), 2) ]) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(now.llc_to_appl[ Index(((int)((P3 *)this)->n), 2) ]) == 0) continue;
	{
		int XX=1;
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
		if (t->atom&2)
#endif
			sv_save((char *)&now);
		((P3 *)this)->type = qrecv(now.llc_to_appl[ Index(((int)((P3 *)this)->n), 2) ], XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("applicant:type", ((int)((P3 *)this)->type));
#endif
		;
	}
		if (q_zero(now.llc_to_appl[ Index(((int)((P3 *)this)->n), 2) ])) boq = -1;
		m = 4; goto P999;
	case  95: /* STATE 36 - line 47 "applicant" - [((type==join))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->type)==3)))
			continue;
		m = 3; goto P999;
	case  96: /* STATE 37 - line 49 "applicant" - [((state==1))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==1)))
			continue;
		m = 3; goto P999;
	case  97: /* STATE 48 - line 59 "applicant" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  98: /* STATE 38 - line 50 "applicant" - [((state==2))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==2)))
			continue;
		m = 3; goto P999;
	case  99: /* STATE 39 - line 51 "applicant" - [jointimer = 0] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->jointimer);
		((P3 *)this)->jointimer = 0;
#ifdef VAR_RANGES
		logval("applicant:jointimer", ((int)((P3 *)this)->jointimer));
#endif
		;
		m = 3; goto P999;
	case  100: /* STATE 40 - line 52 "applicant" - [state = 3] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 3;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  101: /* STATE 65 - line 75 "applicant" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  102: /* STATE 41 - line 53 "applicant" - [((state==3))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==3)))
			continue;
		m = 3; goto P999;
	case  103: /* STATE 42 - line 54 "applicant" - [((state==4))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==4)))
			continue;
		m = 3; goto P999;
	case  104: /* STATE 43 - line 55 "applicant" - [jointimer = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->jointimer);
		((P3 *)this)->jointimer = 1;
#ifdef VAR_RANGES
		logval("applicant:jointimer", ((int)((P3 *)this)->jointimer));
#endif
		;
		m = 3; goto P999;
	case  105: /* STATE 44 - line 56 "applicant" - [state = 2] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 2;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  106: /* STATE 45 - line 57 "applicant" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  107: /* STATE 46 - line 57 "applicant" - [assert(0)] */
		IfNotBlocked
		assert(0, "0", II, tt, t);
		m = 3; goto P999;
	case  108: /* STATE 49 - line 59 "applicant" - [(((type==leave)||(type==leaveall)))] */
		IfNotBlocked
		if (!(((((int)((P3 *)this)->type)==2)||(((int)((P3 *)this)->type)==1))))
			continue;
		m = 3; goto P999;
	case  109: /* STATE 50 - line 61 "applicant" - [((state==1))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==1)))
			continue;
		m = 3; goto P999;
	case  110: /* STATE 62 - line 72 "applicant" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  111: /* STATE 51 - line 62 "applicant" - [((state==2))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==2)))
			continue;
		m = 3; goto P999;
	case  112: /* STATE 52 - line 63 "applicant" - [jointimer = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->jointimer);
		((P3 *)this)->jointimer = 1;
#ifdef VAR_RANGES
		logval("applicant:jointimer", ((int)((P3 *)this)->jointimer));
#endif
		;
		m = 3; goto P999;
	case  113: /* STATE 53 - line 64 "applicant" - [state = 4] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 4;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  114: /* STATE 54 - line 65 "applicant" - [((state==3))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==3)))
			continue;
		m = 3; goto P999;
	case  115: /* STATE 55 - line 66 "applicant" - [jointimer = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->jointimer);
		((P3 *)this)->jointimer = 1;
#ifdef VAR_RANGES
		logval("applicant:jointimer", ((int)((P3 *)this)->jointimer));
#endif
		;
		m = 3; goto P999;
	case  116: /* STATE 56 - line 67 "applicant" - [state = 4] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 4;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  117: /* STATE 57 - line 68 "applicant" - [((state==4))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==4)))
			continue;
		m = 3; goto P999;
	case  118: /* STATE 58 - line 69 "applicant" - [jointimer = 1] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->jointimer);
		((P3 *)this)->jointimer = 1;
#ifdef VAR_RANGES
		logval("applicant:jointimer", ((int)((P3 *)this)->jointimer));
#endif
		;
		m = 3; goto P999;
	case  119: /* STATE 59 - line 70 "applicant" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  120: /* STATE 60 - line 70 "applicant" - [assert(0)] */
		IfNotBlocked
		assert(0, "0", II, tt, t);
		m = 3; goto P999;
	case  121: /* STATE 63 - line 72 "applicant" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  122: /* STATE 66 - line 76 "applicant" - [(((empty(user_to_appl[n])&&empty(llc_to_appl[n]))&&(jointimer==1)))] */
		IfNotBlocked
		if (!((((q_len(now.user_to_appl[ Index(((int)((P3 *)this)->n), 2) ])==0)&&(q_len(now.llc_to_appl[ Index(((int)((P3 *)this)->n), 2) ])==0))&&(((int)((P3 *)this)->jointimer)==1))))
			continue;
		m = 3; goto P999;
	case  123: /* STATE 67 - line 78 "applicant" - [((state==2))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==2)))
			continue;
		m = 3; goto P999;
	case  124: /* STATE 68 - line 79 "applicant" - [jointimer = 0] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->jointimer);
		((P3 *)this)->jointimer = 0;
#ifdef VAR_RANGES
		logval("applicant:jointimer", ((int)((P3 *)this)->jointimer));
#endif
		;
		m = 3; goto P999;
	case  125: /* STATE 69 - line 80 "applicant" - [appl_to_llc[n]!join] */
		IfNotBlocked
		if (q_full(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]))
		{ nlost++; m=3; goto P999; }

		qsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ], 0, 3);
		if (q_zero(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ])) { boq = now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]; };
		m = 2; goto P999;
	case  126: /* STATE 70 - line 81 "applicant" - [state = 3] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 3;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  127: /* STATE 78 - line 89 "applicant" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  128: /* STATE 71 - line 82 "applicant" - [((state==4))] */
		IfNotBlocked
		if (!((((int)((P3 *)this)->state)==4)))
			continue;
		m = 3; goto P999;
	case  129: /* STATE 72 - line 83 "applicant" - [jointimer = 0] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->jointimer);
		((P3 *)this)->jointimer = 0;
#ifdef VAR_RANGES
		logval("applicant:jointimer", ((int)((P3 *)this)->jointimer));
#endif
		;
		m = 3; goto P999;
	case  130: /* STATE 73 - line 84 "applicant" - [appl_to_llc[n]!join] */
		IfNotBlocked
		if (q_full(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]))
		{ nlost++; m=3; goto P999; }

		qsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ], 0, 3);
		if (q_zero(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ])) { boq = now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]; };
		m = 2; goto P999;
	case  131: /* STATE 74 - line 85 "applicant" - [state = 3] */
		IfNotBlocked
		(trpt+1)->oval = ((int)((P3 *)this)->state);
		((P3 *)this)->state = 3;
#ifdef VAR_RANGES
		logval("applicant:state", ((int)((P3 *)this)->state));
#endif
		;
		m = 3; goto P999;
	case  132: /* STATE 75 - line 86 "applicant" - [else] */
		IfNotBlocked
		if (trpt->o_pm&1)
			continue;
		m = 3; goto P999;
	case  133: /* STATE 76 - line 86 "applicant" - [assert(0)] */
		IfNotBlocked
		assert(0, "0", II, tt, t);
		m = 3; goto P999;

		 /* PROC llc */
	case  134: /* STATE 38 - line 48 "llc" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  135: /* STATE 1 - line 12 "llc" - [appl_to_llc[0]?type] */
		if (q_zero(now.appl_to_llc[0]))
		{	if (boq != now.appl_to_llc[0]) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(now.appl_to_llc[0]) == 0) continue;
	{
		int XX=1;
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
		if (t->atom&2)
#endif
			sv_save((char *)&now);
		((P2 *)this)->type = qrecv(now.appl_to_llc[0], XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("llc:type", ((int)((P2 *)this)->type));
#endif
		;
	}
		if (q_zero(now.appl_to_llc[0])) boq = -1;
		m = 4; goto P999;
	case  136: /* STATE 2 - line 14 "llc" - [llc_to_appl[1]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[1]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[1], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[1])) { boq = now.llc_to_appl[1]; };
		m = 2; goto P999;
	case  137: /* STATE 3 - line 14 "llc" - [llc_to_regist!type] */
		IfNotBlocked
		if (q_full(now.llc_to_regist))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_regist, 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_regist)) { boq = now.llc_to_regist; };
		m = 2; goto P999;
	case  138: /* STATE 8 - line 19 "llc" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  139: /* STATE 4 - line 15 "llc" - [llc_to_appl[1]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[1]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[1], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[1])) { boq = now.llc_to_appl[1]; };
		m = 2; goto P999;
	case  140: /* STATE 39 - line 10 "llc" - [break] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  141: /* STATE 40 - line 48 "llc" - [-end-] */
		IfNotBlocked
		if (!delproc(1, II)) continue;
		m = 3; goto P999;
	case  142: /* STATE 5 - line 16 "llc" - [llc_to_regist!type] */
		IfNotBlocked
		if (q_full(now.llc_to_regist))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_regist, 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_regist)) { boq = now.llc_to_regist; };
		m = 2; goto P999;
	case  143: /* STATE 6 - line 17 "llc" - [(1)] */
		IfNotBlocked
		if (!(1))
			continue;
		m = 3; goto P999;
	case  144: /* STATE 10 - line 21 "llc" - [appl_to_llc[1]?type] */
		if (q_zero(now.appl_to_llc[1]))
		{	if (boq != now.appl_to_llc[1]) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(now.appl_to_llc[1]) == 0) continue;
	{
		int XX=1;
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
		if (t->atom&2)
#endif
			sv_save((char *)&now);
		((P2 *)this)->type = qrecv(now.appl_to_llc[1], XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("llc:type", ((int)((P2 *)this)->type));
#endif
		;
	}
		if (q_zero(now.appl_to_llc[1])) boq = -1;
		m = 4; goto P999;
	case  145: /* STATE 11 - line 23 "llc" - [llc_to_appl[0]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[0]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[0], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[0])) { boq = now.llc_to_appl[0]; };
		m = 2; goto P999;
	case  146: /* STATE 12 - line 23 "llc" - [llc_to_regist!type] */
		IfNotBlocked
		if (q_full(now.llc_to_regist))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_regist, 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_regist)) { boq = now.llc_to_regist; };
		m = 2; goto P999;
	case  147: /* STATE 17 - line 28 "llc" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  148: /* STATE 13 - line 24 "llc" - [llc_to_appl[0]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[0]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[0], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[0])) { boq = now.llc_to_appl[0]; };
		m = 2; goto P999;
	case  149: /* STATE 14 - line 25 "llc" - [llc_to_regist!type] */
		IfNotBlocked
		if (q_full(now.llc_to_regist))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_regist, 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_regist)) { boq = now.llc_to_regist; };
		m = 2; goto P999;
	case  150: /* STATE 15 - line 26 "llc" - [(1)] */
		IfNotBlocked
		if (!(1))
			continue;
		m = 3; goto P999;
	case  151: /* STATE 19 - line 30 "llc" - [regist_to_llc?type] */
		if (q_zero(now.regist_to_llc))
		{	if (boq != now.regist_to_llc) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(now.regist_to_llc) == 0) continue;
	{
		int XX=1;
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
		if (t->atom&2)
#endif
			sv_save((char *)&now);
		((P2 *)this)->type = qrecv(now.regist_to_llc, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("llc:type", ((int)((P2 *)this)->type));
#endif
		;
	}
		if (q_zero(now.regist_to_llc)) boq = -1;
		m = 4; goto P999;
	case  152: /* STATE 20 - line 32 "llc" - [llc_to_appl[0]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[0]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[0], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[0])) { boq = now.llc_to_appl[0]; };
		m = 2; goto P999;
	case  153: /* STATE 21 - line 32 "llc" - [llc_to_appl[1]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[1]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[1], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[1])) { boq = now.llc_to_appl[1]; };
		m = 2; goto P999;
	case  154: /* STATE 26 - line 37 "llc" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  155: /* STATE 22 - line 33 "llc" - [llc_to_appl[0]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[0]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[0], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[0])) { boq = now.llc_to_appl[0]; };
		m = 2; goto P999;
	case  156: /* STATE 23 - line 34 "llc" - [llc_to_appl[1]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[1]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[1], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[1])) { boq = now.llc_to_appl[1]; };
		m = 2; goto P999;
	case  157: /* STATE 24 - line 35 "llc" - [(1)] */
		IfNotBlocked
		if (!(1))
			continue;
		m = 3; goto P999;
	case  158: /* STATE 28 - line 39 "llc" - [leaveall_to_llc?type] */
		if (q_zero(now.leaveall_to_llc))
		{	if (boq != now.leaveall_to_llc) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(now.leaveall_to_llc) == 0) continue;
	{
		int XX=1;
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
		if (t->atom&2)
#endif
			sv_save((char *)&now);
		((P2 *)this)->type = qrecv(now.leaveall_to_llc, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("llc:type", ((int)((P2 *)this)->type));
#endif
		;
	}
		if (q_zero(now.leaveall_to_llc)) boq = -1;
		m = 4; goto P999;
	case  159: /* STATE 29 - line 41 "llc" - [llc_to_appl[0]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[0]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[0], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[0])) { boq = now.llc_to_appl[0]; };
		m = 2; goto P999;
	case  160: /* STATE 30 - line 41 "llc" - [llc_to_appl[1]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[1]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[1], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[1])) { boq = now.llc_to_appl[1]; };
		m = 2; goto P999;
	case  161: /* STATE 35 - line 46 "llc" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  162: /* STATE 31 - line 42 "llc" - [llc_to_appl[0]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[0]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[0], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[0])) { boq = now.llc_to_appl[0]; };
		m = 2; goto P999;
	case  163: /* STATE 32 - line 43 "llc" - [llc_to_appl[1]!type] */
		IfNotBlocked
		if (q_full(now.llc_to_appl[1]))
		{ nlost++; m=3; goto P999; }

		qsend(now.llc_to_appl[1], 0, ((int)((P2 *)this)->type));
		if (q_zero(now.llc_to_appl[1])) { boq = now.llc_to_appl[1]; };
		m = 2; goto P999;
	case  164: /* STATE 33 - line 44 "llc" - [(1)] */
		IfNotBlocked
		if (!(1))
			continue;
		m = 3; goto P999;

		 /* PROC macuser1 */
	case  165: /* STATE 1 - line 9 "macuser1" - [user_to_appl[n]!reqjoin] */
		IfNotBlocked
		if (q_full(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ]))
		{ nlost++; m=3; goto P999; }

		qsend(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ], 0, 5);
		if (q_zero(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ])) { boq = now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ]; };
		m = 2; goto P999;
	case  166: /* STATE 5 - line 13 "macuser1" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  167: /* STATE 2 - line 10 "macuser1" - [user_to_appl[n]!reqleave] */
		IfNotBlocked
		if (q_full(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ]))
		{ nlost++; m=3; goto P999; }

		qsend(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ], 0, 4);
		if (q_zero(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ])) { boq = now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ]; };
		m = 2; goto P999;
	case  168: /* STATE 6 - line 13 "macuser1" - [-end-] */
		IfNotBlocked
		if (!delproc(1, II)) continue;
		m = 3; goto P999;
	case  169: /* STATE 3 - line 11 "macuser1" - [(1)] */
		IfNotBlocked
		if (!(1))
			continue;
		m = 3; goto P999;

		 /* PROC macuser */
	case  170: /* STATE 5 - line 14 "macuser" - [.(goto)] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  171: /* STATE 1 - line 10 "macuser" - [user_to_appl[n]!reqjoin] */
		IfNotBlocked
		if (q_full(now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ]))
		{ nlost++; m=3; goto P999; }

		qsend(now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ], 0, 5);
		if (q_zero(now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ])) { boq = now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ]; };
		m = 2; goto P999;
	case  172: /* STATE 6 - line 9 "macuser" - [break] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  173: /* STATE 7 - line 14 "macuser" - [-end-] */
		IfNotBlocked
		if (!delproc(1, II)) continue;
		m = 3; goto P999;
	case  174: /* STATE 2 - line 11 "macuser" - [user_to_appl[n]!reqleave] */
		IfNotBlocked
		if (q_full(now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ]))
		{ nlost++; m=3; goto P999; }

		qsend(now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ], 0, 4);
		if (q_zero(now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ])) { boq = now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ]; };
		m = 2; goto P999;
	case  175: /* STATE 3 - line 12 "macuser" - [goto] */
		IfNotBlocked
		;
		m = 3; goto P999;
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		m = 3; goto P999;
	}

