

data LTS state = LTS (Map Id State) [(Event, (Id, Id))]


type Variable = String

data DomainAbstraction =
  DomainAbstraction String [Parameter] [Inference]

  
data Inference =
  Inference Formula Formula

data Formula =
    Eq Term Term
  | In Term Term

  
data Term = 
    Var Variable
  | Index Variable [Exp]

data Ty =
    TyInt
  | TyLabel
  | TyList Ty
  | TyTuple [Ty]
  
data Parameter = 
  Parameter String Ty

data Value =
  Value



--eof