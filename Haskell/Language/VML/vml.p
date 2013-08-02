
Root ::=
  Root | `[Host/1]

Host ::=
  Host | `id : `>[Stmt/1]<

Ty ::=
    TyInt | int
    TySet | set < `Ty >
  TyArray | array < `Ty >

Stmt ::=
    Decl | `Ty `id = `Term
    Skip | skip
  Action | `id . `id ( `[Constant/0/,] )
  Assign | `id := `Term
    Loop | loop : `>[Stmt/1]<
      If | if `Formula : `>[Stmt/1]<

Formula ::=
    Not | not `Formula
        ^
    And | `Formula and `Formula
     Or | `Formula or `Formula
        ^
      T | true
      F | false
     Eq | `Term in `Term
    Neq | `Term in `Term
     Lt | `Term in `Term
    Leq | `Term in `Term
     Gt | `Term in `Term
    Geq | `Term in `Term
     In | `Term in `Term

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
  Array | [ `[Term/0/,] ]
    Set | { `[Term/0/,] }
      V | `id `[Spec/0]
      N | `#

Spec ::=
  Index | [ `Term ]
  Field | . `id

Constant ::=
      C | `id