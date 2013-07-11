
Top ::=
  Top | `[Host/1]
  
Host ::=
  Host | `Variable `[Stmt/1]

Stmt ::=
     Skip | `_ skip
   Assign | `_ `Variable := `Term
   Invoke | `_ `Action
       If | `_ if `Formula : `>[Stmt/1]<
     Loop | `_ loop : `>[Stmt/1]<

Action ::=
  Action | `Variable `Variable ( `[Constant/0/,] )

Formula ::=
  And | `Formula && `Formula
   Or | `Formula || `Formula
  Not | ! `Formula
   Eq | `Formula == `Formula
  Neq | `Formula !=  `Formula
   Lt | `Formula <  `Formula
  Leq | `Formula <= `Formula
   Gt | `Formula >  `Formula
  Geq | `Formula >= `Formula
   In | `Formula in `Formula
     
Term ::=
      V | Variable
      N | `{[0-9]+}
    Neg | - `Term
   Plus | `Term + `Term
  Minus | `Term - `Term
   Mult | `Term * `Term
    Div | `Term / `Term
    Pow | `Term ^ `Term

Variable ::=
        | `{[A-Za-z][A-Za-z0-9_]+}
        
Constant ::=
        | `{[A-Z][A-Z0-9]+}