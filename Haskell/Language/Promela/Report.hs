-- This module generated automatically by imparse.

module Language.Promela.Report
  where

import qualified Text.RichReports as R

import Language.Promela.AbstractSyntax

instance R.ToReport Root where
  report x = case x of
    Root v0 v1 v2 -> R.Span [] [] $ [R.report v0, R.report v1, R.report v2]
    
instance R.ToReport GlobalDecl where
  report x = case x of
    Typedef v1 v3 -> R.Span [] [] $ [R.key "typedef", R.var v1, R.key "=", R.report v3]
    GlobalDecl v0 -> R.Span [] [] $ [R.report v0]
    
instance R.ToReport Init where
  report x = case x of
    Init  -> R.Span [] [] $ [R.key "init"]
    
instance R.ToReport ProcType where
  report x = case x of
    Proctype v1 v2 v4 v6 -> R.Span [] [] $ [R.key "proctype", R.var v1, R.report v2, R.key "{", R.report v4, R.key ";", R.report v6, R.key "}"]
    
instance R.ToReport Arg where
  report x = case x of
    Arg v0 v1 -> R.Span [] [] $ [R.report v0, R.var v1]
    
instance R.ToReport Decl where
  report x = case x of
    Decl v0 v1 v2 -> R.Span [] [] $ [R.report v0, R.var v1, R.report v2]
    
instance R.ToReport RHS where
  report x = case x of
    RHS v1 -> R.Span [] [] $ [R.key "=", R.report v1]
    
instance R.ToReport Ty where
  report x = case x of
    TyInt  -> R.Span [] [] $ [R.key "int"]
    TyDef v0 -> R.Span [] [] $ [R.var v0]
    TyArray v4 -> R.Span [] [] $ [R.key "array", R.key "<", R.key "#", R.key ",", R.report v4, R.key ">"]
    TyChannel v4 -> R.Span [] [] $ [R.key "channel", R.key "<", R.key "#", R.key ",", R.report v4, R.key ">"]
    
instance R.ToReport Stmt where
  report x = case x of
    Goto v1 -> R.Span [] [] $ [R.key "goto", R.var v1]
    Skip  -> R.Span [] [] $ [R.key "skip"]
    Assign v0 v2 -> R.Span [] [] $ [R.report v0, R.key "=", R.report v2]
    If v1 -> R.Span [] [] $ [R.key "if", R.report v1]
    Do v1 -> R.Span [] [] $ [R.key "do", R.report v1]
    COpS v0 -> R.Span [] [] $ [R.report v0]
    Atomic v1 -> R.Span [] [] $ [R.key "atomic", R.report v1]
    
instance R.ToReport LHS where
  report x = case x of
    LHS v0 v1 -> R.Span [] [] $ [R.var v0, R.report v1]
    
instance R.ToReport GuardedBlock where
  report x = case x of
    GuardedBlock v1 v5 -> R.Span [] [] $ [R.key "(", R.report v1, R.key ")", R.key ":", R.key "{", R.report v5, R.key "}"]
    
instance R.ToReport Formula where
  report x = case x of
    Not v1 -> R.Span [] [] $ [R.key "not", R.report v1]
    And v0 v2 -> R.Span [] [] $ [R.report v0, R.key "and", R.report v2]
    Or v0 v2 -> R.Span [] [] $ [R.report v0, R.key "or", R.report v2]
    Eq v0 v2 -> R.Span [] [] $ [R.report v0, R.key "==", R.report v2]
    Neq v0 v2 -> R.Span [] [] $ [R.report v0, R.key "!=", R.report v2]
    Lt v0 v2 -> R.Span [] [] $ [R.report v0, R.key "<", R.report v2]
    Leq v0 v2 -> R.Span [] [] $ [R.report v0, R.key "<=", R.report v2]
    Gt v0 v2 -> R.Span [] [] $ [R.report v0, R.key ">", R.report v2]
    Geq v0 v2 -> R.Span [] [] $ [R.report v0, R.key ">=", R.report v2]
    In v0 v2 -> R.Span [] [] $ [R.report v0, R.key "in", R.report v2]
    T  -> R.Span [] [] $ [R.key "true"]
    F  -> R.Span [] [] $ [R.key "false"]
    
instance R.ToReport Term where
  report x = case x of
    Mult v0 v2 -> R.Span [] [] $ [R.report v0, R.key "*", R.report v2]
    Div v0 v2 -> R.Span [] [] $ [R.report v0, R.key "/", R.report v2]
    Pow v0 v2 -> R.Span [] [] $ [R.report v0, R.key "^", R.report v2]
    Plus v0 v2 -> R.Span [] [] $ [R.report v0, R.key "+", R.report v2]
    Minus v0 v2 -> R.Span [] [] $ [R.report v0, R.key "-", R.report v2]
    Neg v1 -> R.Span [] [] $ [R.key "-", R.report v1]
    Array v1 -> R.Span [] [] $ [R.key "[", R.report v1, R.key "]"]
    Set v1 -> R.Span [] [] $ [R.key "{", R.report v1, R.key "}"]
    V v0 v1 -> R.Span [] [] $ [R.var v0, R.report v1]
    N v0 -> R.Span [] [] $ [R.lit (show v0)]
    COpT v0 -> R.Span [] [] $ [R.report v0]
    
instance R.ToReport ChannelOp where
  report x = case x of
    Send v1 v3 -> R.Span [] [] $ [R.key "send", R.var v1, R.key "(", R.report v3, R.key ")"]
    Recv v1 v3 -> R.Span [] [] $ [R.key "receive", R.var v1, R.key "(", R.report v3, R.key ")"]
    
instance R.ToReport Variable where
  report x = case x of
    Variable v0 -> R.Span [] [] $ [R.var v0]
    
instance R.ToReport Spec where
  report x = case x of
    Index v1 -> R.Span [] [] $ [R.key "[", R.report v1, R.key "]"]
    Field v1 -> R.Span [] [] $ [R.key ".", R.var v1]
    
instance R.ToReport Constant where
  report x = case x of
    C v0 -> R.Span [] [] $ [R.var v0]
    

--eof