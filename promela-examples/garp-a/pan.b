	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */
	case  1: /* STATE 1 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  2: /* STATE 2 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  3: /* STATE 3 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  4: /* STATE 4 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  5: /* STATE 5 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  6: /* STATE 6 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  7: /* STATE 7 */
		;
		delproc(0, now._nr_pr-1);
		goto R999;
	case  8: /* STATE 9 */
		p_restor(II);
		goto R999;

		 /* PROC leaveallpro */
	case  9: /* STATE 1 */
		((P5 *)this)->leavealltimer = trpt->oval;
		goto R999;
	case  11: /* STATE 2 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  13: /* STATE 8 */
		p_restor(II);
		goto R999;
	case  15: /* STATE 4 */
		if (m == 2) m = unsend(now.leaveall_to_llc);
		goto R999;

		 /* PROC registrar */
	case  16: /* STATE 1 */
		((P4 *)this)->state = trpt->oval;
		goto R999;
	case  18: /* STATE 2 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  21: /* STATE 5 */
		((P4 *)this)->member_exist = trpt->oval;
		goto R999;
	case  22: /* STATE 6 */
		((P4 *)this)->state = trpt->oval;
		goto R999;
	case  25: /* STATE 8 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  26: /* STATE 9 */
		((P4 *)this)->state = trpt->oval;
		goto R999;
	case  29: /* STATE 49 */
		p_restor(II);
		goto R999;
	case  31: /* STATE 11 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  32: /* STATE 12 */
		((P4 *)this)->state = trpt->oval;
		goto R999;
	case  40: /* STATE 21 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  42: /* STATE 23 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  44: /* STATE 25 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  45: /* STATE 26 */
		((P4 *)this)->state = trpt->oval;
		goto R999;
	case  51: /* STATE 36 */
		if (m == 2) m = unsend(now.regist_to_llc);
		goto R999;
	case  52: /* STATE 37 */
		((P4 *)this)->state = trpt->oval;
		goto R999;
	case  55: /* STATE 39 */
		((P4 *)this)->leavetimer = trpt->oval;
		goto R999;
	case  56: /* STATE 40 */
		((P4 *)this)->member_exist = trpt->oval;
		goto R999;
	case  57: /* STATE 41 */
		((P4 *)this)->state = trpt->oval;
		goto R999;

		 /* PROC applicant */
	case  60: /* STATE 1 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  62: /* STATE 2 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  65: /* STATE 5 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  66: /* STATE 6 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  67: /* STATE 7 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  72: /* STATE 82 */
		p_restor(II);
		goto R999;
	case  81: /* STATE 18 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  82: /* STATE 19 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  83: /* STATE 20 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  85: /* STATE 22 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  86: /* STATE 23 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  88: /* STATE 25 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  89: /* STATE 26 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  90: /* STATE 27 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  94: /* STATE 35 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  99: /* STATE 39 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  100: /* STATE 40 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  104: /* STATE 43 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  105: /* STATE 44 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  112: /* STATE 52 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  113: /* STATE 53 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  115: /* STATE 55 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  116: /* STATE 56 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  118: /* STATE 58 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  124: /* STATE 68 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  125: /* STATE 69 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  126: /* STATE 70 */
		((P3 *)this)->state = trpt->oval;
		goto R999;
	case  129: /* STATE 72 */
		((P3 *)this)->jointimer = trpt->oval;
		goto R999;
	case  130: /* STATE 73 */
		if (m == 2) m = unsend(now.appl_to_llc[ Index(((int)((P3 *)this)->n), 2) ]);
		goto R999;
	case  131: /* STATE 74 */
		((P3 *)this)->state = trpt->oval;
		goto R999;

		 /* PROC llc */
	case  135: /* STATE 1 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  136: /* STATE 2 */
		if (m == 2) m = unsend(now.llc_to_appl[1]);
		goto R999;
	case  137: /* STATE 3 */
		if (m == 2) m = unsend(now.llc_to_regist);
		goto R999;
	case  139: /* STATE 4 */
		if (m == 2) m = unsend(now.llc_to_appl[1]);
		goto R999;
	case  141: /* STATE 40 */
		p_restor(II);
		goto R999;
	case  142: /* STATE 5 */
		if (m == 2) m = unsend(now.llc_to_regist);
		goto R999;
	case  144: /* STATE 10 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  145: /* STATE 11 */
		if (m == 2) m = unsend(now.llc_to_appl[0]);
		goto R999;
	case  146: /* STATE 12 */
		if (m == 2) m = unsend(now.llc_to_regist);
		goto R999;
	case  148: /* STATE 13 */
		if (m == 2) m = unsend(now.llc_to_appl[0]);
		goto R999;
	case  149: /* STATE 14 */
		if (m == 2) m = unsend(now.llc_to_regist);
		goto R999;
	case  151: /* STATE 19 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  152: /* STATE 20 */
		if (m == 2) m = unsend(now.llc_to_appl[0]);
		goto R999;
	case  153: /* STATE 21 */
		if (m == 2) m = unsend(now.llc_to_appl[1]);
		goto R999;
	case  155: /* STATE 22 */
		if (m == 2) m = unsend(now.llc_to_appl[0]);
		goto R999;
	case  156: /* STATE 23 */
		if (m == 2) m = unsend(now.llc_to_appl[1]);
		goto R999;
	case  158: /* STATE 28 */
		;
		if (1)
#if defined(FULLSTACK) && defined(NOCOMP) && !defined(BITSTATE)
			sv_restor(!(t->atom&2));
#else
			sv_restor(0);
#endif
		;
		goto R999;
	case  159: /* STATE 29 */
		if (m == 2) m = unsend(now.llc_to_appl[0]);
		goto R999;
	case  160: /* STATE 30 */
		if (m == 2) m = unsend(now.llc_to_appl[1]);
		goto R999;
	case  162: /* STATE 31 */
		if (m == 2) m = unsend(now.llc_to_appl[0]);
		goto R999;
	case  163: /* STATE 32 */
		if (m == 2) m = unsend(now.llc_to_appl[1]);
		goto R999;

		 /* PROC macuser1 */
	case  165: /* STATE 1 */
		if (m == 2) m = unsend(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ]);
		goto R999;
	case  167: /* STATE 2 */
		if (m == 2) m = unsend(now.user_to_appl[ Index(((int)((P1 *)this)->n), 2) ]);
		goto R999;
	case  168: /* STATE 6 */
		p_restor(II);
		goto R999;

		 /* PROC macuser */
	case  171: /* STATE 1 */
		if (m == 2) m = unsend(now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ]);
		goto R999;
	case  173: /* STATE 7 */
		p_restor(II);
		goto R999;
	case  174: /* STATE 2 */
		if (m == 2) m = unsend(now.user_to_appl[ Index(((int)((P0 *)this)->n), 2) ]);
		goto R999;
	}

