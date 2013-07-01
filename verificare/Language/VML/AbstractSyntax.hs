
module Language.VML.AbstractSyntax
  where

type Variable = String
type Constant = String
type ActionLbl = String

data Top =
    Top [Host]
  deriving (Eq, Show)
  
data Host =
    Host String [Stmt]
  deriving (Eq, Show)

data Stmt =
    Skip
  | Assign Variable Term
  | Invoke Action
  | If Formula [Stmt]
  | Loop [Stmt]
  deriving (Eq, Show)

data Action =
    Action Variable ActionLbl [Constant]
  deriving (Eq, Show)
  
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
  deriving (Eq, Show)

data Term =
    V Variable
  | N Integer
  | Neg Term
  | Plus Term Term
  | Minus Term Term
  | Mult Term Term
  | Div Term Term
  | Pow Term Term
  deriving (Eq, Show)

--eof
