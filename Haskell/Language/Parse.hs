module Language.VML.Parse
  where
import Language.VML.AbstractSyntax



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
----------------------------------------------------------------
-- Parsing functions to export.
parseString :: String -> Either ParseError Top
parseString s = PI.runIndent "" $ runParserT topP () "" s
----------------------------------------------------------------
-- Parser state.
type ParseState = StateT SourcePos Identity
type ParseFor a = ParsecT [Char] () ParseState a
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
symbol     = PT.symbol lang
var        = PT.identifier lang
rO         = PT.reservedOp lang
res        = PT.reserved lang
natural    = PT.natural lang
parens p   = between (symbol "(") (symbol ")") p
bracks p   = between (symbol "[") (symbol "]") p
bars   p   = between (symbol "|") (symbol "|") p
commaSep   = skipMany1 (symbol ",")
binary name f assoc = PE.Infix (do{PT.reservedOp lang name; return f}) assoc
prefix name f       = PE.Prefix (do{PT.reservedOp lang name; return f})
withIndent p1 p2 f = PI.withBlock f p1 p2
con = do { c <- oneOf "ABCDEFGHIJKLMNOPQRSTUVWXYZ" ; cs <- option "" var ; return $ c:cs }
caps = do { cs <- many1 (oneOf "ABCDEFGHIJKLMNOPQRSTUVWXYZ") ; return cs }
(<?|>) p1 p2 = (try p1) <|> p2
----------------------------------------------------------------
-- Parser definition.



--eof