
Root ::=
  Root | `[Host]

Host ::=
  Host | host `var : `>>([Decl])<< `>>[Stmt]<<

Ty ::=
    TyInt | int
    TySet | set < `Ty >
  TyArray | array < `Ty >

Decl ::=
    Decl | `Ty `var `(RHS)

RHS ::=
    RHS | = `Term

Stmt ::=
    Skip | skip
  Action | `var . `var ( `([Constant/,]) )
  Assign | `var := `Term
    Loop | loop : `>>[Stmt]<<
      If | if `Formula : `>>[Stmt]<<

Formula ::=
    Not | not `Formula
        ^
    And | `Formula and `Formula
     Or | `Formula or `Formula
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
  Array | [ `([Term/,]) ]
    Set | { `([Term/,]) }
      V | `var `([Spec])
      N | `#

Spec ::=
  Index | [ `Term ]
  Field | . `var

Constant ::=
      C | `flag
