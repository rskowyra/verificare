-- This module was generated automatically by imparse.

module Language.DA.Report
  where

import qualified Text.RichReports as R

import Language.DA.AbstractSyntax

instance R.ToReport Root where
  report x = case x of
    Root v0 -> R.Span [] [] $ [R.report v0]
    
instance R.ToReport DA where
  report x = case x of
    DA v1 v3 v4 v5 -> R.Span [] [] $ [R.key "da", R.var v1, R.key ":", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v3], R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v4], R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v5]]
    
instance R.ToReport Decl where
  report x = case x of
    Decl v0 v1 v2 -> R.Span [] [] $ [R.report v0, R.var v1, R.report v2]
    
instance R.ToReport ActionDef where
  report x = case x of
    ActionDef v1 v3 v4 -> R.Span [] [] $ [R.key "action", R.var v1, R.key ":", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v3], R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v4]]
    
instance R.ToReport Preconditions where
  report x = case x of
    Preconditions v2 -> R.Span [] [] $ [R.key "pre", R.key ":", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v2]]
    
instance R.ToReport Postconditions where
  report x = case x of
    Postconditions v2 -> R.Span [] [] $ [R.key "post", R.key ":", R.BlockIndent [] [] $ [R.Line [] [R.report vx] | vx <- v2]]
    
instance R.ToReport Postcondition where
  report x = case x of
    Constraint v0 -> R.Span [] [] $ [R.report v0]
    Assign v0 v2 -> R.Span [] [] $ [R.var v0, R.key ":=", R.report v2]
    Invocation v0 v2 v4 -> R.Span [] [] $ [R.var v0, R.key ".", R.var v2, R.key "(", R.report v4, R.key ")"]
    
instance R.ToReport Exp where
  report x = case x of
    Var v0 -> R.Span [] [] $ [R.var v0]
    Const v0 -> R.Span [] [] $ [R.Text v0]
    
instance R.ToReport Ty where
  report x = case x of
    TyInt  -> R.Span [] [] $ [R.key "int"]
    TySet v2 -> R.Span [] [] $ [R.key "set", R.key "<", R.report v2, R.key ">"]
    TyArray v2 v4 -> R.Span [] [] $ [R.key "array", R.key "<", R.report v2, R.key ">", R.report v4]
    
instance R.ToReport Dims where
  report x = case x of
    Dims v1 -> R.Span [] [] $ [R.key "^", R.lit (show v1)]
    
instance R.ToReport RHS where
  report x = case x of
    RHS v1 -> R.Span [] [] $ [R.key "=", R.report v1]
    
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
    

--eof