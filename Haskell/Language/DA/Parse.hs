-- This module was generated automatically by imparse.

module Language.DA.Parse
  where

import Language.DA.AbstractSyntax

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
  , PL.opLetter          = oneOf "-*/^+:<>=.!"
  , PL.reservedOpNames   = ["not","-","and","or","*","/","^","+",":","<",">","=",".",":=","==","!=","<=",">="]
  , PL.reservedNames     = ["host","int","set","array","skip","(",")","select","loop","if","in","true","false","[","]","{","}"]
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

pRoot = do {v0 <- (many1 (pHost)); return $ Root v0}
  
pHost = do {res "host"; v1 <- identifier; rO ":"; v3 <- (PI.indented >> block0 (pDecl)); v4 <- (PI.indented >> PI.block (pStmt)); return $ Host v1 v3 v4}
  
pTy =
       do {res "int"; return $ TyInt }
  <?|> do {res "set"; rO "<"; v2 <- pTy; rO ">"; return $ TySet v2}
  <?|> do {res "array"; rO "<"; v2 <- pTy; rO ">"; v4 <- (may (pDims)); return $ TyArray v2 v4}
  
pDims = do {rO "^"; v1 <- natural; return $ Dims v1}
  
pDecl = do {v0 <- pTy; v1 <- identifier; v2 <- (may (pRHS)); return $ Decl v0 v1 v2}
  
pRHS = do {rO "="; v1 <- pTerm; return $ RHS v1}
  
pStmt =
       do {res "skip"; return $ Skip }
  <?|> do {v0 <- identifier; rO "."; v2 <- identifier; res "("; v4 <- (sepBy pConstant (rO ",")); res ")"; return $ Action v0 v2 v4}
  <?|> do {v0 <- identifier; rO ":="; v2 <- pTerm; return $ Assign v0 v2}
  <?|> do {res "select"; rO ":"; v2 <- (PI.indented >> PI.block (pGuardedBlock)); return $ Select v2}
  <?|> do {res "loop"; rO ":"; v2 <- (PI.indented >> PI.block (pStmt)); return $ Loop v2}
  <?|> do {res "if"; v1 <- pFormula; rO ":"; v3 <- (PI.indented >> PI.block (pStmt)); return $ If v1 v3}
  
pGuardedBlock = do {v0 <- pFormula; rO ":"; v2 <- (PI.indented >> PI.block (pStmt)); return $ GuardedBlock v0 v2}
  
pFormula = PE.buildExpressionParser [[prefix "not" Not],[binary "and" And PE.AssocLeft,binary "or" Or PE.AssocLeft]] (
      do {v0 <- pTerm; rO "=="; v2 <- pTerm; return $ Eq v0 v2}
  <?|> do {v0 <- pTerm; rO "!="; v2 <- pTerm; return $ Neq v0 v2}
  <?|> do {v0 <- pTerm; rO "<"; v2 <- pTerm; return $ Lt v0 v2}
  <?|> do {v0 <- pTerm; rO "<="; v2 <- pTerm; return $ Leq v0 v2}
  <?|> do {v0 <- pTerm; rO ">"; v2 <- pTerm; return $ Gt v0 v2}
  <?|> do {v0 <- pTerm; rO ">="; v2 <- pTerm; return $ Geq v0 v2}
  <?|> do {v0 <- pTerm; res "in"; v2 <- pTerm; return $ In v0 v2}
  <?|> do {res "true"; return $ T }
  <?|> do {res "false"; return $ F }
  )
pTerm = PE.buildExpressionParser [[binary "*" Mult PE.AssocLeft,binary "/" Div PE.AssocLeft,binary "^" Pow PE.AssocLeft],[binary "+" Plus PE.AssocLeft,binary "-" Minus PE.AssocLeft],[prefix "-" Neg]] (
      do {res "["; v1 <- (sepBy pTerm (rO ",")); res "]"; return $ Array v1}
  <?|> do {res "{"; v1 <- (sepBy pTerm (rO ",")); res "}"; return $ Set v1}
  <?|> do {v0 <- identifier; v1 <- (many (pSpec)); return $ V v0 v1}
  <?|> do {v0 <- natural; return $ N v0}
  )
pSpec =
       do {res "["; v1 <- pTerm; res "]"; return $ Index v1}
  <?|> do {rO "."; v1 <- identifier; return $ Field v1}
  
pConstant = do {v0 <- flag; return $ C v0}
  
--eof