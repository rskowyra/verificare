## Release script for HackageDB.

cabal update
cabal install MissingH transformers split parsec indents compilation staticanalysis ascetic uxadt richreports imparse

cd ./Language/VML
imparse -html -hs "Language.VML" "vml.p"
cd ../..

cd ./Language/Promela
imparse -html -hs "Language.Promela" "promela.p"
cd ../..

rm -rf dist
runhaskell Setup.lhs configure --user
runhaskell Setup.lhs build
runhaskell Setup.lhs install
runhaskell Setup.lhs haddock
runhaskell Setup.lhs sdist

##eof