#ifdef PEG
struct T_SRC {
	char *fl; int ln;
} T_SRC[NTRANS];

void
tr_2_src(int m, char *file, int ln)
{	T_SRC[m].fl = file;
	T_SRC[m].ln = ln;
}

void
putpeg(int n, int m)
{	printf("%5d	trans %4d ", m, n);
	printf("file %s line %3d\n",
		T_SRC[n].fl, T_SRC[n].ln);
}
#else
#define tr_2_src(m,f,l)
#endif

void
settable(void)
{	Trans *T;
	Trans *settr(int, int, int, int, int, char *, int, int, int);

	trans = (Trans ***) emalloc(8*sizeof(Trans **));

	/* proctype 6: :never: */

	trans[6] = (Trans **) emalloc(21*sizeof(Trans *));

	T = trans[6][7] = settr(173,0,0,0,0,"IF", 0, 2, 0);
		/* "pan_in":37 */
	T = T->nxt	= settr(173,0,1,0,0,"IF", 0, 2, 0);
		/* "pan_in":37 */
	T = T->nxt	= settr(173,0,3,0,0,"IF", 0, 2, 0);
		/* "pan_in":37 */
	    T->nxt	= settr(173,0,5,0,0,"IF", 0, 2, 0);
		/* "pan_in":37 */
		tr_2_src(1, "pan_in", 38);
	trans[6][1]	= settr(167,0,7,1,0,"(1)", 0, 2, 0);
		tr_2_src(2, "pan_in", 38);
	trans[6][2]	= settr(168,0,7,2,0,"goto", 0, 2, 0);
		tr_2_src(3, "pan_in", 42);
	trans[6][8]	= settr(174,0,11,3,0,".(goto)", 0, 2, 0);
		tr_2_src(4, "pan_in", 39);
	trans[6][3]	= settr(169,0,17,4,0,"((macuser1[pid]._p==user1_end))", 1, 2, 0);
		tr_2_src(5, "pan_in", 39);
	trans[6][4]	= settr(170,0,17,5,0,"goto", 0, 2, 0);
	T = trans[6][11] = settr(177,0,0,0,0,"IF", 0, 2, 0);
		/* "pan_in":43 */
	    T->nxt	= settr(177,0,9,0,0,"IF", 0, 2, 0);
		/* "pan_in":43 */
		tr_2_src(6, "pan_in", 44);
	trans[6][9]	= settr(175,0,17,6,0,"(1)", 0, 2, 0);
		tr_2_src(7, "pan_in", 44);
	trans[6][10]	= settr(176,0,17,7,0,"goto", 0, 2, 0);
		tr_2_src(8, "pan_in", 46);
	trans[6][12]	= settr(178,0,17,8,0,".(goto)", 0, 2, 0);
	T = trans[6][17] = settr(183,0,0,0,0,"IF", 0, 2, 0);
		/* "pan_in":47 */
	T = T->nxt	= settr(183,0,13,0,0,"IF", 0, 2, 0);
		/* "pan_in":47 */
	    T->nxt	= settr(183,0,15,0,0,"IF", 0, 2, 0);
		/* "pan_in":47 */
		tr_2_src(9, "pan_in", 48);
	trans[6][13]	= settr(179,0,17,9,0,"(1)", 0, 2, 0);
		tr_2_src(10, "pan_in", 48);
	trans[6][14]	= settr(180,0,17,10,0,"goto", 0, 2, 0);
		tr_2_src(11, "pan_in", 51);
	trans[6][18]	= settr(184,0,19,11,0,".(goto)", 0, 2, 0);
		tr_2_src(12, "pan_in", 49);
	trans[6][15]	= settr(181,0,11,12,0,"(!((r_state!=1)))", 1, 2, 0);
		tr_2_src(13, "pan_in", 49);
	trans[6][16]	= settr(182,0,11,13,0,"goto", 0, 2, 0);
		tr_2_src(14, "pan_in", 52);
	trans[6][19]	= settr(185,0,20,14,0,"(1)", 0, 2, 0);
		tr_2_src(15, "pan_in", 53);
	trans[6][20]	= settr(186,0,0,15,15,"-end-", 1, 2, 0);
		tr_2_src(16, "pan_in", 40);
	trans[6][5]	= settr(171,0,11,16,0,"((!((r_state!=1))&&(macuser1[pid]._p==user1_end)))", 1, 2, 0);
		tr_2_src(17, "pan_in", 40);
	trans[6][6]	= settr(172,0,11,17,0,"goto", 0, 2, 0);

	/* proctype 5: :init: */

	trans[5] = (Trans **) emalloc(9*sizeof(Trans *));

	T = trans[ 5][7] = settr(165,2,0,0,0,"ATOMIC", 1, 2, 0);
		/* "pan_in":16 */
	T->nxt	= settr(165,2,1,0,0,"ATOMIC", 1, 2, 0);
		/* "pan_in":16 */
		tr_2_src(18, "pan_in", 17);
	trans[5][1]	= settr(159,2,2,18,18,"pid = run macuser1(0)", 1, 2, 0);
		tr_2_src(19, "pan_in", 18);
	trans[5][2]	= settr(160,2,3,19,19,"(run macuser2(1))", 1, 2, 0);
		tr_2_src(20, "pan_in", 19);
	trans[5][3]	= settr(161,2,4,20,20,"(run applicant(0))", 1, 2, 0);
		tr_2_src(21, "pan_in", 20);
	trans[5][4]	= settr(162,2,5,21,21,"(run applicant(1))", 1, 2, 0);
		tr_2_src(22, "pan_in", 21);
	trans[5][5]	= settr(163,2,6,22,22,"(run llcnoloss())", 1, 2, 0);
		tr_2_src(23, "pan_in", 22);
	trans[5][6]	= settr(164,0,8,23,23,"(run registrar(0))", 1, 2, 0);
		tr_2_src(24, "pan_in", 24);
	trans[5][8]	= settr(166,0,0,24,24,"-end-", 1, 2, 0);

	/* proctype 4: registrar */

	trans[4] = (Trans **) emalloc(50*sizeof(Trans *));

		tr_2_src(25, "registrar", 11);
	trans[4][1]	= settr(110,0,46,25,25,"r_state = 1", 1, 2, 0);
		tr_2_src(26, "registrar", 59);
	trans[4][47]	= settr(156,0,46,26,0,".(goto)", 0, 2, 0);
	T = trans[4][46] = settr(155,0,0,0,0,"DO", 0, 2, 0);
		/* "registrar":13 */
	T = T->nxt	= settr(155,0,2,0,0,"DO", 0, 2, 0);
		/* "registrar":13 */
	    T->nxt	= settr(155,0,34,0,0,"DO", 0, 2, 0);
		/* "registrar":13 */
		tr_2_src(27, "registrar", 14);
	trans[4][2]	= settr(111,0,32,27,27,"llc_to_regist?type", 1, 507, 0);
	T = trans[4][32] = settr(141,0,0,0,0,"IF", 0, 2, 0);
		/* "registrar":15 */
	T = T->nxt	= settr(141,0,3,0,0,"IF", 0, 2, 0);
		/* "registrar":15 */
	T = T->nxt	= settr(141,0,18,0,0,"IF", 0, 2, 0);
		/* "registrar":15 */
	    T->nxt	= settr(141,0,31,0,0,"IF", 0, 2, 0);
		/* "registrar":15 */
		tr_2_src(28, "registrar", 16);
	trans[4][3]	= settr(112,0,16,28,0,"((type==join))", 0, 2, 0);
	T = trans[4][16] = settr(125,0,0,0,0,"IF", 0, 2, 0);
		/* "registrar":17 */
	T = T->nxt	= settr(125,0,4,0,0,"IF", 0, 2, 0);
		/* "registrar":17 */
	T = T->nxt	= settr(125,0,7,0,0,"IF", 0, 2, 0);
		/* "registrar":17 */
	T = T->nxt	= settr(125,0,10,0,0,"IF", 0, 2, 0);
		/* "registrar":17 */
	T = T->nxt	= settr(125,0,13,0,0,"IF", 0, 2, 0);
		/* "registrar":17 */
	    T->nxt	= settr(125,0,14,0,0,"IF", 0, 2, 0);
		/* "registrar":17 */
		tr_2_src(29, "registrar", 18);
	trans[4][4]	= settr(113,0,5,29,0,"((r_state==1))", 1, 2, 0);
		tr_2_src(30, "registrar", 19);
	trans[4][5]	= settr(114,0,6,30,30,"member_exist = 1", 0, 2, 0);
		tr_2_src(31, "registrar", 20);
	trans[4][6]	= settr(115,0,46,31,31,"r_state = 4", 1, 2, 0);
		tr_2_src(32, "registrar", 30);
	trans[4][17]	= settr(126,0,46,32,0,".(goto)", 0, 2, 0);
		tr_2_src(33, "registrar", 21);
	trans[4][7]	= settr(116,0,8,33,0,"((r_state==2))", 1, 2, 0);
		tr_2_src(34, "registrar", 22);
	trans[4][8]	= settr(117,0,9,34,34,"leavetimer = 0", 0, 2, 0);
		tr_2_src(35, "registrar", 23);
	trans[4][9]	= settr(118,0,46,35,35,"r_state = 4", 1, 2, 0);
		tr_2_src(36, "registrar", 45);
	trans[4][33]	= settr(142,0,46,36,0,".(goto)", 0, 2, 0);
		tr_2_src(37, "registrar", 13);
	trans[4][48]	= settr(157,0,49,37,0,"break", 0, 2, 0);
		tr_2_src(38, "registrar", 59);
	trans[4][49]	= settr(158,0,0,38,38,"-end-", 1, 2, 0);
		tr_2_src(39, "registrar", 24);
	trans[4][10]	= settr(119,0,11,39,0,"((r_state==3))", 1, 2, 0);
		tr_2_src(40, "registrar", 25);
	trans[4][11]	= settr(120,0,12,40,40,"leavetimer = 0", 0, 2, 0);
		tr_2_src(41, "registrar", 26);
	trans[4][12]	= settr(121,0,46,41,41,"r_state = 4", 1, 2, 0);
		tr_2_src(42, "registrar", 27);
	trans[4][13]	= settr(122,0,46,42,0,"((r_state==4))", 1, 2, 0);
		tr_2_src(43, "registrar", 28);
	trans[4][14]	= settr(123,0,15,43,0,"else", 0, 2, 0);
		tr_2_src(44, "registrar", 28);
	trans[4][15]	= settr(124,0,46,44,0,"assert(0)", 0, 2, 0);
		tr_2_src(45, "registrar", 30);
	trans[4][18]	= settr(127,0,29,45,0,"((type==leave))", 0, 2, 0);
	T = trans[4][29] = settr(138,0,0,0,0,"IF", 0, 2, 0);
		/* "registrar":31 */
	T = T->nxt	= settr(138,0,19,0,0,"IF", 0, 2, 0);
		/* "registrar":31 */
	T = T->nxt	= settr(138,0,20,0,0,"IF", 0, 2, 0);
		/* "registrar":31 */
	T = T->nxt	= settr(138,0,22,0,0,"IF", 0, 2, 0);
		/* "registrar":31 */
	T = T->nxt	= settr(138,0,24,0,0,"IF", 0, 2, 0);
		/* "registrar":31 */
	    T->nxt	= settr(138,0,27,0,0,"IF", 0, 2, 0);
		/* "registrar":31 */
		tr_2_src(46, "registrar", 32);
	trans[4][19]	= settr(128,0,46,46,0,"((r_state==1))", 1, 2, 0);
		tr_2_src(47, "registrar", 42);
	trans[4][30]	= settr(139,0,46,47,0,".(goto)", 0, 2, 0);
		tr_2_src(48, "registrar", 33);
	trans[4][20]	= settr(129,0,21,48,0,"((r_state==2))", 1, 2, 0);
		tr_2_src(49, "registrar", 34);
	trans[4][21]	= settr(130,0,46,49,49,"leavetimer = 1", 0, 2, 0);
		tr_2_src(50, "registrar", 35);
	trans[4][22]	= settr(131,0,23,50,0,"((r_state==3))", 1, 2, 0);
		tr_2_src(51, "registrar", 36);
	trans[4][23]	= settr(132,0,46,51,51,"leavetimer = 1", 0, 2, 0);
		tr_2_src(52, "registrar", 37);
	trans[4][24]	= settr(133,0,25,52,0,"((r_state==4))", 1, 2, 0);
		tr_2_src(53, "registrar", 38);
	trans[4][25]	= settr(134,0,26,53,53,"leavetimer = 1", 0, 2, 0);
		tr_2_src(54, "registrar", 39);
	trans[4][26]	= settr(135,0,46,54,54,"r_state = 2", 1, 2, 0);
		tr_2_src(55, "registrar", 40);
	trans[4][27]	= settr(136,0,28,55,0,"else", 0, 2, 0);
		tr_2_src(56, "registrar", 40);
	trans[4][28]	= settr(137,0,46,56,0,"assert(0)", 0, 2, 0);
		tr_2_src(57, "registrar", 42);
	trans[4][31]	= settr(140,0,46,57,0,"else", 0, 2, 0);
		tr_2_src(58, "registrar", 46);
	trans[4][34]	= settr(143,0,44,58,0,"((empty(llc_to_regist)&&(leavetimer==1)))", 1, 1007, 0);
	T = trans[4][44] = settr(153,0,0,0,0,"IF", 0, 2, 0);
		/* "registrar":47 */
	T = T->nxt	= settr(153,0,35,0,0,"IF", 0, 2, 0);
		/* "registrar":47 */
	T = T->nxt	= settr(153,0,38,0,0,"IF", 0, 2, 0);
		/* "registrar":47 */
	    T->nxt	= settr(153,0,42,0,0,"IF", 0, 2, 0);
		/* "registrar":47 */
		tr_2_src(59, "registrar", 48);
	trans[4][35]	= settr(144,0,36,59,0,"((r_state==2))", 1, 2, 0);
		tr_2_src(60, "registrar", 49);
	trans[4][36]	= settr(145,0,37,60,60,"regist_to_llc!leave", 1, 6, 0);
		tr_2_src(61, "registrar", 50);
	trans[4][37]	= settr(146,0,46,61,61,"r_state = 3", 1, 2, 0);
		tr_2_src(62, "registrar", 58);
	trans[4][45]	= settr(154,0,46,62,0,".(goto)", 0, 2, 0);
		tr_2_src(63, "registrar", 51);
	trans[4][38]	= settr(147,0,39,63,0,"((r_state==3))", 1, 2, 0);
		tr_2_src(64, "registrar", 52);
	trans[4][39]	= settr(148,0,40,64,64,"leavetimer = 0", 0, 2, 0);
		tr_2_src(65, "registrar", 53);
	trans[4][40]	= settr(149,0,41,65,65,"member_exist = 0", 0, 2, 0);
		tr_2_src(66, "registrar", 54);
	trans[4][41]	= settr(150,0,46,66,66,"r_state = 1", 1, 2, 0);
		tr_2_src(67, "registrar", 55);
	trans[4][42]	= settr(151,0,43,67,0,"else", 0, 2, 0);
		tr_2_src(68, "registrar", 55);
	trans[4][43]	= settr(152,0,46,68,0,"assert(0)", 0, 2, 0);

	/* proctype 3: applicant */

	trans[3] = (Trans **) emalloc(83*sizeof(Trans *));

		tr_2_src(69, "applicant", 11);
	trans[3][1]	= settr(28,0,79,69,69,"state = 1", 0, 2, 0);
		tr_2_src(70, "applicant", 91);
	trans[3][80]	= settr(107,0,79,70,0,".(goto)", 0, 2, 0);
	T = trans[3][79] = settr(106,0,0,0,0,"DO", 0, 2, 0);
		/* "applicant":13 */
	T = T->nxt	= settr(106,0,2,0,0,"DO", 0, 2, 0);
		/* "applicant":13 */
	T = T->nxt	= settr(106,0,35,0,0,"DO", 0, 2, 0);
		/* "applicant":13 */
	    T->nxt	= settr(106,0,66,0,0,"DO", 0, 2, 0);
		/* "applicant":13 */
		tr_2_src(71, "applicant", 14);
	trans[3][2]	= settr(29,0,33,71,71,"user_to_appl[n]?type", 1, 503, 0);
	T = trans[3][33] = settr(60,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":15 */
	T = T->nxt	= settr(60,0,3,0,0,"IF", 0, 2, 0);
		/* "applicant":15 */
	T = T->nxt	= settr(60,0,15,0,0,"IF", 0, 2, 0);
		/* "applicant":15 */
	    T->nxt	= settr(60,0,32,0,0,"IF", 0, 2, 0);
		/* "applicant":15 */
		tr_2_src(72, "applicant", 16);
	trans[3][3]	= settr(30,0,13,72,0,"((type==reqjoin))", 0, 2, 0);
	T = trans[3][13] = settr(40,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":17 */
	T = T->nxt	= settr(40,0,4,0,0,"IF", 0, 2, 0);
		/* "applicant":17 */
	T = T->nxt	= settr(40,0,8,0,0,"IF", 0, 2, 0);
		/* "applicant":17 */
	T = T->nxt	= settr(40,0,9,0,0,"IF", 0, 2, 0);
		/* "applicant":17 */
	T = T->nxt	= settr(40,0,10,0,0,"IF", 0, 2, 0);
		/* "applicant":17 */
	    T->nxt	= settr(40,0,11,0,0,"IF", 0, 2, 0);
		/* "applicant":17 */
		tr_2_src(73, "applicant", 18);
	trans[3][4]	= settr(31,0,5,73,0,"((state==1))", 0, 2, 0);
		tr_2_src(74, "applicant", 19);
	trans[3][5]	= settr(32,0,6,74,74,"jointimer = 1", 0, 2, 0);
		tr_2_src(75, "applicant", 20);
	trans[3][6]	= settr(33,0,7,75,75,"appl_to_llc[n]!join", 1, 4, 0);
		tr_2_src(76, "applicant", 21);
	trans[3][7]	= settr(34,0,79,76,76,"state = 2", 0, 2, 0);
		tr_2_src(77, "applicant", 27);
	trans[3][14]	= settr(41,0,79,77,0,".(goto)", 0, 2, 0);
		tr_2_src(78, "applicant", 22);
	trans[3][8]	= settr(35,0,79,78,0,"((state==2))", 0, 2, 0);
		tr_2_src(79, "applicant", 46);
	trans[3][34]	= settr(61,0,79,79,0,".(goto)", 0, 2, 0);
		tr_2_src(80, "applicant", 13);
	trans[3][81]	= settr(108,0,82,80,0,"break", 0, 2, 0);
		tr_2_src(81, "applicant", 91);
	trans[3][82]	= settr(109,0,0,81,81,"-end-", 1, 2, 0);
		tr_2_src(82, "applicant", 23);
	trans[3][9]	= settr(36,0,79,82,0,"((state==3))", 0, 2, 0);
		tr_2_src(83, "applicant", 24);
	trans[3][10]	= settr(37,0,79,83,0,"((state==4))", 0, 2, 0);
		tr_2_src(84, "applicant", 25);
	trans[3][11]	= settr(38,0,12,84,0,"else", 0, 2, 0);
		tr_2_src(85, "applicant", 25);
	trans[3][12]	= settr(39,0,79,85,0,"assert(0)", 0, 2, 0);
		tr_2_src(86, "applicant", 27);
	trans[3][15]	= settr(42,0,30,86,0,"((type==reqleave))", 0, 2, 0);
	T = trans[3][30] = settr(57,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":28 */
	T = T->nxt	= settr(57,0,16,0,0,"IF", 0, 2, 0);
		/* "applicant":28 */
	T = T->nxt	= settr(57,0,17,0,0,"IF", 0, 2, 0);
		/* "applicant":28 */
	T = T->nxt	= settr(57,0,21,0,0,"IF", 0, 2, 0);
		/* "applicant":28 */
	T = T->nxt	= settr(57,0,24,0,0,"IF", 0, 2, 0);
		/* "applicant":28 */
	    T->nxt	= settr(57,0,28,0,0,"IF", 0, 2, 0);
		/* "applicant":28 */
		tr_2_src(87, "applicant", 29);
	trans[3][16]	= settr(43,0,79,87,0,"((state==1))", 0, 2, 0);
		tr_2_src(88, "applicant", 43);
	trans[3][31]	= settr(58,0,79,88,0,".(goto)", 0, 2, 0);
		tr_2_src(89, "applicant", 30);
	trans[3][17]	= settr(44,0,18,89,0,"((state==2))", 0, 2, 0);
		tr_2_src(90, "applicant", 31);
	trans[3][18]	= settr(45,0,19,90,90,"jointimer = 0", 0, 2, 0);
		tr_2_src(91, "applicant", 32);
	trans[3][19]	= settr(46,0,20,91,91,"appl_to_llc[n]!leave", 1, 4, 0);
		tr_2_src(92, "applicant", 33);
	trans[3][20]	= settr(47,0,79,92,92,"state = 1", 0, 2, 0);
		tr_2_src(93, "applicant", 34);
	trans[3][21]	= settr(48,0,22,93,0,"((state==3))", 0, 2, 0);
		tr_2_src(94, "applicant", 35);
	trans[3][22]	= settr(49,0,23,94,94,"appl_to_llc[n]!leave", 1, 4, 0);
		tr_2_src(95, "applicant", 36);
	trans[3][23]	= settr(50,0,79,95,95,"state = 1", 0, 2, 0);
		tr_2_src(96, "applicant", 37);
	trans[3][24]	= settr(51,0,25,96,0,"((state==4))", 0, 2, 0);
		tr_2_src(97, "applicant", 38);
	trans[3][25]	= settr(52,0,26,97,97,"jointimer = 0", 0, 2, 0);
		tr_2_src(98, "applicant", 39);
	trans[3][26]	= settr(53,0,27,98,98,"appl_to_llc[n]!leave", 1, 4, 0);
		tr_2_src(99, "applicant", 40);
	trans[3][27]	= settr(54,0,79,99,99,"state = 1", 0, 2, 0);
		tr_2_src(100, "applicant", 41);
	trans[3][28]	= settr(55,0,29,100,0,"else", 0, 2, 0);
		tr_2_src(101, "applicant", 41);
	trans[3][29]	= settr(56,0,79,101,0,"assert(0)", 0, 2, 0);
		tr_2_src(102, "applicant", 43);
	trans[3][32]	= settr(59,0,79,102,0,"else", 0, 2, 0);
		tr_2_src(103, "applicant", 46);
	trans[3][35]	= settr(62,0,64,103,103,"llc_to_appl[n]?type", 1, 505, 0);
	T = trans[3][64] = settr(91,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":47 */
	T = T->nxt	= settr(91,0,36,0,0,"IF", 0, 2, 0);
		/* "applicant":47 */
	T = T->nxt	= settr(91,0,49,0,0,"IF", 0, 2, 0);
		/* "applicant":47 */
	    T->nxt	= settr(91,0,63,0,0,"IF", 0, 2, 0);
		/* "applicant":47 */
		tr_2_src(104, "applicant", 48);
	trans[3][36]	= settr(63,0,47,104,0,"((type==join))", 0, 2, 0);
	T = trans[3][47] = settr(74,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":49 */
	T = T->nxt	= settr(74,0,37,0,0,"IF", 0, 2, 0);
		/* "applicant":49 */
	T = T->nxt	= settr(74,0,38,0,0,"IF", 0, 2, 0);
		/* "applicant":49 */
	T = T->nxt	= settr(74,0,41,0,0,"IF", 0, 2, 0);
		/* "applicant":49 */
	T = T->nxt	= settr(74,0,42,0,0,"IF", 0, 2, 0);
		/* "applicant":49 */
	    T->nxt	= settr(74,0,45,0,0,"IF", 0, 2, 0);
		/* "applicant":49 */
		tr_2_src(105, "applicant", 50);
	trans[3][37]	= settr(64,0,79,105,0,"((state==1))", 0, 2, 0);
		tr_2_src(106, "applicant", 60);
	trans[3][48]	= settr(75,0,79,106,0,".(goto)", 0, 2, 0);
		tr_2_src(107, "applicant", 51);
	trans[3][38]	= settr(65,0,39,107,0,"((state==2))", 0, 2, 0);
		tr_2_src(108, "applicant", 52);
	trans[3][39]	= settr(66,0,40,108,108,"jointimer = 0", 0, 2, 0);
		tr_2_src(109, "applicant", 53);
	trans[3][40]	= settr(67,0,79,109,109,"state = 3", 0, 2, 0);
		tr_2_src(110, "applicant", 76);
	trans[3][65]	= settr(92,0,79,110,0,".(goto)", 0, 2, 0);
		tr_2_src(111, "applicant", 54);
	trans[3][41]	= settr(68,0,79,111,0,"((state==3))", 0, 2, 0);
		tr_2_src(112, "applicant", 55);
	trans[3][42]	= settr(69,0,43,112,0,"((state==4))", 0, 2, 0);
		tr_2_src(113, "applicant", 56);
	trans[3][43]	= settr(70,0,44,113,113,"jointimer = 1", 0, 2, 0);
		tr_2_src(114, "applicant", 57);
	trans[3][44]	= settr(71,0,79,114,114,"state = 2", 0, 2, 0);
		tr_2_src(115, "applicant", 58);
	trans[3][45]	= settr(72,0,46,115,0,"else", 0, 2, 0);
		tr_2_src(116, "applicant", 58);
	trans[3][46]	= settr(73,0,79,116,0,"assert(0)", 0, 2, 0);
		tr_2_src(117, "applicant", 60);
	trans[3][49]	= settr(76,0,61,117,0,"((type==leave))", 0, 2, 0);
	T = trans[3][61] = settr(88,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":61 */
	T = T->nxt	= settr(88,0,50,0,0,"IF", 0, 2, 0);
		/* "applicant":61 */
	T = T->nxt	= settr(88,0,51,0,0,"IF", 0, 2, 0);
		/* "applicant":61 */
	T = T->nxt	= settr(88,0,54,0,0,"IF", 0, 2, 0);
		/* "applicant":61 */
	T = T->nxt	= settr(88,0,57,0,0,"IF", 0, 2, 0);
		/* "applicant":61 */
	    T->nxt	= settr(88,0,59,0,0,"IF", 0, 2, 0);
		/* "applicant":61 */
		tr_2_src(118, "applicant", 62);
	trans[3][50]	= settr(77,0,79,118,0,"((state==1))", 0, 2, 0);
		tr_2_src(119, "applicant", 73);
	trans[3][62]	= settr(89,0,79,119,0,".(goto)", 0, 2, 0);
		tr_2_src(120, "applicant", 63);
	trans[3][51]	= settr(78,0,52,120,0,"((state==2))", 0, 2, 0);
		tr_2_src(121, "applicant", 64);
	trans[3][52]	= settr(79,0,53,121,121,"jointimer = 1", 0, 2, 0);
		tr_2_src(122, "applicant", 65);
	trans[3][53]	= settr(80,0,79,122,122,"state = 4", 0, 2, 0);
		tr_2_src(123, "applicant", 66);
	trans[3][54]	= settr(81,0,55,123,0,"((state==3))", 0, 2, 0);
		tr_2_src(124, "applicant", 67);
	trans[3][55]	= settr(82,0,56,124,124,"jointimer = 1", 0, 2, 0);
		tr_2_src(125, "applicant", 68);
	trans[3][56]	= settr(83,0,79,125,125,"state = 4", 0, 2, 0);
		tr_2_src(126, "applicant", 69);
	trans[3][57]	= settr(84,0,58,126,0,"((state==4))", 0, 2, 0);
		tr_2_src(127, "applicant", 70);
	trans[3][58]	= settr(85,0,79,127,127,"jointimer = 1", 0, 2, 0);
		tr_2_src(128, "applicant", 71);
	trans[3][59]	= settr(86,0,60,128,0,"else", 0, 2, 0);
		tr_2_src(129, "applicant", 71);
	trans[3][60]	= settr(87,0,79,129,0,"assert(0)", 0, 2, 0);
		tr_2_src(130, "applicant", 73);
	trans[3][63]	= settr(90,0,79,130,0,"else", 0, 2, 0);
		tr_2_src(131, "applicant", 77);
	trans[3][66]	= settr(93,0,77,131,0,"(((empty(user_to_appl[n])&&empty(llc_to_appl[n]))&&(jointimer==1)))", 1, 1003, 1005);
	T = trans[3][77] = settr(104,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":78 */
	T = T->nxt	= settr(104,0,67,0,0,"IF", 0, 2, 0);
		/* "applicant":78 */
	T = T->nxt	= settr(104,0,71,0,0,"IF", 0, 2, 0);
		/* "applicant":78 */
	    T->nxt	= settr(104,0,75,0,0,"IF", 0, 2, 0);
		/* "applicant":78 */
		tr_2_src(132, "applicant", 79);
	trans[3][67]	= settr(94,0,68,132,0,"((state==2))", 0, 2, 0);
		tr_2_src(133, "applicant", 80);
	trans[3][68]	= settr(95,0,69,133,133,"jointimer = 0", 0, 2, 0);
		tr_2_src(134, "applicant", 81);
	trans[3][69]	= settr(96,0,70,134,134,"appl_to_llc[n]!join", 1, 4, 0);
		tr_2_src(135, "applicant", 82);
	trans[3][70]	= settr(97,0,79,135,135,"state = 3", 0, 2, 0);
		tr_2_src(136, "applicant", 90);
	trans[3][78]	= settr(105,0,79,136,0,".(goto)", 0, 2, 0);
		tr_2_src(137, "applicant", 83);
	trans[3][71]	= settr(98,0,72,137,0,"((state==4))", 0, 2, 0);
		tr_2_src(138, "applicant", 84);
	trans[3][72]	= settr(99,0,73,138,138,"jointimer = 0", 0, 2, 0);
		tr_2_src(139, "applicant", 85);
	trans[3][73]	= settr(100,0,74,139,139,"appl_to_llc[n]!join", 1, 4, 0);
		tr_2_src(140, "applicant", 86);
	trans[3][74]	= settr(101,0,79,140,140,"state = 3", 0, 2, 0);
		tr_2_src(141, "applicant", 87);
	trans[3][75]	= settr(102,0,76,141,0,"else", 0, 2, 0);
		tr_2_src(142, "applicant", 87);
	trans[3][76]	= settr(103,0,79,142,0,"assert(0)", 0, 2, 0);

	/* proctype 2: llcnoloss */

	trans[2] = (Trans **) emalloc(14*sizeof(Trans *));

		tr_2_src(143, "llcnoloss", 18);
	trans[2][11]	= settr(25,0,10,143,0,".(goto)", 0, 2, 0);
	T = trans[2][10] = settr(24,0,0,0,0,"DO", 0, 2, 0);
		/* "llcnoloss":10 */
	T = T->nxt	= settr(24,0,1,0,0,"DO", 0, 2, 0);
		/* "llcnoloss":10 */
	T = T->nxt	= settr(24,0,4,0,0,"DO", 0, 2, 0);
		/* "llcnoloss":10 */
	    T->nxt	= settr(24,0,7,0,0,"DO", 0, 2, 0);
		/* "llcnoloss":10 */
		tr_2_src(144, "llcnoloss", 11);
	trans[2][1]	= settr(15,0,2,144,144,"appl_to_llc[0]?type", 1, 504, 0);
		tr_2_src(145, "llcnoloss", 12);
	trans[2][2]	= settr(16,0,3,145,145,"llc_to_appl[1]!type", 1, 5, 0);
		tr_2_src(146, "llcnoloss", 12);
	trans[2][3]	= settr(17,0,10,146,146,"llc_to_regist!type", 1, 7, 0);
		tr_2_src(147, "llcnoloss", 10);
	trans[2][12]	= settr(26,0,13,147,0,"break", 0, 2, 0);
		tr_2_src(148, "llcnoloss", 18);
	trans[2][13]	= settr(27,0,0,148,148,"-end-", 1, 2, 0);
		tr_2_src(149, "llcnoloss", 13);
	trans[2][4]	= settr(18,0,5,149,149,"appl_to_llc[1]?type", 1, 504, 0);
		tr_2_src(150, "llcnoloss", 14);
	trans[2][5]	= settr(19,0,6,150,150,"llc_to_appl[0]!type", 1, 5, 0);
		tr_2_src(151, "llcnoloss", 14);
	trans[2][6]	= settr(20,0,10,151,151,"llc_to_regist!type", 1, 7, 0);
		tr_2_src(152, "llcnoloss", 15);
	trans[2][7]	= settr(21,0,8,152,152,"regist_to_llc?type", 1, 506, 0);
		tr_2_src(153, "llcnoloss", 16);
	trans[2][8]	= settr(22,0,9,153,153,"llc_to_appl[0]!type", 1, 5, 0);
		tr_2_src(154, "llcnoloss", 16);
	trans[2][9]	= settr(23,0,10,154,154,"llc_to_appl[1]!type", 1, 5, 0);

	/* proctype 1: macuser2 */

	trans[1] = (Trans **) emalloc(12*sizeof(Trans *));

	T = trans[1][4] = settr(7,0,0,0,0,"IF", 0, 2, 0);
		/* "macuser2":9 */
	T = T->nxt	= settr(7,0,1,0,0,"IF", 0, 2, 0);
		/* "macuser2":9 */
	T = T->nxt	= settr(7,0,2,0,0,"IF", 0, 2, 0);
		/* "macuser2":9 */
	    T->nxt	= settr(7,0,3,0,0,"IF", 0, 2, 0);
		/* "macuser2":9 */
		tr_2_src(155, "macuser2", 10);
	trans[1][1]	= settr(4,0,9,155,155,"user_to_appl[n]!reqjoin", 1, 3, 0);
		tr_2_src(156, "macuser2", 14);
	trans[1][5]	= settr(8,0,9,156,0,".(goto)", 0, 2, 0);
		tr_2_src(157, "macuser2", 11);
	trans[1][2]	= settr(5,0,9,157,157,"user_to_appl[n]!reqleave", 1, 3, 0);
	T = trans[1][9] = settr(12,0,0,0,0,"IF", 0, 2, 0);
		/* "macuser2":14 */
	T = T->nxt	= settr(12,0,6,0,0,"IF", 0, 2, 0);
		/* "macuser2":14 */
	T = T->nxt	= settr(12,0,7,0,0,"IF", 0, 2, 0);
		/* "macuser2":14 */
	    T->nxt	= settr(12,0,8,0,0,"IF", 0, 2, 0);
		/* "macuser2":14 */
		tr_2_src(158, "macuser2", 15);
	trans[1][6]	= settr(9,0,11,158,158,"user_to_appl[n]!reqjoin", 1, 3, 0);
		tr_2_src(159, "macuser2", 19);
	trans[1][10]	= settr(13,0,11,159,0,".(goto)", 0, 2, 0);
		tr_2_src(160, "macuser2", 16);
	trans[1][7]	= settr(10,0,11,160,160,"user_to_appl[n]!reqleave", 1, 3, 0);
		tr_2_src(161, "macuser2", 19);
	trans[1][11]	= settr(14,0,0,161,161,"-end-", 1, 2, 0);
		tr_2_src(162, "macuser2", 17);
	trans[1][8]	= settr(11,0,11,162,0,"(1)", 0, 2, 0);
		tr_2_src(163, "macuser2", 12);
	trans[1][3]	= settr(6,0,9,163,0,"(1)", 0, 2, 0);

	/* proctype 0: macuser1 */

	trans[0] = (Trans **) emalloc(5*sizeof(Trans *));

	T = trans[ 0][3] = settr(2,2,0,0,0,"ATOMIC", 1, 2, 0);
		/* "macuser1":9 */
	T->nxt	= settr(2,2,1,0,0,"ATOMIC", 1, 3, 0);
		/* "macuser1":9 */
		tr_2_src(164, "macuser1", 11);
	trans[0][1]	= settr(0,2,2,164,164,"user_to_appl[n]!reqjoin", 1, 3, 0);
		tr_2_src(165, "macuser1", 13);
	trans[0][2]	= settr(1,0,4,165,0,"(1)", 1, 3, 0);
		tr_2_src(166, "macuser1", 15);
	trans[0][4]	= settr(3,0,0,166,166,"-end-", 1, 2, 0);
	/* np_ demon: */
	trans[_NP_] = (Trans **) emalloc(2*sizeof(Trans *));
	T = trans[_NP_][0] = settr(9997,0,0,_T2,0,"(1)",   0,2,0);
	    T->nxt	  = settr(9998,0,1,_T5,0,"(np_)", 1,2,0);
	T = trans[_NP_][1] = settr(9999,0,1,_T5,0,"(np_)", 1,2,0);
}

Trans *
settr(	int t_id, int a, int b, int c, int d,
	char *t, int g, int tpe0, int tpe1)
{	Trans *tmp = (Trans *) emalloc(sizeof(Trans));

	tmp->atom  = a&(6|32);	/* only (2|8|32) have meaning */
	if (!g) tmp->atom |= 8;	/* no global references */
	tmp->st    = b;
	tmp->tpe[0] = tpe0;
	tmp->tpe[1] = tpe1;
	tmp->tp    = t;
	tmp->t_id  = t_id;
	tmp->forw  = c;
	tmp->back  = d;
	return tmp;
}

Trans *
cpytr(Trans *a)
{	Trans *tmp = (Trans *) emalloc(sizeof(Trans));

	int i;
	tmp->atom  = a->atom;
	tmp->st    = a->st;
#ifdef HAS_UNLESS
	tmp->e_trans = a->e_trans;
	for (i = 0; i < HAS_UNLESS; i++)
		tmp->escp[i] = a->escp[i];
#endif
	tmp->tpe[0] = a->tpe[0];
	tmp->tpe[1] = a->tpe[1];
	for (i = 0; i < 6; i++)
	{	tmp->qu[i] = a->qu[i];
		tmp->ty[i] = a->ty[i];
	}
	tmp->tp    = (char *) emalloc(strlen(a->tp)+1);
	strcpy(tmp->tp, a->tp);
	tmp->t_id  = a->t_id;
	tmp->forw  = a->forw;
	tmp->back  = a->back;
	return tmp;
}

#ifdef PARTIAL
int
srinc_set(int n)
{	if (n <= 2) return LOCAL;
	if (n <= 2+  DELTA) return Q_FULL_F; /* 's' or nfull  */
	if (n <= 2+2*DELTA) return Q_EMPT_F; /* 'r' or nempty */
	if (n <= 2+3*DELTA) return Q_EMPT_T; /* empty */
	if (n <= 2+4*DELTA) return Q_FULL_T; /* full  */
	if (n ==   5*DELTA) return GLOBAL;
	if (n ==   6*DELTA) return TIMEOUT_F;
	Uerror("cannot happen srinc_class");
	return BAD;
}
int
srunc(int n, int m)
{	switch(m) {
	case Q_FULL_F: return n-2;
	case Q_EMPT_F: return n-2-DELTA;
	case Q_EMPT_T: return n-2-2*DELTA;
	case Q_FULL_T: return n-2-3*DELTA;
	case TIMEOUT_F: return 255;
	}
	Uerror("cannot happen srunc");
	return 0;
}
#endif
int cnt;

void
retrans(int n, int m, int is, short srcln[], uchar reach[])
	/* process n, with m states, is=initial state */
{	Trans *T0, *T1, *T2, *T3;
	int i, j, k, p, h, g, aa;
	if (state_tables >= 3)
	{	printf("STEP 0 proctype %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
	do {
		for (i = 1, cnt = 0; i < m; i++)
		{	T2 = trans[n][i];
			T1 = T2?T2->nxt:(Trans *)0;
/* prescan: */		for (T0 = T1; T0; T0 = T0->nxt)
/* choice in choice */	{	if (T0->st
				&&  trans[n][T0->st]->nxt)
					break;
			}
#if 0
		if (T0)
		printf("\tstate %d / %d: choice in choice\n",
		i, T0->st);
#endif
			if (T0)
			for (T0 = T1; T0; T0 = T0->nxt)
			{	T3 = trans[n][T0->st];
				if (!T3->nxt)
				{	T2->nxt = cpytr(T0);
					T2 = T2->nxt;
					imed(T2, T0->st, n);
					continue;
				}
				do {	T3 = T3->nxt;
					T2->nxt = cpytr(T3);
					T2 = T2->nxt;
					imed(T2, T0->st, n);
				} while (T3->nxt);
				cnt++;
			}
		}
	} while (cnt);
	if (state_tables >= 2)
	{	printf("STEP 2 proctype %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
	for (i = 1; i < m; i++)
	{	if (trans[n][i] && trans[n][i]->nxt) /* optimize */
		{	T1 = trans[n][i]->nxt;
#if 0
			printf("\t\tpull %d (%d) to %d\n",
			T1->st, T1->forw, i);
#endif
			T0 = cpytr(trans[n][T1->st]);
			trans[n][i] = T0;
			reach[T1->st] = 1;
			imed(T0, T1->st, n);
			for (T1 = T1->nxt; T1; T1 = T1->nxt)
			{
#if 0
			printf("\t\tpull %d (%d) to %d\n",
				T1->st, T1->forw, i);
#endif
				T0->nxt = cpytr(trans[n][T1->st]);
				T0 = T0->nxt;
				reach[T1->st] = 1;
				imed(T0, T1->st, n);
	}	}	}
	if (state_tables > 1)
	{	printf("STEP 3 proctype %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
#ifdef HAS_UNLESS
	for (i = 1; i < m; i++)
	{	if (!trans[n][i]) continue;
		/* check for each state i if an
		 * escape to some state p is defined
		 * if so, copy and mark p's transitions
		 * and prepend them to the transition-
		 * list of state i
		 */
		T0 = trans[n][i];
		for (k = HAS_UNLESS-1; k >= 0; k--)
		{	if (p = T0->escp[k])
			for (T1 = trans[n][p]; T1; T1 = T1->nxt)
			{	T2 = cpytr(T1);
				T2->e_trans = p;
				T2->nxt = trans[n][i];
				trans[n][i] = T2;
		}	}
	}
#endif
#ifdef PARTIAL
	for (i = 1; i < m; i++)
	{
		if (a_cycles)
		{ /* moves through these states are visible */
#if PROG_LAB>0 && defined(HAS_NP)
			if (progstate[n][i])
				goto degrade;
			for (T1 = trans[n][i]; T1; T1 = T1->nxt)
				if (progstate[n][T1->st])
					goto degrade;
#endif
			if (accpstate[n][i])
				goto degrade;
			for (T1 = trans[n][i]; T1; T1 = T1->nxt)
				if (accpstate[n][T1->st])
					goto degrade;
		}
		T1 = trans[n][i];
		if (!T1) continue;
		/* check if mixing of guards preserves reduction */
		if (T1->nxt)
		{	k = 0;
			for (T0 = T1; T0; T0 = T0->nxt)
			{	if (!(T0->atom&8))
					goto degrade;
				for (aa = 0; aa < 2; aa++)
				{	if (srinc_set(T0->tpe[aa])
					>=  GLOBAL)
						goto degrade;
					if (T0->tpe[aa]
					&&  T0->tpe[aa]
					!=  T1->tpe[0])
						k = 1;
			}	}
			g = 0;
			if (k)	/* non-uniform selection */
			for (T0 = T1; T0; T0 = T0->nxt)
			for (aa = 0; aa < 2; aa++)
			{	j = srinc_set(T0->tpe[aa]);
				if (j != LOCAL)
				{	k = srunc(T0->tpe[aa], j);
					for (h = 0; h < 6; h++)
						if (T1->qu[h] == k
						&&  T1->ty[h] == j)
							break;
					if (h >= 6)
					{	T1->qu[g%6] = k;
						T1->ty[g%6] = j;
						g++;
			}	}	}
			if (g > 6)
			{	T1->qu[0] = 0;	/* turn it off */
#if 1
				printf("line %d, ", srcln[i]);
			 	printf("too many types (%d)",
					g);
			  	printf(" in selection\n");
#endif
			  goto degrade;
			}
		}
		/* mark all options global if >=1 is global */
		for (T1 = trans[n][i]; T1; T1 = T1->nxt)
			if (!(T1->atom&8)) break;
		if (T1)
degrade:	for (T1 = trans[n][i]; T1; T1 = T1->nxt)
			T1->atom &= ~8;
		/* can only mix 'r's or 's's if on same chan */
		/* and not mixed with other local operations */
		T1 = trans[n][i]; j = T1->tpe[0];
		if (T1->qu[0]) continue;
		if (T1->nxt && T1->atom&8)
		{ if (j == 5*DELTA)
		  {
#if 1
			printf("warning: line %d ", srcln[i]);
			printf("mixed condition ");
			printf("(defeats reduction)\n");
#endif
			goto degrade;
		  }
		  for (T0 = T1; T0; T0 = T0->nxt)
		  for (aa = 0; aa < 2; aa++)
		  if  (T0->tpe[aa] && T0->tpe[aa] != j)
		  {
#if 1
			printf("warning: line %d ", srcln[i]);
			printf("[%d-%d] mixed %stion ",
				T0->tpe[aa], j, 
				(j==5*DELTA)?"condi":"selec");
			printf("(defeats reduction)\n");
			printf("	'%s' <-> '%s'\n",
				T1->tp, T0->tp);
#endif
			goto degrade;
		} }
	}
#endif
	if (state_tables)
	{	printf("proctype ");
		if (!strcmp(procname[n], ":init:"))
			printf("init\n");
		else
			printf("%s\n", procname[n]);
		for (i = 1; i < m; i++)
			reach[i] = 1;
		tagtable(n, m, is, srcln, reach);
	} else
	for (i = 1; i < m; i++)
	{	int nrelse;
		nrelse = 0;
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
		{	if (strcmp(T0->tp, "else") == 0)
				nrelse++;
		}
		if (nrelse > 1)
		{	printf("error: proctype '%s' state",
				procname[n]);
		  	printf(" %d, inherits %d", i, nrelse);
		  	printf(" 'else' stmnts\n");
			exit(1);
	}	}
}

void
imed(Trans *T, int v, int n)	/* set intermediate state */
{	progstate[n][T->st] |= progstate[n][v];
	accpstate[n][T->st] |= accpstate[n][v];
	stopstate[n][T->st] |= stopstate[n][v];
}

void
tagtable(int n, int m, int is, short srcln[], uchar reach[])
{	Trans *z;

	if (is >= m || !trans[n][is]
	||  is <= 0 || reach[is] == 0)
		return;
	reach[is] = 0;
	if (state_tables)
	for (z = trans[n][is]; z; z = z->nxt)
		crack(n, is, z, srcln);
	for (z = trans[n][is]; z; z = z->nxt)
	{	int i, j;
		tagtable(n, m, z->st, srcln, reach);
#ifdef HAS_UNLESS
		for (i = 0; i < HAS_UNLESS; i++)
		{	j = trans[n][is]->escp[i];
			if (!j) break;
			tagtable(n, m, j, srcln, reach);
		}
#endif
	}
}

void
crack(int n, int j, Trans *z, short srcln[])
{	int i;

	if (!z) return;
	printf("	state %3d -(tr %3d)-> state %3d  ",
		j, z->forw, z->st);
	printf("[id %3d tp %3d", z->t_id, z->tpe[0]);
	if (z->tpe[1]) printf(",%d", z->tpe[1]);
#ifdef HAS_UNLESS
	if (z->e_trans)
		printf(" org %3d", z->e_trans);
	else if (state_tables >= 2)
	for (i = 0; i < HAS_UNLESS; i++)
	{	if (!z->escp[i]) break;
		printf(" esc %d", z->escp[i]);
	}
#endif
	printf("]");
	printf(" [%s%s%s%s%s] line %d => ",
		z->atom&6?"A":z->atom&32?"D":"-",
		accpstate[n][j]?"a" :"-",
		stopstate[n][j]?"e" : "-",
		progstate[n][j]?"p" : "-",
		z->atom & 8 ?"L":"G",
		srcln[j]);
	for (i = 0; z->tp[i]; i++)
		if (z->tp[i] == '\n')
			printf("\\n");
		else
			putchar(z->tp[i]);
#if 0
	printf("\n");
#else
	if (z->qu[0])
	{	printf("\t[");
		for (i = 0; i < 6; i++)
			if (z->qu[i])
				printf("(%d,%d)",
				z->qu[i], z->ty[i]);
		printf("]");
	}
	printf("\n");
#endif
	fflush(stdout);
}

#ifdef VAR_RANGES
#define BYTESIZE	32	/* 2^8 : 2^3 = 256:8 = 32 */

typedef struct Vr_Ptr {
	char	*nm;
	unsigned char vals[BYTESIZE];
	struct Vr_Ptr *nxt;
} Vr_Ptr;
Vr_Ptr *ranges = (Vr_Ptr *) 0;

void
logval(char *s, int v)
{	Vr_Ptr *tmp;

	if (v<0 || v > 255) return;
	for (tmp = ranges; tmp; tmp = tmp->nxt)
		if (!strcmp(tmp->nm, s))
			goto found;
	tmp = (Vr_Ptr *) emalloc(sizeof(Vr_Ptr));
	tmp->nxt = ranges;
	ranges = tmp;
	tmp->nm = s;
found:
	tmp->vals[(v)/8] |= 1<<((v)%8);
}

void
dumpval(unsigned char X[], int range)
{	int w, x, i, j = -1;

	for (w = i = 0; w < range; w++)
	for (x = 0; x < 8; x++, i++)
	{
from:		if ((X[w] & (1<<x)))
		{	printf("%d", i);
			j = i;
			goto upto;
	}	}
	return;
	for (w = 0; w < range; w++)
	for (x = 0; x < 8; x++, i++)
	{
upto:		if (!(X[w] & (1<<x)))
		{	if (i-1 == j)
				printf(", ");
			else
				printf("-%d, ", i-1);
			goto from;
	}	}
	if (j >= 0 && j != 255)
		printf("-255");
}

void
dumpranges(void)
{	Vr_Ptr *tmp;
	printf("\nValues assigned within ");
	printf("interval [0..255]:\n");
	for (tmp = ranges; tmp; tmp = tmp->nxt)
	{	printf("\t%s\t: ", tmp->nm);
		dumpval(tmp->vals, BYTESIZE);
		printf("\n");
	}
}
#endif
