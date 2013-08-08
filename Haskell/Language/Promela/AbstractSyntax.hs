-- This module generated automatically by imparse.

module Language.Promela.AbstractSyntax
  where

data Root = 
    Root [GlobalDecl] [ProcType] Init
  deriving (Show, Eq)

data GlobalDecl = 
    Typedef  String  [Decl]
  | GlobalDecl Decl
  deriving (Show, Eq)

data Init = 
    Init 
  deriving (Show, Eq)

data ProcType = 
    Proctype  String [Arg]  [Decl]  [Stmt] 
  deriving (Show, Eq)

data Arg = 
    Arg Ty String
  deriving (Show, Eq)

data Decl = 
    Decl Ty String (Maybe RHS)
  deriving (Show, Eq)

data RHS = 
    RHS  Term
  deriving (Show, Eq)

data Ty = 
    TyInt 
  | TyDef String
  | TyArray     Ty 
  | TyChannel     Ty 
  deriving (Show, Eq)

data Stmt = 
    Goto  String
  | Skip 
  | Assign LHS  Term
  | If  GuardedBlock
  | Do  GuardedBlock
  | COpS ChannelOp
  | Atomic  [Stmt]
  deriving (Show, Eq)

data LHS = 
    LHS String [Spec]
  deriving (Show, Eq)

data GuardedBlock = 
    GuardedBlock  Formula    [Stmt] 
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
  | COpT ChannelOp
  deriving (Show, Eq)

data ChannelOp = 
    Send  String  [Term] 
  | Recv  String  [Variable] 
  deriving (Show, Eq)

data Variable = 
    Variable String
  deriving (Show, Eq)

data Spec = 
    Index  Term 
  | Field  String
  deriving (Show, Eq)

data Constant = 
    C String
  deriving (Show, Eq)


--eof