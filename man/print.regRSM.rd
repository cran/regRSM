\name{print.regRSM}
\alias{print.regRSM}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Print 'regRSM' object.
}
\description{
This function print the summary of the RSM procedure.
}
\usage{
\method{print}{regRSM}(x,...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
Fitted 'regRSM' model object.
}
  \item{...}{
Additional arguments not used.
}
}
\details{
The function prints out information about the selection method, screening, initial weights, version (sequential or parallel),
size of the random subpace, number of simulations.
}
\author{
Pawel Teisseyre, Robert A. Klopotek.
}
\examples{
p=100
n=100
beta1 = numeric(p)
beta1[c(1,5,10)]=c(1,1,1)
x = matrix(0,ncol=p,nrow=n)
xval = matrix(0,ncol=p,nrow=n)
xtest = matrix(0,ncol=p,nrow=n)
for(j in 1:p){
    x[,j]=rnorm(n,0,1)
}
y = x \%*\% beta1 + rnorm(n)

p1=regRSM(y,x)
print(p1)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Model}
