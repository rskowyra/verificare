
Root ::=
  Root | `[Host]

Host ::=
  Host | `var : `>>[Stmt]<<

Ty ::=
    TyInt | int
    TySet | set < `Ty >
  TyArray | array < `Ty >

Stmt ::=
    Decl | `Ty `var = `Term
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
  Array | [ `([Term/,]) ]
    Set | { `([Term/,]) }
      V | `var `([Spec])
      N | `#

Spec ::=
  Index | [ `Term ]
  Field | . `var

Constant ::=
      C | `flag