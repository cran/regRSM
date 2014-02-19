\name{regRSM}
\alias{regRSM.default}
\alias{regRSM}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Random Subspace Method (RSM) for linear regression.
}
\description{
Performs Random Subspace Method (RSM) for high-dimensional linear regression to obtain variable importance measures.
The final model is chosen based on validation set or Generalized Information Criterion.
}
\usage{
regRSM(y, x, yval, xval, m, B, parallel, nslaves, store_data, screening,
init_weights, useGIC, thrs, penalty)
}

%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{y}{
Quatitative response vector of length \eqn{n}, where \eqn{n} is a number of observations.
}
  \item{x}{
Input matrix with \eqn{n} rows and \eqn{p} columns, where \eqn{p} is a number of variables. Each row is an observation vector.
}
  \item{yval}{
Optional quatitative response vector from validation set. Default is \code{NULL}. 
}
  \item{xval}{
Optional input matrix from validation set. Default is \code{NULL}.
}
  \item{m}{
The size of the random subspace. Default is \eqn{min(n-1,p)/2}. Parameter \code{m} cannot be larger than the number of observations minus two. 
}
  \item{B}{
Number of repetitions in RSM procedure. Default is 1000.
}
  \item{parallel}{
This argument indicates which version should be used. Default is \code{NO}, which indicates that sequential version isused. See also in details.  
}
  \item{nslaves}{
Number of slaves. Default is 4.
}
  \item{store_data}{
Logical argument indicating whether matrix \code{x} and vector \code{y} should be stored. Default is \code{FALSE}. This argument must be \code{TRUE} when
function \code{validate.regRSM} is used.
}
  \item{screening}{
If the screeing argument is in \eqn{(0,1)}, the initial screening of variables is performed and 'screening \%' 
of variables least correlated with the response are discarded. Then the RSM procedure is performaed on the remaining variables.
Default is NULL, which indicates that no screening is used. 
}
  \item{init_weights}{
This argument indicates whether weighted version of the procedure should be used.   
If the \code{init_weights} argument is \code{TRUE}, weighted version of the RSM procedure is used (called WRSM). In WRSM,
variables are drawn to random subspaces with probabilities proportional to their correlations with the response \code{y}. 
Default is \code{FALSE}, which indicates that variables are drawn to subspaces with equal probabilities. 
}
  \item{useGIC}{
Logical argument indicating whether Generalized Information Criterion (GIC) should be used in the second step of the procedure.
Default is \code{TRUE}.
}
  \item{thrs}{
Cut off threshold. The hierarchical list of models given by the ordering of variables is cut off at level \code{thrs}
in order to avoid fitting linear models which are close to saturated model. Default is \code{thrs=p} if \eqn{p<n/2} and \code{thrs=n/2}
if \eqn{p>n/2}. 
}
  \item{penalty}{
Penalty in Generalized Information Criterion (GIC). Default is \eqn{log(n)} which corresponds to Bayesian Information Criterion (BIC).
}
}
\details{

The Random Subspace Method (RSM) is used to compute importance measures of explanatory variables (RSM final scores).
In the second step the variables are ordered with respect to the final scores. 
From the nested list of models, given by the ordering, the final model is selected (the list is truncated at the level \code{thrs}
to avoid fitting models which are close to saturated model).
By default the final model that minimizes Generalized Information Criterion (GIC) is chosen.
If the validation set is supplied and \code{useGIC=FALSE} then the final model that minimizes prediction error on validation set is selected.    

When screening and weighted version are used together, in the first step screening is performed and then the weighted version (WRSM) is used on the reamining variables.

When \code{parallel=NO} sequential code is used for computaion. Else in our implementation the most costly operation (number of repetitions in RSM procedure) is parallelized. It is very inefficient to
use parallelisation on machine with only single processor with singe core.

\code{regRSM} function in parallel mode does not close created \code{slaves}, because creation of slaves is usually very time consuming. Next parallel call will reuse existing \code{slave} processes. If you want change the number of \code{slaves} please execute \code{mpi.close.Rslaves()} (if \code{parallel=MPI}) and then call function \code{regRSM} with new parameter \code{nslaves}. 

When \code{parallel=POSIX} then \code{OpenMP} like parallel implementation is used. This parallel execution is handled by \code{doParallel} library. It uses parallelisation of loops. The optimal value of \code{nslaves} is the number of prosessor cores in a machine.  

When \code{parallel=MPI} then MPI parallel implementation is used. This parallel execution is handled by \code{Rmpi} library. MPI (Message Passing Interface) uses messages to send job tasks from main process (master) to other processes (slaves). These processes can be running not nessesery on one machine. In our implementation the most costly operation (number of repetitions in RSM procedure) is parallelized. The optimal value of \code{nslaves} is the number of computing cores of all machines configured in MPI framework. If only one machine is used, the best value is number of prosessor cores. If you don't want to use this kind of parallel computations any more remember to close MPI framework by calling \code{mpi.close.Rslaves()}. 

\code{regRSM} function in parallel mode does not close created \code{slaves}, because creation and destruction of slaves is usually very time consuming. Next parallel call will reuse existing \code{slave} processes. If you want change number of \code{slaves} please execute \code{mpi.close.Rslaves()} and then call function \code{regRSM} with new parameter \code{nslaves}.
If you don't want to use parallel computations any more remember to close MPI framework by calling \code{mpi.close.Rslaves()}.

Installing MPI for multiple machines:

In the following we give some guidelines how to install and configure MPI framework on multiple machines.
MPI configuration on multiple machines is straightforward. Each machine must be connected to the main machine (master). While using \pkg{Rmpi} package we must remember that it works a little bit different than typical C MPI application. Usually master process transfers through MPI the whole application and replicates it on available slots (slaves). \pkg{Rmpi} uses existing R installation, so on each machine all required packages must be installed. Only R source code and data are transferred. 
We present the required steps under Ubuntu operating system (we use Ubuntu 12.04 LTS version).
To install Open MPI on Ubuntu type:

\code{
sudo apt-get install libopenmpi-dev openmpi-bin
}

On Ubuntu with installed Open MPI and R one may just run R and type: 

\code{
install.packages("Rmpi")
}

Consider a case when we have several (2 or more) machines with Ubuntu 12.04 LTS operating system, R 3.0, \pkg{Rmpi} and \pkg{regRSM} installed and all machines are connected to the same network. Moreover let's assume we have one network card which is mapped to \code{eth0}. With command \code{ifconfig} we can check what ip addresses our machines have. For simplicity, to avoid changing the configuration, we assign a static address to each machine.
In our network we have 4 PCs with 4 core processor each. We give them the following names and ip addresses: 

\code{
node09: 10.200.1.159
}

\code{
node08: 10.200.1.158
}

\code{
node07: 10.200.1.157
}

\code{
node06: 10.200.1.156
}

We create text file with ip and number of slots in each line. Slot is an instance of our application working in a slave mode. For example if we have a line \code{127.0.0.1 slots=4} then on our machine (localhost) MPI should run up to 4 slave processes. If we request more slaves than slots then  there will be oversubscription of the node and the performance can drop. We can limit the number of slots to 4 by changing the line to \code{127.0.0.1 slots=4 max_slots=4}. In this case request on more than 4 processes on this node will result in an error. While setting hard limits one should remember that the total number of processes created by \pkg{Rmpi} package is equal to the number of slaves plus one (master process). For example if we want each computer to run 4 parallel tasks then we assign 4 slots to each machine. 
Example of our hostfile \code{myhosts}:

\code{
10.200.1.159 slots=4
}

\code{
10.200.1.157 slots=4
}

\code{
10.200.1.158 slots=4
}

\code{
10.200.1.156 slots=4
}

We run MPI application by executing:

\code{
mpiexec -n <no_of_program_copies> -hosts <file_with_hosts> <program_name>
}

Parameter \code{-n} can be misleading when working with \code{Rmpi} package. We want to start one R instance on which we run our experiment. Thus this value should be set to 1. 
To give \pkg{Rmpi} our hostfile just run command: 

\code{mpiexec -n 1 -hostfile myhosts R --no-save}

which means we run one \code{Rscript} process with given hostfile for MPI configuration. In R terminal we type:

\code{
> library(Rmpi)
}

\code{
library(Rmpi)
}

\code{
> mpi.spawn.Rslaves()
}

\code{
mpi.spawn.Rslaves()
}

\code{
    16 slaves are spawned successfully. 0 failed.
}

\code{    
master  (rank 0 , comm 1) of size 17 is running on: node09
}

\code{
slave1  (rank 1 , comm 1) of size 17 is running on: node09
}

\code{
slave2  (rank 2 , comm 1) of size 17 is running on: node09
}

\code{
slave3  (rank 3 , comm 1) of size 17 is running on: node09
}

\code{
... ... ...
}

\code{
slave15 (rank 15, comm 1) of size 17 is running on: node06
}

\code{
slave16 (rank 16, comm 1) of size 17 is running on: node09
}

The above lines indicate that all MPI processes are launched successfully. 

}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
  \item{scores }{RSM final scores.}
  \item{model }{The final model chosen from the list given by the ordering of variables according to the RSM scores.}
  \item{time }{Computational time.}
  \item{data_transfer}{Data transfer time.}
  \item{coefficients}{Coefficients in the selected linear model.}
  \item{input_data}{Input data \code{x} and \code{y}. These objects are stored only if \code{store_data=TRUE}.}
  \item{control}{List constining information about input parameters.}
  \item{informationCriterion}{Values of Generalized Information Criterion calculated for all models from the nested list given by the ordering.}
  \item{predError}{Prediction errors on validation set calculated for all models from the nested list given by the ordering.}
%% ...
}
\references{
Mielniczuk, J., Teisseyre, P., 
\emph{Using random subspace method for prediction and variable importance assessment in linear regression, Computational Statistics and Data Analysis, Vol. 71, 725-742, 2014.}
}
\author{
Pawel Teisseyre, Robert A. Klopotek.
}
%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{predict}, \code{plot}, \code{ImpPlot}, \code{validate}, \code{roc} methods.
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
p1 = regRSM(y,x)
}
\keyword{Model}

