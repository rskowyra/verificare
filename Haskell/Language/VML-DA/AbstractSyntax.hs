module Language.VML_DA.AbstractSyntax
  where

type Variable = String

data Top =
    Top [DA]
  deriving (Eq, Show)

data DA =
    DA Variable [Decl] [Stmt]
  deriving (Eq, Show)

data Decl =
    Decl Ty Variable (Maybe Term) 
  deriving (Eq, Show)
  
data Ty =
    TyInt
  | TySet Ty
  | TyArray Ty
  deriving (Eq, Show)
  
data Stmt =
    Assign
  | Define Action 
  | Invariant Formula
  deriving (Eq, Show)
 
data Action =
    Action Variable [Variable] [Formula] [Assign]
  deriving (Eq, Show)
  
data Assign = 
	Assign Variable Term

data Formula =
    And Formula Formula
  | Or Formula Formula
  | Not Formula
  | Implies Formula Formula
  | Eq Term Term
  | Neq Term Term
  | Lt Term Term
  | Leq Term Term
  | Gt Term Term
  | Geq Term Term
  | In Term Term
  deriving (Eq, Show)
  
data Term =
    N Integer
  | V Variable
  | Index Term Term
  | Neg Term
  | Plus Term Term
  | Minus Term Term
  | Mult Term Term
  | Div Term Term
  | Pow Term Term
  | Array [Term]
  | Set [Term]
  | Len Term
  deriving (Eq, Show)

--eof

--To add: pick syntax, len/cardinality, IF/THEN expression
