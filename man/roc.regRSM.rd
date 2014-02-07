\name{roc.regRSM}
\alias{roc.regRSM}
\alias{roc}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
ROC curve and AUC parameter.
}
\description{
This function produces ROC curve and computes AUC parameter.
}
\usage{
\method{roc}{regRSM}(object, truemodel, plotit, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
Fitted 'regRSM' model object.
}
  \item{truemodel}{
User specified vector containing indexes of all significant variables. 
}
  \item{plotit}{
Logical argument indicating whether a plot should be produced. If the value is \code{FALSE}, then the value of parameter AUC is returned. 
Default is \code{TRUE}.
}
  \item{...}{
Other arguments to plot.
}
}
\details{
Let \eqn{i_1,\ldots,i_p} be the ordering of variables (e.g. given by the RSM final scores), \eqn{p} is the number of all variables.
ROC curve for ordering is defined as 
\deqn{\textrm{ROC}(s):=(FPR(s),TPR(s)),\quad s\in\{1,\ldots,p\},}
where  
\deqn{FPR(s):=\frac{|SelectedModel(s)\setminus truemodel|}{|truemodel^{C}|},}
\deqn{TPR(s):=\frac{|SelectedModel(s)\cap truemodel|}{|truemodel|},}
\deqn{SelectedModel(s):=\{i_1,\ldots,i_s\},}
\eqn{|A|} denotes cardinality of \eqn{A} and \eqn{A^C} denotes a complement of \eqn{A}.

This function is useful for the evaluation of the ranking produced by the RSM procedure,
when the set of significant variables is known (e.g. in the simulation experiments on artificial datasets). When AUC is equal one it means that all significant
variables, suplied by the user in argment \code{truemodel}, are placed on the top of the ranking list.
}
\value{
ROC curve is produced and the value of parameter AUC is returned.
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
p1 = regRSM(y,x,store_data=TRUE)
true = c(1,5,10)
roc(p1,true,plotit=TRUE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Model}
