-- This module was generated automatically by imparse.

module Language.DA.AbstractSyntax
  where

data Root = 
    Root [DA]
  deriving (Show, Eq)

data DA = 
    DA  String  [Decl] [ActionDef] [Formula]
  deriving (Show, Eq)

data Decl = 
    Decl Ty String (Maybe RHS)
  deriving (Show, Eq)

data ActionDef = 
    ActionDef  String  [Preconditions] [Postconditions]
  deriving (Show, Eq)

data Preconditions = 
    Preconditions   [Formula]
  deriving (Show, Eq)

data Postconditions = 
    Postconditions   [Postcondition]
  deriving (Show, Eq)

data Postcondition = 
    Constraint Formula
  | Assign String  Term
  | Invocation String  String  [Exp] 
  deriving (Show, Eq)

data Exp = 
    Var String
  | Const String
  deriving (Show, Eq)

data Ty = 
    TyInt 
  | TySet   Ty 
  | TyArray   Ty  (Maybe Dims)
  deriving (Show, Eq)

data Dims = 
    Dims  Integer
  deriving (Show, Eq)

data RHS = 
    RHS  Term
  deriving (Show, Eq)

data Formula = 
    Not  Formula
  | And Formula  Formula
  | Or Formula  Formula
  | Eq Term  Term
  | Neq Term  Term
  | Lt Term  Term
  | Leq Term  Term
  | Gt Term  Term
  | Geq Term  Term
  | In Term  Term
  | T 
  | F 
  deriving (Show, Eq)

data Term = 
    Mult Term  Term
  | Div Term  Term
  | Pow Term  Term
  | Plus Term  Term
  | Minus Term  Term
  | Neg  Term
  | Array  [Term] 
  | Set  [Term] 
  | V String [Spec]
  | N Integer
  deriving (Show, Eq)

data Spec = 
    Index  Term 
  | Field  String
  deriving (Show, Eq)


--eof