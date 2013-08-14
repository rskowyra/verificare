
Root ::=
  Root | `>([GlobalDecl])< `>([ProcType])< `Init

GlobalDecl ::=
     Typedef | typedef `var { `>[Decl]< }
  GlobalDecl | `Decl

Init ::=
  Init | init

ProcType ::=
  ProcType | proctype `var `([Arg/,]) { `>[Decl]< `>[Stmt]< }

Arg ::=
    Arg | `Ty `var

Decl ::=
  Decl | `Ty `var `(Size) `(RHS) ;

Size ::=
  Size | [ `Term ]

RHS ::=
  RHS | = `Term

Ty ::=
      TyInt | int
     TyByte | byte
      TyDef | `var
  TyChannel | channel <`Ty >

Stmt ::=
    Skip | skip ;
  Assign | `LHS = `Term ;
      If | if `>[GuardedBlock]< fi ;
      Do | do `>[GuardedBlock]< od ;
  Atomic | atomic { `>[Stmt]< }
    Goto | goto `var ;
   Label | `var : 
    COpS | `ChannelOp

LHS ::=
  LHS | `var `([Spec])

GuardedBlock ::=
  GuardedBlock | :: ( `Formula ) -> `>[Stmt]<

Formula ::=
    Not | ! `Formula
        ^
    And | `Formula && `Formula
     Or | `Formula || `Formula
        ^
     Eq | `Term == `Term
    Neq | `Term != `Term
     Lt | `Term <  `Term
    Leq | `Term <= `Term
     Gt | `Term >  `Term
    Geq | `Term >= `Term
     In | `Term in `Term
      T | true
      F | false

Term ::=
   Mult | `Term * `Term
    Div | `Term / `Term
    Pow | `Term ^ `Term
        ^
   Plus | `Term + `Term
  Minus | `Term - `Term
        ^
    Neg | - `Term
        ^
  Array | [ `[Term/,] ]
    Set | { `[Term/,] }
      V | `var `([Spec])
      N | `#
   COpT | `ChannelOp

ChannelOp ::=
  Send | send `var ( `([Term/,]) )
  Recv | receive `var ( `([Variable/,]) )

Variable ::=
  Variable | `var

Spec ::=
  Index | [ `Term ]
  Field | . `var

Constant ::=
      C | `var
