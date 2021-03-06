#define Version	"Spin Version 2.9.3 -- 5 October 1996"
#define Source	"pan_in"

#define uchar	unsigned char
#define DELTA	500
#if !defined(NFAIR)
#define NFAIR	2	/* must be >= 2 */
#endif
#define INLINE	1
#ifdef NP	/* includes np_ demon */
#define HAS_NP	2
#define VERI	7
#define endclaim	3 /* none */
#endif

short nstates6=10;	/* :init: */
#define endstate6	9
short src_ln6 [] = {
	  0,  16,  16,  17,  18,  18,  19,  20, 
	 15,  22,   0, };
uchar reached6 [] = {
	  0,   1,   0,   0,   0,   0,   0,   0, 
	  0,   0,   0, };

short nstates5=9;	/* leaveallpro */
#define endstate5	8
short src_ln5 [] = {
	  0,  11,  14,  16,  17,  13,  19,  13, 
	 19,   0, };
uchar reached5 [] = {
	  0,   0,   1,   1,   0,   0,   1,   1, 
	  0,   0, };

short nstates4=50;	/* registrar */
#define endstate4	49
short src_ln4 [] = {
	  0,  10,  13,  15,  17,  18,  19,  20, 
	 21,  22,  23,  24,  25,  26,  27,  27, 
	 16,  29,  29,  31,  32,  33,  34,  35, 
	 36,  37,  38,  39,  39,  30,  41,  41, 
	 14,  44,  45,  47,  48,  49,  50,  51, 
	 52,  53,  54,  54,  46,  56,  12,  57, 
	 12,  57,   0, };
uchar reached4 [] = {
	  0,   0,   1,   1,   1,   0,   0,   1, 
	  0,   0,   1,   0,   0,   1,   1,   0, 
	  0,   1,   1,   1,   1,   0,   1,   0, 
	  1,   0,   0,   1,   0,   0,   1,   1, 
	  0,   1,   1,   1,   0,   0,   1,   0, 
	  0,   0,   1,   0,   0,   1,   0,   1, 
	  1,   0,   0, };

short nstates3=83;	/* applicant */
#define endstate3	82
short src_ln3 [] = {
	  0,  10,  13,  15,  17,  18,  19,  20, 
	 21,  22,  23,  24,  24,  16,  26,  26, 
	 28,  29,  30,  31,  32,  33,  34,  35, 
	 36,  37,  38,  39,  40,  40,  27,  42, 
	 42,  14,  45,  45,  47,  49,  50,  51, 
	 52,  53,  54,  55,  56,  57,  57,  48, 
	 59,  59,  61,  62,  63,  64,  65,  66, 
	 67,  68,  69,  70,  70,  60,  72,  72, 
	 46,  75,  76,  78,  79,  80,  81,  82, 
	 83,  84,  85,  86,  86,  77,  89,  12, 
	 90,  12,  90,   0, };
uchar reached3 [] = {
	  0,   0,   1,   1,   1,   0,   0,   0, 
	  1,   1,   1,   1,   0,   0,   1,   1, 
	  1,   1,   0,   0,   0,   1,   0,   0, 
	  1,   0,   0,   0,   1,   0,   0,   1, 
	  1,   0,   1,   1,   1,   1,   1,   0, 
	  0,   1,   1,   0,   0,   1,   0,   0, 
	  1,   1,   1,   1,   0,   0,   1,   0, 
	  0,   1,   0,   1,   0,   0,   1,   1, 
	  0,   1,   1,   1,   0,   0,   0,   1, 
	  0,   0,   0,   1,   0,   0,   1,   0, 
	  1,   1,   0,   0, };

short nstates2=41;	/* llc */
#define endstate2	40
short src_ln2 [] = {
	  0,  12,  14,  14,  15,  16,  17,  13, 
	 19,  11,  21,  23,  23,  24,  25,  26, 
	 22,  28,  20,  30,  32,  32,  33,  34, 
	 35,  31,  37,  29,  39,  41,  41,  42, 
	 43,  44,  40,  46,  38,  10,  48,  10, 
	 48,   0, };
uchar reached2 [] = {
	  0,   1,   1,   0,   1,   1,   1,   0, 
	  1,   1,   1,   1,   0,   1,   1,   1, 
	  0,   1,   1,   1,   1,   0,   1,   1, 
	  1,   0,   1,   1,   1,   1,   0,   1, 
	  1,   1,   0,   1,   1,   0,   1,   1, 
	  0,   0, };

short nstates1=7;	/* macuser1 */
#define endstate1	6
short src_ln1 [] = {
	  0,   9,  10,  11,   8,  13,  13,   0, };
uchar reached1 [] = {
	  0,   1,   1,   1,   0,   1,   0,   0, };

short nstates0=8;	/* macuser */
#define endstate0	7
short src_ln0 [] = {
	  0,  10,  11,  12,   9,  14,   9,  14, 
	  0, };
uchar reached0 [] = {
	  0,   1,   1,   1,   0,   1,   1,   0, 
	  0, };
#define _T5	176
#define _T2	177
#define SYNC	4
#define ASYNC	3

typedef struct P6 { /* :init: */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 8; /* state    */
} P6;
#define Air6	(sizeof(P6) - 3)
typedef struct P5 { /* leaveallpro */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 8; /* state    */
	unsigned leavealltimer : 1;
	uchar n;
	uchar type;
	uchar state;
} P5;
#define Air5	(sizeof(P5) - Offsetof(P5, state) - 1*sizeof(uchar))
typedef struct P4 { /* registrar */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 8; /* state    */
	unsigned leavetimer : 1;
	unsigned member_exist : 1;
	uchar n;
	uchar type;
	uchar state;
} P4;
#define Air4	(sizeof(P4) - Offsetof(P4, state) - 1*sizeof(uchar))
typedef struct P3 { /* applicant */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 8; /* state    */
	unsigned jointimer : 1;
	uchar n;
	uchar type;
	uchar state;
} P3;
#define Air3	(sizeof(P3) - Offsetof(P3, state) - 1*sizeof(uchar))
typedef struct P2 { /* llc */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 8; /* state    */
	uchar type;
} P2;
#define Air2	(sizeof(P2) - Offsetof(P2, type) - 1*sizeof(uchar))
typedef struct P1 { /* macuser1 */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 8; /* state    */
	uchar n;
} P1;
#define Air1	(sizeof(P1) - Offsetof(P1, n) - 1*sizeof(uchar))
typedef struct P0 { /* macuser */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 8; /* state    */
	uchar n;
} P0;
#define Air0	(sizeof(P0) - Offsetof(P0, n) - 1*sizeof(uchar))
typedef struct P7 { /* np_ */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 8; /* state    */
} P7;
#define Air7	(sizeof(P7) - 3)
#ifdef VERI
#define BASE	1
#else
#define BASE	0
#endif
#ifdef VERBOSE
#define CHECK
#define DEBUG
#endif
#ifdef SAFETY
#ifndef NOFAIR
#define NOFAIR
#endif
#endif
#ifdef NOREDUCE
#define XUSAFE
#ifndef SAFETY
#define FULLSTACK
#endif
#else
#define PARTIAL
#ifdef BITSTATE
#ifdef SAFETY
#define CNTRSTACK
#else
#define FULLSTACK
#endif
#else
#define FULLSTACK
#endif
#endif
#ifdef BITSTATE
#define NOCOMP
#endif
#ifndef MEMCNT
#ifdef PC
#define MEMCNT	25	/* 32 Mb */
#else
#define MEMCNT	28
#endif
#endif
#ifdef COLLAPSE2
#define COLLAPSE
#endif
#ifdef COLLAPSE3
#define COLLAPSE2
#define COLLAPSE
#endif
#ifdef COLLAPSE4
#define COLLAPSE3
#define COLLAPSE2
#define COLLAPSE
#endif
#define qptr(x)	(((uchar *)&now)+q_offset[x])
#define pptr(x)	(((uchar *)&now)+proc_offset[x])
#define Pptr(x)	((proc_offset[x])?pptr(x):noptr)
#define q_sz(x)	(((Q0 *)qptr(x))->Qlen)

#define MAXQ   	255
#define MAXPROC	255
#define WS		sizeof(long)   /* word size in bytes */
#ifndef VECTORSZ
#define VECTORSZ	1024           /* sv   size in bytes */
#endif

typedef struct Stack  {	 /* for queues and processes */
#if VECTORSZ>32000
	int o_delta;
	int o_offset;
	int o_skip;
	int o_delqs;
#else
	short o_delta;
	short o_offset;
	short o_skip;
	short o_delqs;
#endif
#ifndef XUSAFE
	char *o_name;
#endif
	char *body;
	struct Stack *nxt;
	struct Stack *lst;
} Stack;

typedef struct Svtack { /* for complete state vector */
#if VECTORSZ>32000
	int o_delta;
	int m_delta;
#else
	short o_delta;	 /* current size of frame */
	short m_delta;	 /* maximum size of frame */
#endif
#if SYNC
	short o_boq;
#endif
	char *body;
	struct Svtack *nxt;
	struct Svtack *lst;
} Svtack;

typedef struct Trans {
	short atom;	/* if &2 = atomic trans; if &8 local */
	short st;	/* the nextstate */
#ifdef HAS_UNLESS
	short escp[HAS_UNLESS];	/* lists the escape states */
	short e_trans;	/* if set, this is an escp-trans */
#endif
	short tpe[2];	/* class of operation (for reduction) */
	uchar qu[6];	/* for conditional selections: qid's  */
	uchar ty[6];	/* for conditional selections: type's */
#ifdef NIBIS
	short om;	/* completion status of preselects */
#endif
	char *tp;	/* src txt of statement */
	int t_id;	/* transition id, unique within proc */
	int forw;	/* index for forward transition */
	int back;	/* index for return  transition */
	struct Trans *nxt;
} Trans;

Trans ***trans;	/* 1 ptr per state per proctype */

#if defined(FULLSTACK)
struct H_el *Lstate;
#endif
int depthfound = -1;	/* loop detection */
int proc_offset[MAXPROC], proc_skip[MAXPROC];
int q_offset[MAXQ], q_skip[MAXQ];
long vsize;		/* vector size in bytes */
short boq = -1;	/* blocked_on_queue status */
typedef struct State {
	uchar _nr_pr;
	uchar _nr_qs;
	uchar   _a_t;	/* cycle detection */
#ifndef NOFAIR
	uchar   _cnt[NFAIR];	/* counters, weak fairness */
#endif
#ifndef NOVSZ
	unsigned long _vsz;	/* vsize - also forces alignment */
#else
#ifdef COLLAPSE
	uchar	_pad_[WS-1];	/* align start of globals */ 
#endif
#endif
#ifdef HAS_LAST
	uchar  _last;	/* pid executed in last step */
#endif
	uchar user_to_appl[2];
	uchar appl_to_llc[2];
	uchar llc_to_appl[2];
	uchar regist_to_llc;
	uchar llc_to_regist;
	uchar leaveall_to_llc;
	uchar llc_to_leaveall;
	uchar sv[VECTORSZ];
} State;

int _; /* a predefined write-only variable */

#define _NP_	7
uchar reached7[3];  /* np_ */
short nstates7 = 3; /* np_ */
#define endstate7	2 /* np_ */

#define start7	0 /* np_ */
#define start6	8
#define start5	1
#define start4	1
#define start3	1
#define start2	37
#define start1	4
#define start0	4
#ifdef NP
#define ACCEPT_LAB	1 /* at least 1 in np_ */
#else
#define ACCEPT_LAB	0 /* user-defined accept labels */
#endif
#define PROG_LAB	2 /* progress labels */
uchar *accpstate[8];
uchar *progstate[8];
uchar *reached[8];
uchar *stopstate[8];
short q_flds[11];
typedef struct Q10 {
	uchar Qlen;	/* q_size */
	uchar _t;	/* q_type */
	struct {
		uchar fld0;
	} contents[1];
} Q10;
typedef struct Q9 {
	uchar Qlen;	/* q_size */
	uchar _t;	/* q_type */
	struct {
		uchar fld0;
	} contents[1];
} Q9;
typedef struct Q8 {
	uchar Qlen;	/* q_size */
	uchar _t;	/* q_type */
	struct {
		uchar fld0;
	} contents[1];
} Q8;
typedef struct Q7 {
	uchar Qlen;	/* q_size */
	uchar _t;	/* q_type */
	struct {
		uchar fld0;
	} contents[1];
} Q7;
typedef struct Q6 {
	uchar Qlen;	/* q_size */
	uchar _t;	/* q_type */
	struct {
		uchar fld0;
	} contents[1];
} Q6;
typedef struct Q5 {
	uchar Qlen;	/* q_size */
	uchar _t;	/* q_type */
	struct {
		uchar fld0;
	} contents[1];
} Q5;
typedef struct Q4 {
	uchar Qlen;	/* q_size */
	uchar _t;	/* q_type */
	struct {
		uchar fld0;
	} contents[1];
} Q4;
typedef struct Q3 {
	uchar Qlen;	/* q_size */
	uchar _t;	/* q_type */
	struct {
		uchar fld0;
	} contents[1];
} Q3;
typedef struct Q2 {
	uchar Qlen;	/* q_size */
	uchar _t;	/* q_type */
	struct {
		uchar fld0;
	} contents[1];
} Q2;
typedef struct Q1 {
	uchar Qlen;	/* q_size */
	uchar _t;	/* q_type */
	struct {
		uchar fld0;
	} contents[1];
} Q1;
typedef struct Q0 {	/* generic q */
	uchar Qlen, _t;
} Q0;

/** function prototypes **/
char *emalloc(unsigned);
char *Malloc(unsigned);
int Boundcheck(int, int, int, int, Trans *);
/* int abort(void); */
int addqueue(int, int);
/* int atoi(char *); */
int close(int);
int creat(char *, unsigned short);
int delproc(int, int);
int endstate(void);
int hstore(char *, int, short);
int q_cond(Trans *);
int q_full(int);
int q_len(int);
int q_zero(int);
int qrecv(int, int, int, int);
int unsend(int);
int write(int, void *, unsigned);
void *sbrk(int);
void Uerror(char *);
void assert(int, char *, int, int, Trans *);
void checkcycles(void);
void crack(int, int, Trans *, short *);
void d_hash(uchar *, int);
void delq(int);
void do_reach(void);
void exit(int);
void hinit(void);
void imed(Trans *, int, int);
void new_state(void);
void p_restor(int);
void putpeg(int, int);
void putrail(void);
void q_restor(void);
void retrans(int, int, int, short *, uchar *);
void settable(void);
void setq_claim(int, int, char *, int, char *);
void sv_restor(int);
void sv_save(char *);
void tagtable(int, int, int, short *, uchar *);
void uerror(char *);
void unrecv(int, int, int, int, int);
void usage(FILE *);
void wrap_stats(void);
void xrefsrc(int, int, int);
#if defined(FULLSTACK) && defined(BITSTATE)
int  onstack_now(void);
void onstack_init(void);
void onstack_put(void);
void onstack_zap(void);
#endif
#ifndef XUSAFE
int q_S_check(int, int);
int q_R_check(int, int);
uchar q_claim[MAXQ+1];
char *q_name[MAXQ+1];
char *p_name[MAXPROC+1];
#endif
void qsend(int, int, int);
#define Addproc(x)	addproc(x, 0)
#define LOCAL	1
#define Q_FULL_F	2
#define Q_EMPT_F	3
#define Q_EMPT_T	4
#define Q_FULL_T	5
#define TIMEOUT_F	6
#define GLOBAL	7
#define BAD	8
#define NTRANS	178
#ifdef PEG
	long peg[NTRANS];
#endif
