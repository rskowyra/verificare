
module VMLToPromela where

import Data.List (nub)

import qualified Language.VML.AbstractSyntax as V
import qualified Language.Promela.AbstractSyntax as P

top :: V.Top -> P.Top
top (V.Top hs) = 
  let hgs = [host h | h <- hs]
      hs' = map fst hgs
      gs = concat $ map snd hgs
  in P.Top gs hs' P.Init

host :: V.Host -> (P.Proctype, [P.GlobalDecl])
host (V.Host n ds ss) =
  let ds_ss_gs_s = map decl ds
      ds' = concat [ds | (ds,ss,gs) <- ds_ss_gs_s]
      ss' = concat [ss | (ds,ss,gs) <- ds_ss_gs_s]
      gs = nub $ concat [gs | (ds,ss,gs) <- ds_ss_gs_s]
  in (P.Proctype n [] ds' (ss' ++ map stmt ss), gs)

decl :: V.Decl -> ([P.Decl], [P.Stmt], [P.GlobalDecl])
decl (V.Decl t x mt) =
  let y = 0
      
  in case t of
       V.TyInt -> 
         ([P.Decl (ty t) x (maybe Nothing (Just . term) mt)], [], [])

       V.TyArray V.TyInt ->
         case mt of
           Nothing           ->
             ([P.Decl (P.TyArray 256 P.TyInt) x Nothing], [], [])
           Just (V.Array ts) ->
             ( 
               [P.Decl (P.TyArray 256 P.TyInt) x Nothing], 
               [ P.Assign (P.LHS x [P.N (toInteger i)]) (term (ts!!i)) 
               | i <- [0..length ts-1]
               ], 
               []
             )
         
       V.TyArray t ->
         let globalDecs k t = case t of
               V.TyArray (t@(V.TyArray _)) -> 
                    [P.Typedef ("arr" ++ show k) [P.Decl (P.TyArray 256 (P.TyDef ("arr" ++ (show (k+1))))) "a" Nothing]]
                 ++ globalDecs (k+1) t

               V.TyArray t -> [P.Typedef ("arr" ++ show k) [P.Decl (P.TyArray 256 (ty t)) "a" Nothing]]
               V.TyInt     -> []

         in case mt of
              Nothing           ->
                ([P.Decl (P.TyArray 256 (P.TyDef "arr0")) x Nothing], [], globalDecs 0 t)
         

           
           
       V.TySet V.TyInt ->
         case mt of
           Nothing         -> ([P.Decl (P.TyChannel 256 P.TyInt) x Nothing], [], [])
           Just (V.Set ks) -> ([P.Decl (P.TyChannel 256 P.TyInt) x Nothing], [P.COStmt (P.Send x [P.N k]) | V.N k <- ks], [])

ty :: V.Ty -> P.Ty
ty t = case t of
  V.TyInt -> P.TyInt

stmt :: V.Stmt -> P.Stmt
stmt s = case s of
  V.Skip -> P.Skip
  V.Assign x t -> P.Assign (P.LHS x []) (term t)
  V.Invoke a -> P.Skip -- ???
  V.If f ss -> P.If [P.GuardedBlock (formula f) (map stmt ss)]
  V.Loop ss -> P.Do [P.GuardedBlock (P.B True) (map stmt ss)]

formula :: V.Formula -> P.Formula
formula f = case f of
  V.And f1 f2 -> P.And (formula f1) (formula f2)
  V.Or  f1 f2 -> P.Or (formula f1) (formula f2)
  V.Not f     -> P.Not (formula f)
  V.Eq  t1 t2 -> P.Eq (term t1) (term t2)
  V.Neq t1 t2 -> P.Neq (term t1) (term t2)
  V.Lt  t1 t2 -> P.Lt (term t1) (term t2)
  V.Leq t1 t2 -> P.Leq (term t1) (term t2)
  V.Gt  t1 t2 -> P.Gt (term t1) (term t2)
  V.Geq t1 t2 -> P.Geq (term t1) (term t2)
  V.In  t1 t2 ->
    let pt1 = term t1
        pt2 = term t2
    in foldr P.Or (P.B False) [P.Eq pt1 (P.Index pt2 (P.N i)) | i <- [0..255]]

term :: V.Term -> P.Term
term t = case t of
  V.V x         -> P.V x
  V.N n         -> P.N n
  V.Neg t       -> P.Neg (term t)
  V.Plus t1 t2  -> P.Plus (term t1) (term t2)
  V.Minus t1 t2 -> P.Minus (term t1) (term t2)
  V.Mult t1 t2  -> P.Mult (term t1) (term t2)
  V.Div t1 t2   -> P.Div (term t1) (term t2)
  V.Pow t1 t2   -> P.Pow (term t1) (term t2)
  V.Index t1 t2 -> P.Index (term t1) (term t2)
    
--eof