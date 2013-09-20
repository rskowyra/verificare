Root ::=
  Root | `[DA]

DA ::=
  DA | da `var : `>>[Decl]<< `>>[ActionDef]<< `>>([Formula])<<

Decl ::=
    Decl | `Ty `var `(RHS)

ActionDef ::=
   ActionDef | action `var : `>>[Preconditions]<< `>>[Postconditions]<<

Preconditions ::=
   Preconditions | pre : `>>[Formula]<<

Postconditions ::=
   Postconditions | post : `>>[Postcondition]<<

Postcondition ::=
     Constraint | `Formula
         Assign | `var := `Term
     Invocation | `var . `var ( `([Exp/,]) )

Exp ::=
      Var | `var
    Const | `flag

Ty ::=
    TyInt | int
    TySet | set < `Ty >
  TyArray | array < `Ty > `(Dims)

Dims ::=
   Dims | ^ `#

RHS ::=
    RHS | = `Term

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
