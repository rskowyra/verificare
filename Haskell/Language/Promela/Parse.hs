
module Language.Promela.Parse (parseString)
  where

----------------------------------------------------------------
-- Parser to convert concrete syntax to abstract syntax.

import Text.Parsec
import qualified Text.Parsec.Indent as PI (withBlock, runIndent)
import qualified Text.Parsec.Token as PT
import qualified Text.Parsec.Expr as PE
import qualified Text.ParserCombinators.Parsec.Language as PL
import qualified Text.ParserCombinators.Parsec.Prim as Prim

import Control.Monad.Trans.State.Lazy (StateT)
import Data.Functor.Identity (Identity)

import Language.Promela.AbstractSyntax

----------------------------------------------------------------
-- Exported functions.

parseString :: String -> Either ParseError Top
parseString s = PI.runIndent "" $ runParserT topP () "" s

----------------------------------------------------------------
-- Top-level parser.

type ParseState = StateT SourcePos Identity
type ParseFor a = ParsecT [Char] () ParseState a

topP :: ParseFor Top
topP = do { whiteSpace ; eof ; return $ Top [] Init }

----------------------------------------------------------------
-- Parsec-specific configuration definitions and synonyms.

langDef :: PL.GenLanguageDef String () ParseState
langDef = PL.javaStyle
  { PL.identStart        = oneOf "abcdefghijkmlnopqrstuvwxyz_" -- Only lowercase.
  , PL.identLetter       = alphaNum <|> oneOf "_'"
  , PL.opStart           = PL.opLetter langDef
  , PL.opLetter          = oneOf "+*=&|:\\[]()"
  , PL.reservedOpNames   = [ "+", "-", "*", "/", "^"
                           , "==", "!=", "<", ">", "<=", ">="
                           , "in"
                           , ".", ",", ":="
                           ]
  , PL.reservedNames     = [ "host"
                           , "loop", "if"
                           , "skip"
                           ]
  , PL.commentLine       = "#"
  }

lang :: PT.GenTokenParser [Char] () ParseState
lang = PT.makeTokenParser langDef

whiteSpace = PT.whiteSpace lang

--eof
