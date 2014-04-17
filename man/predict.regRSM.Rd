\name{predict.regRSM}
\alias{predict.regRSM}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Predictions from a 'regRSM' object.
}
\description{
This function makes predictions from a 'regRSM' object.
}
\usage{
\method{predict}{regRSM}(object, xnew,...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
Fitted 'regRSM' model object
}
  \item{xnew}{
Matrix of new values for x at which predictions are to be made.
}
  \item{...}{
 Additional arguments not used.
}

}
\details{
Prediction is made based on a final model which is chosen using validation set or Generalized Information Criterion (GIC).
}
\value{
predict.regRSM produces a vector of predictions.
}
\author{
Pawel Teisseyre, Robert A. Klopotek.
}
\examples{
p = 100
n = 100
beta1 = numeric(p)
beta1[c(1,5,10)] = c(1,1,1)  
x = matrix(0,ncol=p,nrow=n)
xtest = matrix(0,ncol=p,nrow=n)
for(j in 1:p){ 
    x[,j] = rnorm(n,0,1)
    xtest[,j] = rnorm(n,0,1)    
}
y = x \%*\% beta1 + rnorm(n)
p1 = regRSM(x,y)
predict(p1,xtest)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Model}
