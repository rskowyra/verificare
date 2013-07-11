
module Language.VML.Parse (parseString)
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

import Language.VML.AbstractSyntax

----------------------------------------------------------------
-- Exported functions.

parseString :: String -> Either ParseError Top
parseString s = PI.runIndent "" $ runParserT topP () "" s

----------------------------------------------------------------
-- Top-level parser.

type ParseState = StateT SourcePos Identity
type ParseFor a = ParsecT [Char] () ParseState a

topP :: ParseFor Top
topP = do { whiteSpace ; hs <- many1 hostP ; eof ; return $ Top hs }

hostP :: ParseFor Host
hostP = withIndent (do { res "host" ; h <- con ; return h }) stmtP Host

----------------------------------------------------------------
-- Statement parser.

stmtP :: ParseFor Stmt
stmtP = (
         do { res "skip" ; return Skip }
    <?|> do { v <- var ; rO ":=" ; t <- termP ; return $ Assign v t }
    <?|> do { a <- actionP ; return $ Invoke a }
    <?|> withIndent (do { res "if" ; f <- formulaP ; rO ":" ; return f}) stmtP If
    <?|> withIndent (do { res "loop:" }) stmtP (\_ -> Loop)
  ) <?> "statement"

actionP :: ParseFor Action
actionP =
  do { inst <- var 
     ; rO "."  
     ; act <- var
     ; args <- parens (sepBy caps commaSep)
     ; return $ Action inst act args
     }
  <?> "action"

formulaP :: ParseFor Formula
formulaP = PE.buildExpressionParser formulaOps formulaAtomP <?> "formula"

formulaOps :: PE.OperatorTable String () ParseState Formula
formulaOps =
  [ [ prefix "!" Not
    ]
  , [ binary "&&" And PE.AssocLeft
    , binary "||" Or PE.AssocLeft 
    ]
  ]

formulaAtomP :: ParseFor Formula
formulaAtomP =
      do { t1 <- termP ; op <- relOpP ; t2 <- termP ; return $ op t1 t2 }
  <|> parens formulaP

relOpP :: ParseFor (Term -> Term -> Formula)
relOpP = (
      do { rO "=="; return Eq }
  <|> do { rO "!="; return Neq }
  <|> do { rO "<";  return Lt }
  <|> do { rO "<="; return Leq }
  <|> do { rO ">";  return Gt }
  <|> do { rO ">="; return Geq }
  <|> do { rO "in"; return In }
  ) <?> "term relational operator"

termP :: ParseFor Term
termP = PE.buildExpressionParser termOps termAtomP <?> "term"

termOps :: PE.OperatorTable String () ParseState Term
termOps =
  [ [ prefix "-" Neg
    ]
  , [ binary "^" Pow PE.AssocLeft
    ]
  , [ binary "*" Mult PE.AssocLeft
    , binary "/" Div PE.AssocLeft 
    ]
  , [ binary "+" Plus PE.AssocLeft
    , binary "-" Minus PE.AssocLeft 
    ]
  ]

termAtomP :: ParseFor Term
termAtomP =
      intP
  <|> varP
  <|> parens termP

varP :: ParseFor Term
varP = do { v <- var; return $ V v } <?> "variable"

intP :: ParseFor Term
intP = do { n <- natural; return $ N n } <?> "integer"

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

--eof
