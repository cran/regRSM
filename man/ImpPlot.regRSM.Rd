\name{ImpPlot.regRSM}
\alias{ImpPlot.regRSM}
\alias{ImpPlot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Variable importance plot from 'regRSM' object.
}
\description{
This function produces a dot plot showing final scores from RSM procedure.
}
\usage{
\method{ImpPlot}{regRSM}(object)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
Fitted 'regRSM' model object.
}
}
\details{
This function produces a dot plot showing final scores from RSM procedure.
Final scores describe importances of explanatory variables.
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
for(j in 1:p){ 
    x[,j]=rnorm(n,0,1)
}
y = x \%*\% beta1 + rnorm(n)

p1=regRSM(x,y)
ImpPlot(p1)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Model}

