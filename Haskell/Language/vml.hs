module AbstractSyntax
  where

data Top = 
    Top [Host] 
  deriving (Show, Eq)

data Host = 
    Host Variable [Stmt] 
  deriving (Show, Eq)

data Stmt = 
    Skip 
  | Assign Variable Term 
  | Invoke Action 
  | If Formula [Stmt] 
  | Loop [Stmt] 
  deriving (Show, Eq)

data Action = 
    Action Variable Variable [Constant] 
  deriving (Show, Eq)

data Formula = 
    And Formula Formula 
  | Or Formula Formula 
  | Not Formula 
  | Eq Term Term 
  | Neq Term Term 
  | Lt Term Term 
  | Leq Term Term 
  | Gt Term Term 
  | Geq Term Term 
  | In Term Term 
  deriving (Show, Eq)

data Term = 
    V Variable 
  | N String
  | Plus Term Term 
  | Minus Term Term 
  | Mult Term Term 
  | Div Term Term 
  | Pow Term Term 
  | Neg Term 
  deriving (Show, Eq)

data Variable = 
    Variable String
  deriving (Show, Eq)

data Constant = 
    Constant String
  deriving (Show, Eq)


--eof