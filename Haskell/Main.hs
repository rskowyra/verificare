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

import qualified Language.VML.AbstractSyntax as V
import qualified Language.VML.Parse as V (parseString)
import qualified Language.VML.Report as V
import qualified Language.DA.AbstractSyntax as DA
import qualified Language.DA.Parse as DA (parseString)
import qualified Language.DA.Report as DA
import qualified Language.Promela.AbstractSyntax as P
import qualified Language.Promela.Parse as P (parseString)
import qualified Language.Promela.Report as P
--import qualified Verificare.VMLToPromela as VToP (root)
import qualified Verificare.DAToPromela as DAToP (root)

----------------------------------------------------------------
-- The target inputs and outputs, as specified by the user's
-- command-line arguments.

type CmdLineArg = String

data Flag =
    HTML
  | PML
  deriving Eq

data File =
    DA String
  | VML String
  deriving Eq
  
----------------------------------------------------------------
-- Take a file path in the form of a string, and try to parse
-- the contents of the file into abstract syntax.

parse :: (String -> Either ParseError a) -> String -> IO (Maybe a)
parse parseString str =
  do { r <- return $ parseString str
     ; case r of
         Left err -> do { putStr "parse error: "; print (err :: ParseError) ; return Nothing }
         Right root -> return $ Just root
     }

----------------------------------------------------------------
-- Take a file path in the form of a string, read it, and
-- process it as specified by the command line.

fileNamePrefix :: String -> String
fileNamePrefix s = fst $ splitAt (maybe (length s) id (elemIndex '.' s)) s

fileExtension :: String -> String
fileExtension s = reverse $ fst $ splitAt (maybe (length s) id (elemIndex '.' (reverse s))) (reverse s)

handleFile :: File -> IO R.Report
handleFile f = case f of
  VML fileName ->
    do { txt <- if length fileName > 0 then readFile fileName else return ""
       ; root <- parse V.parseString txt
       ; return $ case root of
           Nothing -> R.Row [R.Field (R.Text "not parsed"), R.Field (R.Conc [])]
           Just root ->
             R.Row [
               R.Field (R.report root) --,
               -- R.Field (R.report $ VToP.root root)
             ]
     }
  DA fileName ->
    do { txt <- if length fileName > 0 then readFile fileName else return ""
       ; root <- parse DA.parseString txt
       ; return $ case root of
           Nothing -> R.Row [R.Field (R.Text "not parsed"), R.Field (R.Conc [])]
           Just root ->
             R.Row [
               R.Field (R.report root) --,
               -- R.Field (R.report $ DAToP.root root)
             ]
     }

output :: [Flag] -> [File] -> IO ()
output outs files =
  do { rs <- mapM handleFile files
     ; writeFile ("out.html") $ show $ html $ R.Finalize $ R.Table rs
     ; putStr "\n"
     ; putStr "  HTML report emitted."
     ; putStr "\n"
     }
     
usage :: IO ()
usage = putStr "\n  Usage:\tverificare [-html] [-pml] \"path/file0.vml\" [\"path/file1.da\" ...]\n"

cmd :: [Flag] -> [File] -> [CmdLineArg] -> IO ()
cmd []      []    []             = usage
cmd flags   files ("-html":args) = cmd (HTML:flags) files args
cmd flags   files ("-pml" :args) = cmd (PML :flags) files args
cmd flags   files (file   :args) =
  case fileExtension file of
    "vml" -> cmd flags (VML file : files) args
    "da"  -> cmd flags (DA file  : files) args
    _     -> usage
cmd _        []    []            = usage
cmd flags    files []            = output flags (reverse files)
--cmd _       _     _            = usage

main :: IO ()
main =
  do args <- getArgs
     cmd [] [] args

--eof
