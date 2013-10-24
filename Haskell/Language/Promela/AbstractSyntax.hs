-- This module was generated automatically by imparse.

module Language.Promela.AbstractSyntax
  where

data Root = 
    Root [GlobalDecl] [ProcType] Init
  deriving (Show, Eq)

data GlobalDecl = 
    Typedef  String  [Decl] 
  | MType    [MTypeConst]  
  deriving (Show, Eq)

data MTypeConst = 
    MTypeConst String
  deriving (Show, Eq)

data Init = 
    Init 
  deriving (Show, Eq)

data ProcType = 
    ProcType  String [Arg]  [Decl] [Stmt] 
  deriving (Show, Eq)

data Arg = 
    Arg Ty String
  deriving (Show, Eq)

data Decl = 
    Decl Ty String (Maybe Size) (Maybe RHS) 
  deriving (Show, Eq)

data Size = 
    Size  Term 
  deriving (Show, Eq)

data RHS = 
    RHS  Term
  deriving (Show, Eq)

data Ty = 
    TyInt 
  | TyByte 
  | TyDef String
  | TyChannel   
  deriving (Show, Eq)

data Stmt = 
    Skip  
  | Assign LHS  Term 
  | If  [GuardedBlock]  
  | Do  [GuardedBlock]  
  | Atomic   [Stmt] 
  | Goto  String 
  | Label String 
  | COpS ChannelOp
  deriving (Show, Eq)

data LHS = 
    LHS String [Spec]
  deriving (Show, Eq)

data GuardedBlock = 
    GuardedBlock   Formula   [Stmt]
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