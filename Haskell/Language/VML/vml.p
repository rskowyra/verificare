
Root ::=
  Root | `[Host]

Host ::=
  Host | host `var : `>>([Decl])<< `>>[Stmt]<<

Ty ::=
  TyIntBounded | int [ `# , `# ]
         TyInt | int
         TySet | set < `Ty >
       TyArray | array < `Ty > `(Dims)

Dims ::=
   Dims | ^ `#

Decl ::=
    Decl | `Ty `var `(RHS)

RHS ::=
    RHS | = `Term

AssignRHS ::=
      StmtRHSTerm | `Term
    StmtRHSAction | `Action

Action ::=
    Action | `(Block) `var . `var ( `([Constant/,]) )

Block ::=
    Block | block

Stmt ::=
    Skip | skip
  Invoke | `Action
  Assign | `var := `AssignRHS
  Select | select : `>>[GuardedBlock]<<
    Loop | loop : `>>[Stmt]<<
     For | for `Term in `Term : `>>[Stmt]<<
      If | if `Formula : `>>[Stmt]<<

GuardedBlock ::=
  GuardedBlock | `Formula : `>>[Stmt]<<

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
   Comp | @ { `Term | `[Formula/,] }
      V | `var `([Spec])
      N | `#

Spec ::=
  Index | [ `Term ]
  Field | . `var

Constant ::=
      C | `flag
