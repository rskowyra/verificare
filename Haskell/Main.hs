----------------------------------------------------------------
--
-- Verificare
-- <description>
--
-- Main.hs
--   Module for executable.
--

----------------------------------------------------------------
--

module Main where

import Data.List (splitAt, elemIndex)
import qualified Text.RichReports as R
import Text.Ascetic.HTML (html)
import Text.ParserCombinators.Parsec (ParseError)
import System.Environment (getArgs)
import System.IO
import System.Environment (getArgs)

import qualified Language.VML.AbstractSyntax as VA
import qualified Language.VML.Parse as VP (parseString)
import qualified Language.VML.Report as VR
import qualified Language.Promela.AbstractSyntax as PA
import qualified Language.Promela.Parse as PP (parseString)
import qualified Language.Promela.Report as PR
import qualified Verificare.VMLToPromela as VToP (root)

----------------------------------------------------------------
-- The target inputs and outputs, as specified by the user's
-- command-line arguments.

data Target =
    HTML
  | PML
  deriving Eq

----------------------------------------------------------------
-- Take a file path in the form of a string, and try to parse
-- the contents of the file into abstract syntax.

parse :: String -> IO (Maybe VA.Root)
parse str =
  do { r <- return $ VP.parseString str
     ; case r of
         Left err -> do { putStr "parse error: "; print (err :: ParseError) ; return Nothing }
         Right root -> return $ Just root
     }

----------------------------------------------------------------
-- Take a file path in the form of a string, read it, and
-- process it as specified by the command line.

fileNamePrefix :: String -> String
fileNamePrefix s = fst $ splitAt (maybe (length s) id (elemIndex '.' s)) s

procWrite :: [Target] -> String -> IO ()
procWrite outs fname =
  do { txt <- if length fname > 0 then readFile fname else return ""
     ; root <- parse txt
     ; case root of
         Nothing -> return ()
         Just root ->
           do { fname <- return $ fileNamePrefix fname
              ; writeFile (fname ++ ".html") $ 
                  show $ html $ 
                    R.Finalize $ 
                      R.Table [
                        R.Row [
                            R.Field (R.report root), 
                            R.Field (R.Text "    "),
                            R.Field (R.report $ VToP.root root)
                          ]
                        ]
              ; putStr "\n"
              ; putStr "  HTML report emitted."
              ; putStr "\n"
              -- ; putStr $ show (extract $ convertTop' top)
              ; putStr "\n"
              }
     }
     
usage :: IO ()
usage = putStr "\n  Usage:\tverificare [-html] [-pml] \"path/file0.vml\" [\"path/file1.da\" ...]\n"

cmd :: [Target] -> [String] -> IO ()
cmd []      []            = usage
cmd outs    ("-html":rs)  = cmd (HTML:outs) rs
cmd outs    ("-pml" :rs)  = cmd (PML:outs) rs
cmd outs    [f]           = procWrite outs f
cmd _ _                   = usage

main :: IO ()
main =
  do{ args <- getArgs
    ; cmd [] args
    }

--eof
