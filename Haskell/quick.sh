## Release script for HackageDB.

cd ./Language/VML
imparse -html -hs "Language.VML" "vml.p"
cd ../..

cd ./Language/DA
imparse -html -hs "Language.DA" "da.p"
cd ../..

cd ./Language/Promela
imparse -html -hs "Language.Promela" "promela.p"
cd ../..

#rm -rf dist
runhaskell Setup.lhs configure --user
runhaskell Setup.lhs build
runhaskell Setup.lhs install

##eof
