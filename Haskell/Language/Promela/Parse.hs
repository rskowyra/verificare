-- This module generated automatically by imparse.

module Language.Promela.Parse
  where

import Language.Promela.AbstractSyntax

----------------------------------------------------------------
-- Parser to convert concrete syntax to abstract syntax.

import Text.Parsec
import qualified Text.Parsec.Indent as PI (runIndent, checkIndent, withPos, indented, block)
import qualified Text.Parsec.Token as PT
import qualified Text.Parsec.Expr as PE
import qualified Text.ParserCombinators.Parsec.Language as PL
import qualified Text.ParserCombinators.Parsec.Prim as Prim

import Control.Monad.Trans.State.Lazy (StateT)
import Data.Functor.Identity (Identity)

----------------------------------------------------------------
-- Parsing functions to export.

parseString :: String -> Either ParseError Root
parseString s = PI.runIndent "" $ runParserT root () "" s

----------------------------------------------------------------
-- Parser state.

type ParseState = StateT SourcePos Identity
type ParseFor a = ParsecT [Char] () ParseState a

----------------------------------------------------------------
-- Parsec-specific configuration definitions and synonyms.

langDef :: PL.GenLanguageDef String () ParseState
langDef = PL.javaStyle
  { PL.identStart        = oneOf "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijkmlnopqrstuvwxyz_" -- Only lowercase.
  , PL.identLetter       = alphaNum <|> oneOf "_'"
  , PL.opStart           = PL.opLetter langDef
  , PL.opLetter          = oneOf "not-adr*/^+"
  , PL.reservedOpNames   = ["not","-","and","or","*","/","^","+"]
  , PL.reservedNames     = ["typedef","=","init","proctype","{",";","}","int","array","<","#",",",">","channel","goto","skip","if","do","atomic","(",")",":","==","!=","<=",">=","in","true","false","[","]","send","receive","."]
  , PL.commentLine       = "#"
  }

lang :: PT.GenTokenParser [Char] () ParseState
lang = PT.makeTokenParser langDef

whiteSpace = PT.whiteSpace lang
symbol     = PT.symbol lang
rO         = PT.reservedOp lang
res        = PT.reserved lang
identifier = PT.identifier lang
natural    = PT.natural lang

binary name f assoc = PE.Infix (do{PT.reservedOp lang name; return f}) assoc
prefix name f       = PE.Prefix (do{PT.reservedOp lang name; return f})

con :: ParseFor String
con = do { c <- oneOf "ABCDEFGHIJKLMNOPQRSTUVWXYZ" ; cs <- option "" identifier ; return $ c:cs }

flag :: ParseFor String
flag = do { cs <- many1 (oneOf "ABCDEFGHIJKLMNOPQRSTUVWXYZ") ; return cs }
-- caps = do { cs <- many1 (oneOf "ABCDEFGHIJKLMNOPQRSTUVWXYZ") ; return cs }

block0 p = PI.withPos $ do { r <- many (PI.checkIndent >> p); return r }
may p = option Nothing (do {x <- p; return $ Just x})
(<?|>) p1 p2 = (try p1) <|> p2

----------------------------------------------------------------
-- Parser definition.

root = do { whiteSpace ; r <- pRoot ; eof ; return r }

pRoot = do {v0 <- (many (pGlobalDecl)); v1 <- (many (pProcType)); v2 <- pInit; return $ Root v0 v1 v2}
  
pGlobalDecl =
      do {res "typedef"; v1 <- identifier; res "="; v3 <- (many1 (pDecl)); return $ Typedef v1 v3}
  <|> do {v0 <- pDecl; return $ GlobalDecl v0}
  
pInit = do {res "init"; return $ Init }
  
pProcType = do {res "proctype"; v1 <- identifier; v2 <- (sepBy pArg (res ",")); res "{"; v4 <- (sepBy1 pDecl (res ";")); res ";"; v6 <- (sepBy1 pStmt (res ";")); res "}"; return $ Proctype v1 v2 v4 v6}
  
pArg = do {v0 <- pTy; v1 <- identifier; return $ Arg v0 v1}
  
pDecl = do {v0 <- pTy; v1 <- identifier; v2 <- (may (pRHS)); return $ Decl v0 v1 v2}
  
pRHS = do {res "="; v1 <- pTerm; return $ RHS v1}
  
pTy =
      do {res "int"; return $ TyInt }
  <|> do {v0 <- identifier; return $ TyDef v0}
  <|> do {res "array"; res "<"; res "#"; res ","; v4 <- pTy; res ">"; return $ TyArray v4}
  <|> do {res "channel"; res "<"; res "#"; res ","; v4 <- pTy; res ">"; return $ TyChannel v4}
  
pStmt =
      do {res "goto"; v1 <- identifier; return $ Goto v1}
  <|> do {res "skip"; return $ Skip }
  <|> do {v0 <- pLHS; res "="; v2 <- pTerm; return $ Assign v0 v2}
  <|> do {res "if"; v1 <- pGuardedBlock; return $ If v1}
  <|> do {res "do"; v1 <- pGuardedBlock; return $ Do v1}
  <|> do {v0 <- pChannelOp; return $ COpS v0}
  <|> do {res "atomic"; v1 <- (many1 (pStmt)); return $ Atomic v1}
  
pLHS = do {v0 <- identifier; v1 <- (many (pSpec)); return $ LHS v0 v1}
  
pGuardedBlock = do {res "("; v1 <- pFormula; res ")"; res ":"; res "{"; v5 <- (sepBy1 pStmt (res ";")); res "}"; return $ GuardedBlock v1 v5}
  
pFormula = PE.buildExpressionParser [[prefix "not" Not],[binary "and" And PE.AssocLeft,binary "or" Or PE.AssocLeft]] (
      do {v0 <- pTerm; res "=="; v2 <- pTerm; return $ Eq v0 v2}
  <|> do {v0 <- pTerm; res "!="; v2 <- pTerm; return $ Neq v0 v2}
  <|> do {v0 <- pTerm; res "<"; v2 <- pTerm; return $ Lt v0 v2}
  <|> do {v0 <- pTerm; res "<="; v2 <- pTerm; return $ Leq v0 v2}
  <|> do {v0 <- pTerm; res ">"; v2 <- pTerm; return $ Gt v0 v2}
  <|> do {v0 <- pTerm; res ">="; v2 <- pTerm; return $ Geq v0 v2}
  <|> do {v0 <- pTerm; res "in"; v2 <- pTerm; return $ In v0 v2}
  <|> do {res "true"; return $ T }
  <|> do {res "false"; return $ F }
  )
pTerm = PE.buildExpressionParser [[binary "*" Mult PE.AssocLeft,binary "/" Div PE.AssocLeft,binary "^" Pow PE.AssocLeft],[binary "+" Plus PE.AssocLeft,binary "-" Minus PE.AssocLeft],[prefix "-" Neg]] (
      do {res "["; v1 <- (sepBy1 pTerm (res ",")); res "]"; return $ Array v1}
  <|> do {res "{"; v1 <- (sepBy1 pTerm (res ",")); res "}"; return $ Set v1}
  <|> do {v0 <- identifier; v1 <- (many (pSpec)); return $ V v0 v1}
  <|> do {v0 <- natural; return $ N v0}
  <|> do {v0 <- pChannelOp; return $ COpT v0}
  )
pChannelOp =
      do {res "send"; v1 <- identifier; res "("; v3 <- (sepBy pTerm (res ",")); res ")"; return $ Send v1 v3}
  <|> do {res "receive"; v1 <- identifier; res "("; v3 <- (sepBy pVariable (res ",")); res ")"; return $ Recv v1 v3}
  
pVariable = do {v0 <- identifier; return $ Variable v0}
  
pSpec =
      do {res "["; v1 <- pTerm; res "]"; return $ Index v1}
  <|> do {res "."; v1 <- identifier; return $ Field v1}
  
pConstant = do {v0 <- identifier; return $ C v0}
  
--eof