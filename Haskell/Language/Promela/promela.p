
Root ::=
  Root | `([GlobalDecl]) `([ProcType]) `Init

GlobalDecl ::=
     Typedef | typedef `var = `[Decl]
  GlobalDecl | `Decl

Init ::=
  Init | init

Proctype ::=
  Proctype | proctype `var `([Arg/,]) { `[Decl/;] ; `[Stmt/;] }

Arg ::= 
    Arg | `Ty `var

Decl ::=
  Decl | `Ty `var `(RHS)

RHS ::=
  RHS | = `Term

Ty ::=
      TyInt | int
      TyDef | `var
    TyArray | array < # , `Ty >
  TyChannel | channel < # , `Ty >
  
Stmt ::=
    Goto | goto `var
    Skip | skip
  Assign | `LHS = `Term
      If | if `GuardedBlock
      Do | do `GuardedBlock
    COpT | `ChannelOp
  Atomic | atomic `[Stmt]

LHS ::=
  LHS | `var `([Spec])

GuardedBlock ::=
  GuardedBlock | ( `Formula ) : { `[Stmt/;] }

Formula ::=
    Not | not `Formula
        ^
    And | `Formula and `Formula
     Or | `Formula or `Formula
        ^
     Eq | `Term in `Term
    Neq | `Term in `Term
     Lt | `Term in `Term
    Leq | `Term in `Term
     Gt | `Term in `Term
    Geq | `Term in `Term
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
