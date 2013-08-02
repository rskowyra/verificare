
module Main where

import Data.List (splitAt, elemIndex)
import System.Environment (getArgs)
import System.IO
import Text.ParserCombinators.Parsec (ParseError)

import System.Environment (getArgs)
import System.IO

import qualified Language.VML.AbstractSyntax as VA
import qualified Language.VML.Parse as VP (parseString)
import qualified Language.VML.Report as VR

--import qualified VMLToPromela as VToP (top)

----------------------------------------------------------------
-- The target of the output, as specified by the command-line
-- arguments.

data OutputTarget =
    OutputTarget
  deriving Eq

----------------------------------------------------------------
-- Take a file path in the form of a string, and try to parse
-- the contents of the file into abstract syntax.

parseShow :: String -> IO ()
parseShow fname =
  do { s <- readFile fname
     ; r <- return $ VP.parseString s
     ; case r of
         Left err -> do { putStr "parse error: "; print (err :: ParseError) }
         Right prgm ->
           do { putStr $ show prgm
              }
     }

parse :: String -> IO (Maybe VA.Root)
parse str =
  do { r <- return $ VP.parseString str
     ; case r of
         Left err -> do { putStr "parse error: "; print (err :: ParseError) ; return Nothing }
         Right root -> return $ Just root
     }


----------------------------------------------------------------
-- Abstract syntax to LTS.

{-
data LTSState =
    LTSState Integer
  deriving (Eq, Show)
  

data State =
    State Integer LTS
  deriving (Eq, Show)

  
data Build a =  
    Build (State -> (State, a))
    
instance Monad Build where
   return x = Build $ \s -> (s,x)

   (>>=) (Build mx) mf = Build (
            \state ->
               let (state', x) = mx state
                   (Build mb) = mf x
               in mb state'
          )
  

fresh :: Build Integer
fresh =
  do { State i lts <- getState
     ; setState $ State (i+1) lts
     ; return i
     }

getState :: Build State
getState = Build $ \s -> (s,s)

setState :: State -> Build ()
setState s = Build $ \_ -> (s, ())

nothing :: Build ()
nothing = return ()

getout :: Build b -> b
getout (Build mb) = 
   let (_, x) = mb (State 0 (LTS Nothing []))
   in x
   
extract :: Build b -> State
extract (Build mb) = 
   let (s, _) = mb (State 0 (LTS Nothing []))
   in s
   
test :: a -> Build Integer
test a =
  do { i <- fresh
     ; j <- fresh
     ; k <- fresh
     ; l <- fresh
     ; return $ i + j + k + l
     }

     



data LTS = LTS (Maybe String) [(Action, (LTSState, LTSState))]
  deriving (Eq, Show)

compose :: LTS -> LTS -> LTS
compose (LTS _ lts1) (LTS _ lts2) = LTS Nothing (lts1 ++ lts2)

convertTop :: Top -> LTS
convertTop (Top hs) = foldr compose (LTS Nothing []) [convertHost h | h <- hs]

convertHost :: Host -> LTS
convertHost (Host name stmts) = foldr compose (LTS Nothing []) [convertStmt s | s <- stmts]
  
convertStmt :: Stmt -> LTS
convertStmt s = case s of
  Invoke (a@(Action da lbl cs)) -> LTS Nothing [(a, (LTSState 0, LTSState 0))]
  If f stmts -> foldr compose (LTS Nothing []) [convertStmt s | s <- stmts]
  Loop stmts -> foldr compose (LTS Nothing []) [convertStmt s | s <- stmts]
  _ -> LTS Nothing []

convertTop' :: Top -> Build ()
convertTop' (Top hs) =
  do { mapM convertHost' hs
     ; return ()
     }

convertHost' :: Host -> Build ()
convertHost' (Host name stmts) =
  do { mapM convertStmt' stmts
     ; return ()
     }

convertStmt' :: Stmt -> Build ()
convertStmt' s = case s of
  Invoke (a@(Action da lbl cs)) -> 
    do { (State i lts) <- getState
       ; setState $ State (i+1) (LTS Nothing [(a, (LTSState (i-1), LTSState i))] `compose` lts)
         
       }

  _ -> do nothing
    
    {-  If f stmts -> foldr compose (LTS Nothing []) [convertStmt' s | s <- stmts]
 -} --Loop stmts -> foldr compose (LTS Nothing []) [convertStmt' s | s <- stmts]
-}

  ----------------------------------------------------------------
-- Take a file path in the form of a string, read it, and
-- process it as specified by the command line.

fileNamePrefix :: String -> String
fileNamePrefix s = fst $ splitAt (maybe (length s) id (elemIndex '.' s)) s

procWrite :: [OutputTarget] -> Maybe String -> IO ()
procWrite outs fname =
  do { fname     <- maybe (return "") return fname
     ; txt       <- if length fname > 0 then readFile fname else return ""
     ; top       <- parse txt
     ; case top of
         Nothing -> return ()
         Just top ->
           do { fname <- return $ fileNamePrefix fname
              -- ; putStr $ show $ VToP.top top
              ; putStr "\n"
              -- ; putStr $ show (extract $ convertTop' top)
              ; putStr "\n"
              }
     }
     
usage :: IO ()
usage = putStr "\n  Usage:\tvml \"path/file.vml\"\n"

cmd :: [OutputTarget] -> [String] -> IO ()
cmd []      []            = usage
-- cmd []      [f]           = usage
cmd outs    [f]           = procWrite outs (Just f)
cmd _ _                   = usage

main :: IO ()
main =
  do{ args <- getArgs
    ; cmd [] args
    }

--eof
