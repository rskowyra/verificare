	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :never: */
	case  15: /* STATE 20 */
		p_restor(II);
		goto R999;

		 /* PROC :init: */
	case  18: /* STATE 1 */
		now.pid = trpt->oval;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  19: /* STATE 2 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  20: /* STATE 3 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  21: /* STATE 4 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  22: /* STATE 5 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  23: /* STATE 6 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  24: /* STATE 8 */
		p_restor(II);
		goto R999;

		 /* PROC registrar */
	case  25: /* STATE 1 */
		now.r_state = trpt->oval;
		goto R999;
	case  27: /* STATE 2 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  30: /* STATE 5 */
		((P4 *)this)->member_exist = trpt->oval;
		goto R999;
	case  31: /* STATE 6 */
		now.r_state = trpt->oval;
		goto R999;
	case  34: /* STATE 8 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  35: /* STATE 9 */
		now.r_state = trpt->oval;
		goto R999;
	case  38: /* STATE 49 */
		p_restor(II);
		goto R999;
	case  40: /* STATE 11 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  41: /* STATE 12 */
		now.r_state = trpt->oval;
		goto R999;
	case  49: /* STATE 21 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  51: /* STATE 23 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  53: /* STATE 25 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  54: /* STATE 26 */
		now.r_state = trpt->oval;
		goto R999;
	case  60: /* STATE 36 */
		if (m == 2) m = unsend(now.regist_to_llc);
		goto R999;
	case  61: /* STATE 37 */
		now.r_state = trpt->oval;
		goto R999;
	case  64: /* STATE 39 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  65: /* STATE 40 */
		((P4 *)this)->member_exist = trpt->oval;
		goto R999;
	case  66: /* STATE 41 */
		now.r_state = trpt->oval;
		goto R999;

		 /* PROC applicant */
	case  69: /* STATE 1 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  71: /* STATE 2 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  74: /* STATE 5 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  75: /* STATE 6 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  76: /* STATE 7 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  81: /* STATE 82 */
		p_restor(II);
		goto R999;
	case  90: /* STATE 18 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  91: /* STATE 19 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  92: /* STATE 20 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  94: /* STATE 22 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  95: /* STATE 23 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  97: /* STATE 25 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  98: /* STATE 26 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  99: /* STATE 27 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  103: /* STATE 35 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  108: /* STATE 39 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  109: /* STATE 40 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  113: /* STATE 43 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  114: /* STATE 44 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  121: /* STATE 52 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  122: /* STATE 53 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  124: /* STATE 55 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  125: /* STATE 56 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  127: /* STATE 58 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  133: /* STATE 68 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  134: /* STATE 69 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  135: /* STATE 70 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  138: /* STATE 72 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  139: /* STATE 73 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  140: /* STATE 74 */
		((P3 *)this)->state = trpt->oval;
		goto R999;

		 /* PROC llcnoloss */
	case  144: /* STATE 1 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  145: /* STATE 2 */
		if (m == 2) m = unsend(now.llc_to_appl[1]);
		goto R999;
	case  146: /* STATE 3 */
		if (m == 2) m = unsend(now.llc_to_regist);
		goto R999;
	case  148: /* STATE 13 */
		p_restor(II);
		goto R999;
	case  149: /* STATE 4 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  150: /* STATE 5 */
		if (m == 2) m = unsend(now.llc_to_appl[0]);
		goto R999;
	case  151: /* STATE 6 */
		if (m == 2) m = unsend(now.llc_to_regist);
		goto R999;
	case  152: /* STATE 7 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  153: /* STATE 8 */
		if (m == 2) m = unsend(now.llc_to_appl[0]);
		goto R999;
	case  154: /* STATE 9 */
		if (m == 2) m = unsend(now.llc_to_appl[1]);
		goto R999;

		 /* PROC macuser2 */
	case  155: /* STATE 1 */
		if (m == 2) m = unsend(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ]);
		goto R999;
	case  157: /* STATE 2 */
		if (m == 2) m = unsend(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ]);
		goto R999;
	case  158: /* STATE 6 */
		if (m == 2) m = unsend(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ]);
		goto R999;
	case  160: /* STATE 7 */
		if (m == 2) m = unsend(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ]);
		goto R999;
	case  161: /* STATE 11 */
		p_restor(II);
		goto R999;

		 /* PROC macuser1 */
	case  164: /* STATE 1 */
		if (m == 2) m = unsend(now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ]);
		goto R999;
	case  166: /* STATE 4 */
		p_restor(II);
		goto R999;
	}

