\name{plot.regRSM}
\alias{plot.regRSM}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Plot from 'regRSM' object.
}
\description{
This function produces a plot showing prediction errors on validation set (or the value of Generalized Information Criterion)
with respect to the number of variables included in the model.
}
\usage{
\method{plot}{regRSM}(x,...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
Fitted 'regRSM' model object.
}
  \item{...}{
Other arguments to plot.
}
}
\details{
If Generalized Information Criterion (GIC) was used in the second step of RSM procedure (\code{useGIC=TRUE}) then the function
produces a plot showing the value of GIC with respect to the number of variables included in the model. Model corresponding to
the minimal value of GIC is chosen as a final one.
If GIC was not used (\code{useGIC=FALSE}) and the validation set is supplied then the function
produces a plot showing prediction errors on validation set with respect to the number of variables included in the model. Model corresponding to
the minimal value of the prediction error is chosen as a final one.
}
\author{
Pawel Teisseyre, Robert A. Klopotek.
}
\examples{
p=500
n=50
beta1 = numeric(p)
beta1[c(1,5,10)]=c(1,1,1)  
x = matrix(0,ncol=p,nrow=n)
xval = matrix(0,ncol=p,nrow=n)
xtest = matrix(0,ncol=p,nrow=n)
for(j in 1:p){ 
    x[,j]=rnorm(n,0,1)
    xval[,j]=rnorm(n,0,1)  
}
y = x \%*\% beta1 + rnorm(n)
yval = xval \%*\% beta1 + rnorm(n)

p1=regRSM(x,y)
plot(p1)

p2 = regRSM(x,y,yval,xval,useGIC=FALSE)
plot(p2)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Model}

