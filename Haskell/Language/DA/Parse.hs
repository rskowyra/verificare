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
  , PL.opLetter          = oneOf "notadr"
  , PL.reservedOpNames   = ["not","and","or"]
  , PL.reservedNames     = ["da",":","action","pre","`>>[Formula]<<","post","`>>[Postcondition]<<",":=",".","(",")","int","set","<",">","array","^","=","==","!=","<=",">=","in","true","false","*","/","+","-","[","]","{","}"]
  , PL.commentLine       = "#"
  }

lang :: PT.GenTokenParser [Char] () ParseState
lang = PT.makeTokenParser langDef

whiteSpace = PT.whiteSpace lang
symbol     = PT.symbol lang
rO         = PT.reservedOp lang
res        = PT.reserved lang
ide