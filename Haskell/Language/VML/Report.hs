-- This module generated automatically by imparse.

module Language.VML.Report
  where

import qualified Text.RichReports as R

import Language.VML.AbstractSyntax

instance R.ToReport Root where
  report x = case x of
    Root v0 -> R.Span [] [] $ [R.report v0]
    
instance R.ToReport Host where
  report x = case x of
    Host v1 v3 -> R.Span [] [] $ [R.key "host", R.var v1, R.key ":", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v3]]
    
instance R.ToReport Ty where
  report x = case x of
    TyInt  -> R.Span [] [] $ [R.key "int"]
    TySet v2 -> R.Span [] [] $ [R.key "set", R.key "<", R.report v2, R.key ">"]
    TyArray v2 -> R.Span [] [] $ [R.key "array", R.key "<", R.report v2, R.key ">"]
    
instance R.ToReport Stmt where
  report x = case x of
    Decl v0 v1 v3 -> R.Span [] [] $ [R.report v0, R.var v1, R.key "=", R.report v3]
    Skip  -> R.Span [] [] $ [R.key "skip"]
    Action v0 v2 v4 -> R.Span [] [] $ [R.var v0, R.key ".", R.var v2, R.key "(", R.report v4, R.key ")"]
    Assign v0 v2 -> R.Span [] [] $ [R.var v0, R.key ":=", R.report v2]
    Loop v2 -> R.Span [] [] $ [R.key "loop", R.key ":", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v2]]
    If v1 v3 -> R.Span [] [] $ [R.key "if", R.report v1, R.key ":", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v3]]
    
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
    
instance R.ToReport Spec where
  report x = case x of
    Index v1 -> R.Span [] [] $ [R.key "[", R.report v1, R.key "]"]
    Field v1 -> R.Span [] [] $ [R.key ".", R.var v1]
    
instance R.ToReport Constant where
  report x = case x of
    C v0 -> R.Span [] [] $ [R.Text v0]
    

--eof