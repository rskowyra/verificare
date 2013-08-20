-- This module was generated automatically by imparse.

module Language.DA.AbstractSyntax
  where

data Root = 
    Root [Host]
  deriving (Show, Eq)

data Host = 
    Host  String  [Decl] [Stmt]
  deriving (Show, Eq)

data Ty = 
    TyInt 
  | TySet   Ty 
  | TyArray   Ty  (Maybe Dims)
  deriving (Show, Eq)

data Dims = 
    Dims  Integer
  deriving (Show, Eq)

data Decl = 
    Decl Ty String (Maybe RHS)
  deriving (Show, Eq)

data RHS = 
    RHS  Term
  deriving (Show, Eq)

data Stmt = 
    Skip 
  | Action String  String  [Constant] 
  | Assign String  Term
  | Select   [GuardedBlock]
  | Loop   [Stmt]
  | If  Formula  [Stmt]
  deriving (Show, Eq)

data GuardedBlock = 
    GuardedBlock Formula  [Stmt]
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

data Constant = 
    C String
  deriving (Show, Eq)


--eof