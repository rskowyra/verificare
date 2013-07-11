module Language.Promela.AbstractSyntax
  where

type Variable = String
type Constant = String
type Datatype = String

data Init =
    Init
  deriving (Eq, Show)

data Top =
    Top [Proctype] Init
  deriving (Eq, Show)
  
data Proctype =
    Proctype String [Arg] [Stmt]
  deriving (Eq, Show)

data Arg = 
    Arg Datatype Variable
    deriving(Eq, Show)

data Stmt =
    Goto String
  | Skip
  | Assign Variable Term
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
    And Formula Formula
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
    V Variable
  | N Integer
  | Neg Term
  | Plus Term Term
  | Minus Term Term
  | Mult Term Term
  | Div Term Term
  | Pow Term Term
  | COTerm ChannelOp
  deriving (Eq, Show)

--eof
