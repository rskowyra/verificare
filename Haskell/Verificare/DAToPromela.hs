----------------------------------------------------------------
--
-- Verificare
-- <description>
--
-- Verificare/DAToPromela.hs
--   Compilation of DA abstract syntax to Promela abstract
--   syntax.
--

----------------------------------------------------------------
--

module Verificare.DAToPromela where

import Data.List (nub)

import qualified Language.DA.AbstractSyntax as DA
import qualified Language.Promela.AbstractSyntax as P

----------------------------------------------------------------
--

root :: DA.Root -> P.Root
root (DA.Root das) = 
  let () = ()
      (proctypes, gds) = unzip [daToProcType da | da <- das]
  in P.Root gds proctypes P.Init

daToProcType :: DA.DA -> (P.ProcType, P.GlobalDecl)
daToProcType (DA.DA v daDecls actdefs fs) =
  let mTypeConsts = [P.MTypeConst (v ++ "_" ++ a) | DA.ActionDef a _ _ _ <- actdefs]
      pDecls = [declToDecl d | d <- daDecls]
  in (P.ProcType v [] pDecls [], P.MType mTypeConsts)

declToDecl :: DA.Decl -> P.Decl
declToDecl d = case d of
  DA.Decl t v Nothing -> P.Decl (tyToTy t) v Nothing Nothing

tyToTy :: DA.Ty -> P.Ty
tyToTy t = case t of
  DA.TyInt -> P.TyInt
  
  
  
{-
host :: V.Host -> (P.ProcType, [P.GlobalDecl])
host (V.Host n ds ss) =
  let ds_ss_gs_s = map decl ds
      ds' = concat [ds | (ds,ss,gs) <- ds_ss_gs_s]
      ss' = concat [ss | (ds,ss,gs) <- ds_ss_gs_s]
      gs = nub $ concat [gs | (ds,ss,gs) <- ds_ss_gs_s]
  in (P.ProcType n [] ds' (ss' ++ map stmt ss), gs)

decl :: V.Decl -> ([P.Decl], [P.Stmt], [P.GlobalDecl])
decl (V.Decl t x mt) =
  let base =
       case mt of
           Nothing           ->
             ([P.Decl P.TyInt x (Just (P.Size (P.N maxArraySize))) Nothing], [], [])
           Just (V.RHS (V.Array ts)) ->
             ( 
               [P.Decl P.TyInt x (Just (P.Size (P.N maxArraySize))) Nothing], 
               [ P.Assign (P.LHS x [P.Index (P.N (toInteger i))]) (term (ts!!i)) 
               | i <- [0..length ts-1]
               ], 
               []
             )
  in case t of
       V.TyInt -> ([P.Decl (ty t) x Nothing (maybe Nothing (Just . rhs) mt)], [], [])
       V.TyArray V.TyInt Nothing -> base
       V.TyArray V.TyInt (Just (V.Dims 1)) -> base
       V.TyArray t (Just (V.Dims n)) ->
         (
          [P.Decl (P.TyDef ("arr" ++ (show t) ++ (show (n-1)))) x (Just (P.Size (P.N maxArraySize))) Nothing],
          [], 
            [ P.Typedef ("arr" ++ (show t) ++ show 1) [P.Decl (ty t) "a" (Just (P.Size (P.N maxArraySize))) Nothing]]
          ++[ P.Typedef ("arr" ++ (show t) ++ show (k+1)) [P.Decl (P.TyDef ("arr" ++ (show t) ++ (show k))) "a" (Just (P.Size (P.N maxArraySize))) Nothing] 
            |  k <- [1..n-2]
            ]
         )

{-
       V.TySet V.TyInt ->
         case mt of
           Nothing                 -> ([P.Decl (P.TyChannel 256 P.TyInt) x Nothing], [], [])
           Just (V.RHS (V.Set ks)) -> ([P.Decl (P.TyChannel 256 P.TyInt) x Nothing], [P.COpS (P.Send x [P.N k]) | V.N k <- ks], [])
-}

ty :: V.Ty -> P.Ty
ty t = case t of
  V.TyInt -> P.TyInt

stmt :: V.Stmt -> P.Stmt
stmt s = case s of
  V.Skip -> P.Skip
  V.Assign x t -> P.Assign (P.LHS x []) (term t)
  V.Action a v c -> P.Skip -- ???
  V.If f ss -> P.If [P.GuardedBlock (formula f) (map stmt ss)]
  V.Loop ss -> P.Do [P.GuardedBlock (P.T) (map stmt ss)]
  V.Select gbs -> P.If [P.GuardedBlock (formula f) (map stmt ss) | V.GuardedBlock f ss <- gbs]

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
    in case term t2 of
         P.V a [] -> foldr P.Or (P.F) [P.Eq pt1 (P.V a [P.Index $ P.N i]) | i <- [0..maxArraySize-1]]
         _ -> P.F

rhs :: V.RHS -> P.RHS
rhs (V.RHS t) = P.RHS (term t)

term :: V.Term -> P.Term
term t = case t of
  V.V x []      -> P.V x []
  V.N n         -> P.N n
  V.Neg t       -> P.Neg (term t)
  V.Plus t1 t2  -> P.Plus (term t1) (term t2)
  V.Minus t1 t2 -> P.Minus (term t1) (term t2)
  V.Mult t1 t2  -> P.Mult (term t1) (term t2)
  V.Div t1 t2   -> P.Div (term t1) (term t2)
  V.Pow t1 t2   -> P.Pow (term t1) (term t2)
  -- V.Index t1 t2 -> P.Index (term t1) (term t2)

-}
--eof
