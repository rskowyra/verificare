module Language.Promela.AbstractSyntax
  where

type Variable = String
type Constant = String
type Datatype = String

data Top =
    Top [GlobalDecl] [Proctype] Init
  deriving (Eq, Show)

data GlobalDecl =
    Typedef Variable [Decl]
  | GlobalDecl Decl
  deriving (Eq, Show)
  
data Init =
    Init
  deriving (Eq, Show)
  
data Proctype =
    Proctype String [Arg] [Decl] [Stmt]
  deriving (Eq, Show)

data Decl =
    Decl Ty Variable (Maybe Term)
  deriving (Eq, Show)

data Ty =
    TyInt
  | TyDef Variable
  | TyArray Integer Ty
  | TyChannel Integer Ty
  deriving (Eq, Show)
  
data Arg = 
    Arg Datatype Variable
  deriving (Eq, Show)

data LHS =
    LHS Variable [Term]
  deriving (Eq, Show)
  
data Stmt =
    Goto String
  | Skip
  | Assign LHS Term
  | If [GuardedBlock]
  | Do [GuardedBlock]
  | COStmt ChannelOp
  | Atomic [Stmt]
  deriving (Eq, Show)

data ChannelOp = 
    Send Variable [Term]
  | Recv Variable [Variable]
  deriving (Eq, Show)
  
data GuardedBlock = 
    GuardedBlock Formula [Stmt]
  deriving (Eq, Show)
  
data Formula =
    B Bool
  | And Formula Formula
  | Or Formula Formula
  | Not Formula
  | Eq Term Term
  | Neq Term Term
  | Lt Term Term
  | Leq Term Term
  | Gt Term Term
  | Geq Term Term
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
  | COTerm ChannelOp
  deriving (Eq, Show)

--eof
