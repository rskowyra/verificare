-- This module was generated automatically by imparse.

module Language.Promela.Report
  where

import qualified Text.RichReports as R

import Language.Promela.AbstractSyntax

instance R.ToReport Root where
  report x = case x of
    Root v0 v1 v2 -> R.Span [] [] $ [R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v0], R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v1], R.report v2]
    
instance R.ToReport GlobalDecl where
  report x = case x of
    Typedef v1 v3 -> R.Span [] [] $ [R.key "typedef", R.var v1, R.key "{", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v3], R.key "}"]
    MType v3 -> R.Span [] [] $ [R.key "mtype", R.key "=", R.key "{", R.report v3, R.key "}", R.key ";"]
    
instance R.ToReport MTypeConst where
  report x = case x of
    MTypeConst v0 -> R.Span [] [] $ [R.var v0]
    
instance R.ToReport Init where
  report x = case x of
    Init  -> R.Span [] [] $ [R.key "init"]
    
instance R.ToReport ProcType where
  report x = case x of
    ProcType v1 v2 v4 v5 -> R.Span [] [] $ [R.key "proctype", R.var v1, R.report v2, R.key "{", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v4], R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v5], R.key "}"]
    
instance R.ToReport Arg where
  report x = case x of
    Arg v0 v1 -> R.Span [] [] $ [R.report v0, R.var v1]
    
instance R.ToReport Decl where
  report x = case x of
    Decl v0 v1 v2 v3 -> R.Span [] [] $ [R.report v0, R.var v1, R.report v2, R.report v3, R.key ";"]
    
instance R.ToReport Size where
  report x = case x of
    Size v1 -> R.Span [] [] $ [R.key "[", R.report v1, R.key "]"]
    
instance R.ToReport RHS where
  report x = case x of
    RHS v1 -> R.Span [] [] $ [R.key "=", R.report v1]
    
instance R.ToReport Ty where
  report x = case x of
    TyInt  -> R.Span [] [] $ [R.key "int"]
    TyByte  -> R.Span [] [] $ [R.key "byte"]
    TyDef v0 -> R.Span [] [] $ [R.var v0]
    TyChannel  -> R.Span [] [] $ [R.key "channel", R.key "<`Ty", R.key ">"]
    
instance R.ToReport Stmt where
  report x = case x of
    Skip  -> R.Span [] [] $ [R.key "skip", R.key ";"]
    Assign v0 v2 -> R.Span [] [] $ [R.report v0, R.key "=", R.report v2, R.key ";"]
    If v1 -> R.Span [] [] $ [R.key "if", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v1], R.key "fi", R.key ";"]
    Do v1 -> R.Span [] [] $ [R.key "do", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v1], R.key "od", R.key ";"]
    Atomic v2 -> R.Span [] [] $ [R.key "atomic", R.key "{", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v2], R.key "}"]
    Goto v1 -> R.Span [] [] $ [R.key "goto", R.var v1, R.key ";"]
    Label v0 -> R.Span [] [] $ [R.var v0, R.key ":"]
    COpS v0 -> R.Span [] [] $ [R.report v0]
    
instance R.ToReport LHS where
  report x = case x of
    LHS v0 v1 -> R.Span [] [] $ [R.var v0, R.report v1]
    
instance R.ToReport GuardedBlock where
  report x = case x of
    GuardedBlock v2 v5 -> R.Span [] [] $ [R.key "::", R.key "(", R.report v2, R.key ")", R.key "->", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v5]]
    
instance R.ToReport Formula where
  report x = case x of
    Not v1 -> R.Span [] [] $ [R.key "!", R.report v1]
    And v0 v2 -> R.Span [] [] $ [R.report v0, R.key "&&", R.report v2]
    Or v0 v2 -> R.Span [] [] $ [R.report v0, R.key "||", R.report v2]
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