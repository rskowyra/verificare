module Language.VML.Report
  where

import qualified Text.RichReports as R

instance Report Top where
  report x = case x of
    Top v0 -> R.Span [] [] $ [R.report v0]
    
instance Report Host where
  report x = case x of
    Host v0 v2 -> R.Span [] [] $ [R.report v0, R.key ":", R.report v2]
    
instance Report Stmt where
  report x = case x of
    Skip  -> R.Span [] [] $ [R.key "skip"]
    Assign v0 v2 -> R.Span [] [] $ [R.report v0, R.key ":=", R.report v2]
    Invoke v0 -> R.Span [] [] $ [R.report v0]
    If v1 v3 -> R.Span [] [] $ [R.key "if", R.report v1, R.key ":", R.report v3]
    Loop v2 -> R.Span [] [] $ [R.key "loop", R.key ":", R.report v2]
    
instance Report Action where
  report x = case x of
    Action v0 v1 v3 -> R.Span [] [] $ [R.report v0, R.report v1, R.key "(", R.report v3, R.key ")"]
    
instance Report Formula where
  report x = case x of
    And v0 v2 -> R.Span [] [] $ [R.report v0, R.key "&&", R.report v2]
    Or v0 v2 -> R.Span [] [] $ [R.report v0, R.key "||", R.report v2]
    Not v1 -> R.Span [] [] $ [R.key "!", R.report v1]
    Eq v0 v2 -> R.Span [] [] $ [R.report v0, R.key "==", R.report v2]
    Neq v0 v2 -> R.Span [] [] $ [R.report v0, R.key "!=", R.report v2]
    Lt v0 v2 -> R.Span [] [] $ [R.report v0, R.key "<", R.report v2]
    Leq v0 v2 -> R.Span [] [] $ [R.report v0, R.key "<=", R.report v2]
    Gt v0 v2 -> R.Span [] [] $ [R.report v0, R.key ">", R.report v2]
    Geq v0 v2 -> R.Span [] [] $ [R.report v0, R.key ">=", R.report v2]
    In v0 v2 -> R.Span [] [] $ [R.report v0, R.key "in", R.report v2]
    
instance Report Term where
  report x = case x of
    V v0 -> R.Span [] [] $ [R.report v0]
    N v0 -> R.Span [] [] $ [R.Text v0]
    Plus v0 v2 -> R.Span [] [] $ [R.report v0, R.key "+", R.report v2]
    Minus v0 v2 -> R.Span [] [] $ [R.report v0, R.key "-", R.report v2]
    Mult v0 v2 -> R.Span [] [] $ [R.report v0, R.key "*", R.report v2]
    Div v0 v2 -> R.Span [] [] $ [R.report v0, R.key "/", R.report v2]
    Pow v0 v2 -> R.Span [] [] $ [R.report v0, R.key "^", R.report v2]
    Neg v1 -> R.Span [] [] $ [R.key "-", R.report v1]
    
instance Report Variable where
  report x = case x of
    Variable v0 -> R.Span [] [] $ [R.Text v0]
    
instance Report Constant where
  report x = case x of
    Constant v0 -> R.Span [] [] $ [R.Text v0]
    

--eof