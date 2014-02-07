\name{validate.regRSM}
\alias{validate.regRSM}
\alias{validate}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Selects the new final model from existing 'regRSM' object.
}
\description{
This function selects the new final model based on the previously computed final scores.
}
\usage{
\method{validate}{regRSM}(object, yval, xval)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
Fitted 'regRSM' model object.
}
  \item{yval}{
Quantitative response vector from validation set.
}
  \item{xval}{
Input matrix from validation set.
}
}
\details{
To use the function, the argument store_data in the 'regRSM' object must be TRUE.
The function uses final scores from 'regRSM' object to create a ranking of variables. Then the final model which
minimizes the prediction error on specified validation set is chosen.
Object of class 'regRSM' is returned. The final scores in the original 'regRSM' object and in the new one coincide. However the
final models can be different. 
}
\value{
Object of class 'regRSM' is returned.
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
for(j in 1:p){ 
    x[,j]=rnorm(n,0,1)
    xval[,j]=rnorm(n,0,1)  
}
y = x \%*\% beta1 + rnorm(n)
yval = xval \%*\% beta1 + rnorm(n)

p1 = regRSM(y,x,store_data=TRUE)
p2 = validate(p1,yval,xval)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Model}
