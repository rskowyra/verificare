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

	/* proctype 6: :init: */

	trans[6] = (Trans **) emalloc(10*sizeof(Trans *));

	T = trans[ 6][8] = settr(199,2,0,0,0,"ATOMIC", 1, 2, 0);
		/* "pan_in":15 */
	T->nxt	= settr(199,2,1,0,0,"ATOMIC", 1, 2, 0);
		/* "pan_in":15 */
		tr_2_src(1, "pan_in", 16);
	trans[6][1]	= settr(192,2,2,1,1,"(run macuser(0))", 1, 2, 0);
		tr_2_src(2, "pan_in", 16);
	trans[6][2]	= settr(193,2,3,2,2,"(run macuser1(1))", 1, 2, 0);
		tr_2_src(3, "pan_in", 17);
	trans[6][3]	= settr(194,2,4,3,3,"(run llc())", 1, 2, 0);
		tr_2_src(4, "pan_in", 18);
	trans[6][4]	= settr(195,2,5,4,4,"(run applicant(0))", 1, 2, 0);
		tr_2_src(5, "pan_in", 18);
	trans[6][5]	= settr(196,2,6,5,5,"(run applicant(1))", 1, 2, 0);
		tr_2_src(6, "pan_in", 19);
	trans[6][6]	= settr(197,2,7,6,6,"(run registrar(0))", 1, 2, 0);
		tr_2_src(7, "pan_in", 20);
	trans[6][7]	= settr(198,0,9,7,7,"(run leaveallpro(0))", 1, 2, 0);
		tr_2_src(8, "pan_in", 22);
	trans[6][9]	= settr(200,0,0,8,8,"-end-", 1, 2, 0);

	/* proctype 5: leaveallpro */

	trans[5] = (Trans **) emalloc(9*sizeof(Trans *));

		tr_2_src(9, "leaveall", 11);
	trans[5][1]	= settr(184,0,5,9,9,"leavealltimer = 1", 0, 2, 0);
		tr_2_src(10, "leaveall", 19);
	trans[5][6]	= settr(189,0,5,10,0,".(goto)", 0, 2, 0);
	T = trans[5][5] = settr(188,0,0,0,0,"DO", 0, 2, 0);
		/* "leaveall":13 */
	T = T->nxt	= settr(188,0,2,0,0,"DO", 0, 2, 0);
		/* "leaveall":13 */
	    T->nxt	= settr(188,0,3,0,0,"DO", 0, 2, 0);
		/* "leaveall":13 */
		tr_2_src(11, "leaveall", 14);
	trans[5][2]	= settr(185,0,5,11,11,"llc_to_leaveall?type", 1, 509, 0);
		tr_2_src(12, "leaveall", 13);
	trans[5][7]	= settr(190,0,8,12,0,"break", 0, 2, 0);
		tr_2_src(13, "leaveall", 19);
	trans[5][8]	= settr(191,0,0,13,13,"-end-", 1, 2, 0);
		tr_2_src(14, "leaveall", 16);
	trans[5][3]	= settr(186,0,4,14,0,"((empty(llc_to_leaveall)&&(leavealltimer==1)))", 1, 1009, 0);
		tr_2_src(15, "leaveall", 17);
	trans[5][4]	= settr(187,0,5,15,15,"leaveall_to_llc!leaveall", 1, 8, 0);

	/* proctype 4: registrar */

	trans[4] = (Trans **) emalloc(50*sizeof(Trans *));

		tr_2_src(16, "registrar", 10);
	trans[4][1]	= settr(135,0,46,16,16,"state = 1", 0, 2, 0);
		tr_2_src(17, "registrar", 57);
	trans[4][47]	= settr(181,0,46,17,0,".(goto)", 0, 2, 0);
	T = trans[4][46] = settr(180,0,0,0,0,"DO", 0, 2, 0);
		/* "registrar":12 */
	T = T->nxt	= settr(180,0,2,0,0,"DO", 0, 2, 0);
		/* "registrar":12 */
	    T->nxt	= settr(180,0,34,0,0,"DO", 0, 2, 0);
		/* "registrar":12 */
		tr_2_src(18, "registrar", 13);
	trans[4][2]	= settr(136,0,32,18,18,"llc_to_regist?type", 1, 507, 0);
	T = trans[4][32] = settr(166,0,0,0,0,"IF", 0, 2, 0);
		/* "registrar":14 */
	T = T->nxt	= settr(166,0,3,0,0,"IF", 0, 2, 0);
		/* "registrar":14 */
	T = T->nxt	= settr(166,0,18,0,0,"IF", 0, 2, 0);
		/* "registrar":14 */
	    T->nxt	= settr(166,0,31,0,0,"IF", 0, 2, 0);
		/* "registrar":14 */
		tr_2_src(19, "registrar", 15);
	trans[4][3]	= settr(137,0,16,19,0,"((type==join))", 0, 2, 0);
	T = trans[4][16] = settr(150,0,0,0,0,"IF", 0, 2, 0);
		/* "registrar":16 */
	T = T->nxt	= settr(150,0,4,0,0,"IF", 0, 2, 0);
		/* "registrar":16 */
	T = T->nxt	= settr(150,0,7,0,0,"IF", 0, 2, 0);
		/* "registrar":16 */
	T = T->nxt	= settr(150,0,10,0,0,"IF", 0, 2, 0);
		/* "registrar":16 */
	T = T->nxt	= settr(150,0,13,0,0,"IF", 0, 2, 0);
		/* "registrar":16 */
	    T->nxt	= settr(150,0,14,0,0,"IF", 0, 2, 0);
		/* "registrar":16 */
		tr_2_src(20, "registrar", 17);
	trans[4][4]	= settr(138,0,5,20,0,"((state==1))", 0, 2, 0);
		tr_2_src(21, "registrar", 18);
	trans[4][5]	= settr(139,0,6,21,21,"member_exist = 1", 0, 2, 0);
		tr_2_src(22, "registrar", 19);
	trans[4][6]	= settr(140,0,46,22,22,"state = 4", 0, 2, 0);
		tr_2_src(23, "registrar", 29);
	trans[4][17]	= settr(151,0,46,23,0,".(goto)", 0, 2, 0);
		tr_2_src(24, "registrar", 20);
	trans[4][7]	= settr(141,0,8,24,0,"((state==2))", 0, 2, 0);
		tr_2_src(25, "registrar", 21);
	trans[4][8]	= settr(142,0,9,25,25,"leavetimer = 0", 0, 2, 0);
		tr_2_src(26, "registrar", 22);
	trans[4][9]	= settr(143,0,46,26,26,"state = 4", 0, 2, 0);
		tr_2_src(27, "registrar", 44);
	trans[4][33]	= settr(167,0,46,27,0,".(goto)", 0, 2, 0);
		tr_2_src(28, "registrar", 12);
	trans[4][48]	= settr(182,0,49,28,0,"break", 0, 2, 0);
		tr_2_src(29, "registrar", 57);
	trans[4][49]	= settr(183,0,0,29,29,"-end-", 1, 2, 0);
		tr_2_src(30, "registrar", 23);
	trans[4][10]	= settr(144,0,11,30,0,"((state==3))", 0, 2, 0);
		tr_2_src(31, "registrar", 24);
	trans[4][11]	= settr(145,0,12,31,31,"leavetimer = 0", 0, 2, 0);
		tr_2_src(32, "registrar", 25);
	trans[4][12]	= settr(146,0,46,32,32,"state = 4", 0, 2, 0);
		tr_2_src(33, "registrar", 26);
	trans[4][13]	= settr(147,0,46,33,0,"((state==4))", 0, 2, 0);
		tr_2_src(34, "registrar", 27);
	trans[4][14]	= settr(148,0,15,34,0,"else", 0, 2, 0);
		tr_2_src(35, "registrar", 27);
	trans[4][15]	= settr(149,0,46,35,0,"assert(0)", 0, 2, 0);
		tr_2_src(36, "registrar", 29);
	trans[4][18]	= settr(152,0,29,36,0,"(((type==leave)||(type==leaveall)))", 0, 2, 0);
	T = trans[4][29] = settr(163,0,0,0,0,"IF", 0, 2, 0);
		/* "registrar":30 */
	T = T->nxt	= settr(163,0,19,0,0,"IF", 0, 2, 0);
		/* "registrar":30 */
	T = T->nxt	= settr(163,0,20,0,0,"IF", 0, 2, 0);
		/* "registrar":30 */
	T = T->nxt	= settr(163,0,22,0,0,"IF", 0, 2, 0);
		/* "registrar":30 */
	T = T->nxt	= settr(163,0,24,0,0,"IF", 0, 2, 0);
		/* "registrar":30 */
	    T->nxt	= settr(163,0,27,0,0,"IF", 0, 2, 0);
		/* "registrar":30 */
		tr_2_src(37, "registrar", 31);
	trans[4][19]	= settr(153,0,46,37,0,"((state==1))", 0, 2, 0);
		tr_2_src(38, "registrar", 41);
	trans[4][30]	= settr(164,0,46,38,0,".(goto)", 0, 2, 0);
		tr_2_src(39, "registrar", 32);
	trans[4][20]	= settr(154,0,21,39,0,"((state==2))", 0, 2, 0);
		tr_2_src(40, "registrar", 33);
	trans[4][21]	= settr(155,0,46,40,40,"leavetimer = 1", 0, 2, 0);
		tr_2_src(41, "registrar", 34);
	trans[4][22]	= settr(156,0,23,41,0,"((state==3))", 0, 2, 0);
		tr_2_src(42, "registrar", 35);
	trans[4][23]	= settr(157,0,46,42,42,"leavetimer = 1", 0, 2, 0);
		tr_2_src(43, "registrar", 36);
	trans[4][24]	= settr(158,0,25,43,0,"((state==4))", 0, 2, 0);
		tr_2_src(44, "registrar", 37);
	trans[4][25]	= settr(159,0,26,44,44,"leavetimer = 1", 0, 2, 0);
		tr_2_src(45, "registrar", 38);
	trans[4][26]	= settr(160,0,46,45,45,"state = 2", 0, 2, 0);
		tr_2_src(46, "registrar", 39);
	trans[4][27]	= settr(161,0,28,46,0,"else", 0, 2, 0);
		tr_2_src(47, "registrar", 39);
	trans[4][28]	= settr(162,0,46,47,0,"assert(0)", 0, 2, 0);
		tr_2_src(48, "registrar", 41);
	trans[4][31]	= settr(165,0,46,48,0,"else", 0, 2, 0);
		tr_2_src(49, "registrar", 45);
	trans[4][34]	= settr(168,0,44,49,0,"((empty(llc_to_regist)&&(leavetimer==1)))", 1, 1007, 0);
	T = trans[4][44] = settr(178,0,0,0,0,"IF", 0, 2, 0);
		/* "registrar":46 */
	T = T->nxt	= settr(178,0,35,0,0,"IF", 0, 2, 0);
		/* "registrar":46 */
	T = T->nxt	= settr(178,0,38,0,0,"IF", 0, 2, 0);
		/* "registrar":46 */
	    T->nxt	= settr(178,0,42,0,0,"IF", 0, 2, 0);
		/* "registrar":46 */
		tr_2_src(50, "registrar", 47);
	trans[4][35]	= settr(169,0,36,50,0,"((state==2))", 0, 2, 0);
		tr_2_src(51, "registrar", 48);
	trans[4][36]	= settr(170,0,37,51,51,"regist_to_llc!leave", 1, 6, 0);
		tr_2_src(52, "registrar", 49);
	trans[4][37]	= settr(171,0,46,52,52,"state = 3", 0, 2, 0);
		tr_2_src(53, "registrar", 56);
	trans[4][45]	= settr(179,0,46,53,0,".(goto)", 0, 2, 0);
		tr_2_src(54, "registrar", 50);
	trans[4][38]	= settr(172,0,39,54,0,"((state==3))", 0, 2, 0);
		tr_2_src(55, "registrar", 51);
	trans[4][39]	= settr(173,0,40,55,55,"leavetimer = 0", 0, 2, 0);
		tr_2_src(56, "registrar", 52);
	trans[4][40]	= settr(174,0,41,56,56,"member_exist = 0", 0, 2, 0);
		tr_2_src(57, "registrar", 53);
	trans[4][41]	= settr(175,0,46,57,57,"state = 1", 0, 2, 0);
		tr_2_src(58, "registrar", 54);
	trans[4][42]	= settr(176,0,43,58,0,"else", 0, 2, 0);
		tr_2_src(59, "registrar", 54);
	trans[4][43]	= settr(177,0,46,59,0,"assert(0)", 0, 2, 0);

	/* proctype 3: applicant */

	trans[3] = (Trans **) emalloc(83*sizeof(Trans *));

		tr_2_src(60, "applicant", 10);
	trans[3][1]	= settr(53,0,79,60,60,"state = 1", 0, 2, 0);
		tr_2_src(61, "applicant", 90);
	trans[3][80]	= settr(132,0,79,61,0,".(goto)", 0, 2, 0);
	T = trans[3][79] = settr(131,0,0,0,0,"DO", 0, 2, 0);
		/* "applicant":12 */
	T = T->nxt	= settr(131,0,2,0,0,"DO", 0, 2, 0);
		/* "applicant":12 */
	T = T->nxt	= settr(131,0,35,0,0,"DO", 0, 2, 0);
		/* "applicant":12 */
	    T->nxt	= settr(131,0,66,0,0,"DO", 0, 2, 0);
		/* "applicant":12 */
		tr_2_src(62, "applicant", 13);
	trans[3][2]	= settr(54,0,33,62,62,"user_to_appl[n]?type", 1, 503, 0);
	T = trans[3][33] = settr(85,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":14 */
	T = T->nxt	= settr(85,0,3,0,0,"IF", 0, 2, 0);
		/* "applicant":14 */
	T = T->nxt	= settr(85,0,15,0,0,"IF", 0, 2, 0);
		/* "applicant":14 */
	    T->nxt	= settr(85,0,32,0,0,"IF", 0, 2, 0);
		/* "applicant":14 */
		tr_2_src(63, "applicant", 15);
	trans[3][3]	= settr(55,0,13,63,0,"((type==reqjoin))", 0, 2, 0);
	T = trans[3][13] = settr(65,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":16 */
	T = T->nxt	= settr(65,0,4,0,0,"IF", 0, 2, 0);
		/* "applicant":16 */
	T = T->nxt	= settr(65,0,8,0,0,"IF", 0, 2, 0);
		/* "applicant":16 */
	T = T->nxt	= settr(65,0,9,0,0,"IF", 0, 2, 0);
		/* "applicant":16 */
	T = T->nxt	= settr(65,0,10,0,0,"IF", 0, 2, 0);
		/* "applicant":16 */
	    T->nxt	= settr(65,0,11,0,0,"IF", 0, 2, 0);
		/* "applicant":16 */
		tr_2_src(64, "applicant", 17);
	trans[3][4]	= settr(56,0,5,64,0,"((state==1))", 0, 2, 0);
		tr_2_src(65, "applicant", 18);
	trans[3][5]	= settr(57,0,6,65,65,"jointimer = 1", 0, 2, 0);
		tr_2_src(66, "applicant", 19);
	trans[3][6]	= settr(58,0,7,66,66,"appl_to_llc[n]!join", 1, 4, 0);
		tr_2_src(67, "applicant", 20);
	trans[3][7]	= settr(59,0,79,67,67,"state = 2", 0, 2, 0);
		tr_2_src(68, "applicant", 26);
	trans[3][14]	= settr(66,0,79,68,0,".(goto)", 0, 2, 0);
		tr_2_src(69, "applicant", 21);
	trans[3][8]	= settr(60,0,79,69,0,"((state==2))", 0, 2, 0);
		tr_2_src(70, "applicant", 45);
	trans[3][34]	= settr(86,0,79,70,0,".(goto)", 0, 2, 0);
		tr_2_src(71, "applicant", 12);
	trans[3][81]	= settr(133,0,82,71,0,"break", 0, 2, 0);
		tr_2_src(72, "applicant", 90);
	trans[3][82]	= settr(134,0,0,72,72,"-end-", 1, 2, 0);
		tr_2_src(73, "applicant", 22);
	trans[3][9]	= settr(61,0,79,73,0,"((state==3))", 0, 2, 0);
		tr_2_src(74, "applicant", 23);
	trans[3][10]	= settr(62,0,79,74,0,"((state==4))", 0, 2, 0);
		tr_2_src(75, "applicant", 24);
	trans[3][11]	= settr(63,0,12,75,0,"else", 0, 2, 0);
		tr_2_src(76, "applicant", 24);
	trans[3][12]	= settr(64,0,79,76,0,"assert(0)", 0, 2, 0);
		tr_2_src(77, "applicant", 26);
	trans[3][15]	= settr(67,0,30,77,0,"((type==reqleave))", 0, 2, 0);
	T = trans[3][30] = settr(82,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":27 */
	T = T->nxt	= settr(82,0,16,0,0,"IF", 0, 2, 0);
		/* "applicant":27 */
	T = T->nxt	= settr(82,0,17,0,0,"IF", 0, 2, 0);
		/* "applicant":27 */
	T = T->nxt	= settr(82,0,21,0,0,"IF", 0, 2, 0);
		/* "applicant":27 */
	T = T->nxt	= settr(82,0,24,0,0,"IF", 0, 2, 0);
		/* "applicant":27 */
	    T->nxt	= settr(82,0,28,0,0,"IF", 0, 2, 0);
		/* "applicant":27 */
		tr_2_src(78, "applicant", 28);
	trans[3][16]	= settr(68,0,79,78,0,"((state==1))", 0, 2, 0);
		tr_2_src(79, "applicant", 42);
	trans[3][31]	= settr(83,0,79,79,0,".(goto)", 0, 2, 0);
		tr_2_src(80, "applicant", 29);
	trans[3][17]	= settr(69,0,18,80,0,"((state==2))", 0, 2, 0);
		tr_2_src(81, "applicant", 30);
	trans[3][18]	= settr(70,0,19,81,81,"jointimer = 0", 0, 2, 0);
		tr_2_src(82, "applicant", 31);
	trans[3][19]	= settr(71,0,20,82,82,"appl_to_llc[n]!leave", 1, 4, 0);
		tr_2_src(83, "applicant", 32);
	trans[3][20]	= settr(72,0,79,83,83,"state = 1", 0, 2, 0);
		tr_2_src(84, "applicant", 33);
	trans[3][21]	= settr(73,0,22,84,0,"((state==3))", 0, 2, 0);
		tr_2_src(85, "applicant", 34);
	trans[3][22]	= settr(74,0,23,85,85,"appl_to_llc[n]!leave", 1, 4, 0);
		tr_2_src(86, "applicant", 35);
	trans[3][23]	= settr(75,0,79,86,86,"state = 1", 0, 2, 0);
		tr_2_src(87, "applicant", 36);
	trans[3][24]	= settr(76,0,25,87,0,"((state==4))", 0, 2, 0);
		tr_2_src(88, "applicant", 37);
	trans[3][25]	= settr(77,0,26,88,88,"jointimer = 0", 0, 2, 0);
		tr_2_src(89, "applicant", 38);
	trans[3][26]	= settr(78,0,27,89,89,"appl_to_llc[n]!leave", 1, 4, 0);
		tr_2_src(90, "applicant", 39);
	trans[3][27]	= settr(79,0,79,90,90,"state = 1", 0, 2, 0);
		tr_2_src(91, "applicant", 40);
	trans[3][28]	= settr(80,0,29,91,0,"else", 0, 2, 0);
		tr_2_src(92, "applicant", 40);
	trans[3][29]	= settr(81,0,79,92,0,"assert(0)", 0, 2, 0);
		tr_2_src(93, "applicant", 42);
	trans[3][32]	= settr(84,0,79,93,0,"else", 0, 2, 0);
		tr_2_src(94, "applicant", 45);
	trans[3][35]	= settr(87,0,64,94,94,"llc_to_appl[n]?type", 1, 505, 0);
	T = trans[3][64] = settr(116,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":46 */
	T = T->nxt	= settr(116,0,36,0,0,"IF", 0, 2, 0);
		/* "applicant":46 */
	T = T->nxt	= settr(116,0,49,0,0,"IF", 0, 2, 0);
		/* "applicant":46 */
	    T->nxt	= settr(116,0,63,0,0,"IF", 0, 2, 0);
		/* "applicant":46 */
		tr_2_src(95, "applicant", 47);
	trans[3][36]	= settr(88,0,47,95,0,"((type==join))", 0, 2, 0);
	T = trans[3][47] = settr(99,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":48 */
	T = T->nxt	= settr(99,0,37,0,0,"IF", 0, 2, 0);
		/* "applicant":48 */
	T = T->nxt	= settr(99,0,38,0,0,"IF", 0, 2, 0);
		/* "applicant":48 */
	T = T->nxt	= settr(99,0,41,0,0,"IF", 0, 2, 0);
		/* "applicant":48 */
	T = T->nxt	= settr(99,0,42,0,0,"IF", 0, 2, 0);
		/* "applicant":48 */
	    T->nxt	= settr(99,0,45,0,0,"IF", 0, 2, 0);
		/* "applicant":48 */
		tr_2_src(96, "applicant", 49);
	trans[3][37]	= settr(89,0,79,96,0,"((state==1))", 0, 2, 0);
		tr_2_src(97, "applicant", 59);
	trans[3][48]	= settr(100,0,79,97,0,".(goto)", 0, 2, 0);
		tr_2_src(98, "applicant", 50);
	trans[3][38]	= settr(90,0,39,98,0,"((state==2))", 0, 2, 0);
		tr_2_src(99, "applicant", 51);
	trans[3][39]	= settr(91,0,40,99,99,"jointimer = 0", 0, 2, 0);
		tr_2_src(100, "applicant", 52);
	trans[3][40]	= settr(92,0,79,100,100,"state = 3", 0, 2, 0);
		tr_2_src(101, "applicant", 75);
	trans[3][65]	= settr(117,0,79,101,0,".(goto)", 0, 2, 0);
		tr_2_src(102, "applicant", 53);
	trans[3][41]	= settr(93,0,79,102,0,"((state==3))", 0, 2, 0);
		tr_2_src(103, "applicant", 54);
	trans[3][42]	= settr(94,0,43,103,0,"((state==4))", 0, 2, 0);
		tr_2_src(104, "applicant", 55);
	trans[3][43]	= settr(95,0,44,104,104,"jointimer = 1", 0, 2, 0);
		tr_2_src(105, "applicant", 56);
	trans[3][44]	= settr(96,0,79,105,105,"state = 2", 0, 2, 0);
		tr_2_src(106, "applicant", 57);
	trans[3][45]	= settr(97,0,46,106,0,"else", 0, 2, 0);
		tr_2_src(107, "applicant", 57);
	trans[3][46]	= settr(98,0,79,107,0,"assert(0)", 0, 2, 0);
		tr_2_src(108, "applicant", 59);
	trans[3][49]	= settr(101,0,61,108,0,"(((type==leave)||(type==leaveall)))", 0, 2, 0);
	T = trans[3][61] = settr(113,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":60 */
	T = T->nxt	= settr(113,0,50,0,0,"IF", 0, 2, 0);
		/* "applicant":60 */
	T = T->nxt	= settr(113,0,51,0,0,"IF", 0, 2, 0);
		/* "applicant":60 */
	T = T->nxt	= settr(113,0,54,0,0,"IF", 0, 2, 0);
		/* "applicant":60 */
	T = T->nxt	= settr(113,0,57,0,0,"IF", 0, 2, 0);
		/* "applicant":60 */
	    T->nxt	= settr(113,0,59,0,0,"IF", 0, 2, 0);
		/* "applicant":60 */
		tr_2_src(109, "applicant", 61);
	trans[3][50]	= settr(102,0,79,109,0,"((state==1))", 0, 2, 0);
		tr_2_src(110, "applicant", 72);
	trans[3][62]	= settr(114,0,79,110,0,".(goto)", 0, 2, 0);
		tr_2_src(111, "applicant", 62);
	trans[3][51]	= settr(103,0,52,111,0,"((state==2))", 0, 2, 0);
		tr_2_src(112, "applicant", 63);
	trans[3][52]	= settr(104,0,53,112,112,"jointimer = 1", 0, 2, 0);
		tr_2_src(113, "applicant", 64);
	trans[3][53]	= settr(105,0,79,113,113,"state = 4", 0, 2, 0);
		tr_2_src(114, "applicant", 65);
	trans[3][54]	= settr(106,0,55,114,0,"((state==3))", 0, 2, 0);
		tr_2_src(115, "applicant", 66);
	trans[3][55]	= settr(107,0,56,115,115,"jointimer = 1", 0, 2, 0);
		tr_2_src(116, "applicant", 67);
	trans[3][56]	= settr(108,0,79,116,116,"state = 4", 0, 2, 0);
		tr_2_src(117, "applicant", 68);
	trans[3][57]	= settr(109,0,58,117,0,"((state==4))", 0, 2, 0);
		tr_2_src(118, "applicant", 69);
	trans[3][58]	= settr(110,0,79,118,118,"jointimer = 1", 0, 2, 0);
		tr_2_src(119, "applicant", 70);
	trans[3][59]	= settr(111,0,60,119,0,"else", 0, 2, 0);
		tr_2_src(120, "applicant", 70);
	trans[3][60]	= settr(112,0,79,120,0,"assert(0)", 0, 2, 0);
		tr_2_src(121, "applicant", 72);
	trans[3][63]	= settr(115,0,79,121,0,"else", 0, 2, 0);
		tr_2_src(122, "applicant", 76);
	trans[3][66]	= settr(118,0,77,122,0,"(((empty(user_to_appl[n])&&empty(llc_to_appl[n]))&&(jointimer==1)))", 1, 1003, 1005);
	T = trans[3][77] = settr(129,0,0,0,0,"IF", 0, 2, 0);
		/* "applicant":77 */
	T = T->nxt	= settr(129,0,67,0,0,"IF", 0, 2, 0);
		/* "applicant":77 */
	T = T->nxt	= settr(129,0,71,0,0,"IF", 0, 2, 0);
		/* "applicant":77 */
	    T->nxt	= settr(129,0,75,0,0,"IF", 0, 2, 0);
		/* "applicant":77 */
		tr_2_src(123, "applicant", 78);
	trans[3][67]	= settr(119,0,68,123,0,"((state==2))", 0, 2, 0);
		tr_2_src(124, "applicant", 79);
	trans[3][68]	= settr(120,0,69,124,124,"jointimer = 0", 0, 2, 0);
		tr_2_src(125, "applicant", 80);
	trans[3][69]	= settr(121,0,70,125,125,"appl_to_llc[n]!join", 1, 4, 0);
		tr_2_src(126, "applicant", 81);
	trans[3][70]	= settr(122,0,79,126,126,"state = 3", 0, 2, 0);
		tr_2_src(127, "applicant", 89);
	trans[3][78]	= settr(130,0,79,127,0,".(goto)", 0, 2, 0);
		tr_2_src(128, "applicant", 82);
	trans[3][71]	= settr(123,0,72,128,0,"((state==4))", 0, 2, 0);
		tr_2_src(129, "applicant", 83);
	trans[3][72]	= settr(124,0,73,129,129,"jointimer = 0", 0, 2, 0);
		tr_2_src(130, "applicant", 84);
	trans[3][73]	= settr(125,0,74,130,130,"appl_to_llc[n]!join", 1, 4, 0);
		tr_2_src(131, "applicant", 85);
	trans[3][74]	= settr(126,0,79,131,131,"state = 3", 0, 2, 0);
		tr_2_src(132, "applicant", 86);
	trans[3][75]	= settr(127,0,76,132,0,"else", 0, 2, 0);
		tr_2_src(133, "applicant", 86);
	trans[3][76]	= settr(128,0,79,133,0,"assert(0)", 0, 2, 0);

	/* proctype 2: llc */

	trans[2] = (Trans **) emalloc(41*sizeof(Trans *));

		tr_2_src(134, "llc", 48);
	trans[2][38]	= settr(50,0,37,134,0,".(goto)", 0, 2, 0);
	T = trans[2][37] = settr(49,0,0,0,0,"DO", 0, 2, 0);
		/* "llc":10 */
	T = T->nxt	= settr(49,0,9,0,0,"DO", 0, 2, 0);
		/* "llc":10 */
	T = T->nxt	= settr(49,0,18,0,0,"DO", 0, 2, 0);
		/* "llc":10 */
	T = T->nxt	= settr(49,0,27,0,0,"DO", 0, 2, 0);
		/* "llc":10 */
	    T->nxt	= settr(49,0,36,0,0,"DO", 0, 2, 0);
		/* "llc":10 */
	T = trans[ 2][9] = settr(21,2,0,0,0,"ATOMIC", 1, 2, 0);
		/* "llc":11 */
	T->nxt	= settr(21,2,1,0,0,"ATOMIC", 1, 2500, 0);
		/* "llc":11 */
		tr_2_src(135, "llc", 12);
	trans[2][1]	= settr(13,2,7,135,135,"appl_to_llc[0]?type", 1, 2500, 0);
	T = trans[2][7] = settr(19,2,0,0,0,"IF", 1, 2500, 0);
		/* "llc":13 */
	T = T->nxt	= settr(19,2,2,0,0,"IF", 1, 2500, 0);
		/* "llc":13 */
	T = T->nxt	= settr(19,2,4,0,0,"IF", 1, 2500, 0);
		/* "llc":13 */
	T = T->nxt	= settr(19,2,5,0,0,"IF", 1, 2500, 0);
		/* "llc":13 */
	    T->nxt	= settr(19,2,6,0,0,"IF", 1, 2500, 0);
		/* "llc":13 */
		tr_2_src(136, "llc", 14);
	trans[2][2]	= settr(14,2,3,136,136,"llc_to_appl[1]!type", 1, 2500, 0);
		tr_2_src(137, "llc", 14);
	trans[2][3]	= settr(15,2,8,137,137,"llc_to_regist!type", 1, 2500, 0);
		tr_2_src(138, "llc", 19);
	trans[2][8]	= settr(20,0,37,138,0,".(goto)", 1, 2500, 0);
		tr_2_src(139, "llc", 15);
	trans[2][4]	= settr(16,2,8,139,139,"llc_to_appl[1]!type", 1, 2500, 0);
		tr_2_src(140, "llc", 10);
	trans[2][39]	= settr(51,0,40,140,0,"break", 0, 2500, 0);
		tr_2_src(141, "llc", 48);
	trans[2][40]	= settr(52,0,0,141,141,"-end-", 1, 2500, 0);
		tr_2_src(142, "llc", 16);
	trans[2][5]	= settr(17,2,8,142,142,"llc_to_regist!type", 1, 2500, 0);
		tr_2_src(143, "llc", 17);
	trans[2][6]	= settr(18,2,8,143,0,"(1)", 1, 2500, 0);
	T = trans[ 2][18] = settr(30,2,0,0,0,"ATOMIC", 1, 2, 0);
		/* "llc":20 */
	T->nxt	= settr(30,2,10,0,0,"ATOMIC", 1, 2500, 0);
		/* "llc":20 */
		tr_2_src(144, "llc", 21);
	trans[2][10]	= settr(22,2,16,144,144,"appl_to_llc[1]?type", 1, 2500, 0);
	T = trans[2][16] = settr(28,2,0,0,0,"IF", 1, 2500, 0);
		/* "llc":22 */
	T = T->nxt	= settr(28,2,11,0,0,"IF", 1, 2500, 0);
		/* "llc":22 */
	T = T->nxt	= settr(28,2,13,0,0,"IF", 1, 2500, 0);
		/* "llc":22 */
	T = T->nxt	= settr(28,2,14,0,0,"IF", 1, 2500, 0);
		/* "llc":22 */
	    T->nxt	= settr(28,2,15,0,0,"IF", 1, 2500, 0);
		/* "llc":22 */
		tr_2_src(145, "llc", 23);
	trans[2][11]	= settr(23,2,12,145,145,"llc_to_appl[0]!type", 1, 2500, 0);
		tr_2_src(146, "llc", 23);
	trans[2][12]	= settr(24,2,17,146,146,"llc_to_regist!type", 1, 2500, 0);
		tr_2_src(147, "llc", 28);
	trans[2][17]	= settr(29,0,37,147,0,".(goto)", 1, 2500, 0);
		tr_2_src(148, "llc", 24);
	trans[2][13]	= settr(25,2,17,148,148,"llc_to_appl[0]!type", 1, 2500, 0);
		tr_2_src(149, "llc", 25);
	trans[2][14]	= settr(26,2,17,149,149,"llc_to_regist!type", 1, 2500, 0);
		tr_2_src(150, "llc", 26);
	trans[2][15]	= settr(27,2,17,150,0,"(1)", 1, 2500, 0);
	T = trans[ 2][27] = settr(39,2,0,0,0,"ATOMIC", 1, 2, 0);
		/* "llc":29 */
	T->nxt	= settr(39,2,19,0,0,"ATOMIC", 1, 506, 5);
		/* "llc":29 */
		tr_2_src(151, "llc", 30);
	trans[2][19]	= settr(31,2,25,151,151,"regist_to_llc?type", 1, 506, 5);
	T = trans[2][25] = settr(37,2,0,0,0,"IF", 1, 506, 5);
		/* "llc":31 */
	T = T->nxt	= settr(37,2,20,0,0,"IF", 1, 506, 5);
		/* "llc":31 */
	T = T->nxt	= settr(37,2,22,0,0,"IF", 1, 506, 5);
		/* "llc":31 */
	T = T->nxt	= settr(37,2,23,0,0,"IF", 1, 506, 5);
		/* "llc":31 */
	    T->nxt	= settr(37,2,24,0,0,"IF", 1, 506, 5);
		/* "llc":31 */
		tr_2_src(152, "llc", 32);
	trans[2][20]	= settr(32,2,21,152,152,"llc_to_appl[0]!type", 1, 506, 5);
		tr_2_src(153, "llc", 32);
	trans[2][21]	= settr(33,2,26,153,153,"llc_to_appl[1]!type", 1, 506, 5);
		tr_2_src(154, "llc", 37);
	trans[2][26]	= settr(38,0,37,154,0,".(goto)", 1, 506, 5);
		tr_2_src(155, "llc", 33);
	trans[2][22]	= settr(34,2,26,155,155,"llc_to_appl[0]!type", 1, 506, 5);
		tr_2_src(156, "llc", 34);
	trans[2][23]	= settr(35,2,26,156,156,"llc_to_appl[1]!type", 1, 506, 5);
		tr_2_src(157, "llc", 35);
	trans[2][24]	= settr(36,2,26,157,0,"(1)", 1, 506, 5);
	T = trans[ 2][36] = settr(48,2,0,0,0,"ATOMIC", 1, 2, 0);
		/* "llc":38 */
	T->nxt	= settr(48,2,28,0,0,"ATOMIC", 1, 508, 5);
		/* "llc":38 */
		tr_2_src(158, "llc", 39);
	trans[2][28]	= settr(40,2,34,158,158,"leaveall_to_llc?type", 1, 508, 5);
	T = trans[2][34] = settr(46,2,0,0,0,"IF", 1, 508, 5);
		/* "llc":40 */
	T = T->nxt	= settr(46,2,29,0,0,"IF", 1, 508, 5);
		/* "llc":40 */
	T = T->nxt	= settr(46,2,31,0,0,"IF", 1, 508, 5);
		/* "llc":40 */
	T = T->nxt	= settr(46,2,32,0,0,"IF", 1, 508, 5);
		/* "llc":40 */
	    T->nxt	= settr(46,2,33,0,0,"IF", 1, 508, 5);
		/* "llc":40 */
		tr_2_src(159, "llc", 41);
	trans[2][29]	= settr(41,2,30,159,159,"llc_to_appl[0]!type", 1, 508, 5);
		tr_2_src(160, "llc", 41);
	trans[2][30]	= settr(42,2,35,160,160,"llc_to_appl[1]!type", 1, 508, 5);
		tr_2_src(161, "llc", 46);
	trans[2][35]	= settr(47,0,37,161,0,".(goto)", 1, 508, 5);
		tr_2_src(162, "llc", 42);
	trans[2][31]	= settr(43,2,35,162,162,"llc_to_appl[0]!type", 1, 508, 5);
		tr_2_src(163, "llc", 43);
	trans[2][32]	= settr(44,2,35,163,163,"llc_to_appl[1]!type", 1, 508, 5);
		tr_2_src(164, "llc", 44);
	trans[2][33]	= settr(45,2,35,164,0,"(1)", 1, 508, 5);

	/* proctype 1: macuser1 */

	trans[1] = (Trans **) emalloc(7*sizeof(Trans *));

	T = trans[1][4] = settr(10,0,0,0,0,"IF", 0, 2, 0);
		/* "macuser1":8 */
	T = T->nxt	= settr(10,0,1,0,0,"IF", 0, 2, 0);
		/* "macuser1":8 */
	T = T->nxt	= settr(10,0,2,0,0,"IF", 0, 2, 0);
		/* "macuser1":8 */
	    T->nxt	= settr(10,0,3,0,0,"IF", 0, 2, 0);
		/* "macuser1":8 */
		tr_2_src(165, "macuser1", 9);
	trans[1][1]	= settr(7,0,6,165,165,"user_to_appl[n]!reqjoin", 1, 3, 0);
		tr_2_src(166, "macuser1", 13);
	trans[1][5]	= settr(11,0,6,166,0,".(goto)", 0, 2, 0);
		tr_2_src(167, "macuser1", 10);
	trans[1][2]	= settr(8,0,6,167,167,"user_to_appl[n]!reqleave", 1, 3, 0);
		tr_2_src(168, "macuser1", 13);
	trans[1][6]	= settr(12,0,0,168,168,"-end-", 1, 2, 0);
		tr_2_src(169, "macuser1", 11);
	trans[1][3]	= settr(9,0,6,169,0,"(1)", 0, 2, 0);

	/* proctype 0: macuser */

	trans[0] = (Trans **) emalloc(8*sizeof(Trans *));

		tr_2_src(170, "macuser", 14);
	trans[0][5]	= settr(4,0,4,170,0,".(goto)", 0, 2, 0);
	T = trans[0][4] = settr(3,0,0,0,0,"DO", 0, 2, 0);
		/* "macuser":9 */
	T = T->nxt	= settr(3,0,1,0,0,"DO", 0, 2, 0);
		/* "macuser":9 */
	T = T->nxt	= settr(3,0,2,0,0,"DO", 0, 2, 0);
		/* "macuser":9 */
	    T->nxt	= settr(3,0,3,0,0,"DO", 0, 2, 0);
		/* "macuser":9 */
		tr_2_src(171, "macuser", 10);
	trans[0][1]	= settr(0,0,4,171,171,"user_to_appl[n]!reqjoin", 1, 3, 0);
		tr_2_src(172, "macuser", 9);
	trans[0][6]	= settr(5,0,7,172,0,"break", 0, 2, 0);
		tr_2_src(173, "macuser", 14);
	trans[0][7]	= settr(6,0,0,173,173,"-end-", 1, 2, 0);
		tr_2_src(174, "macuser", 11);
	trans[0][2]	= settr(1,0,4,174,174,"user_to_appl[n]!reqleave", 1, 3, 0);
		tr_2_src(175, "macuser", 12);
	trans[0][3]	= settr(2,0,7,175,0,"goto", 0, 2, 0);
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
