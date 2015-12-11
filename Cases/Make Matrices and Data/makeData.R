rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
options("scipen"=10, "digits"=5) 
######### Set Up Working Directory!!
#  setwd(dir = "./ ")

library(Hmisc) # matrix and utility functions
library(corrgram) # graphing correlation matrices
library(sem) # structural equation modeling


#### Resources ####

## Please consult the website of James Steiger ( www.statpower.net ) for all materials pertaining to this demonstration. 

## For the demonstration of custom R functions for multivariate methods  see ( http://statpower.net/Content/312/R%20Stuff/R%20Library%20Functions%20for%20Multivariate%20Analysis.pdf )



#### Custom functions ####
source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")
# Functions to assist you in FA and SEM
source("http://statpower.net/Content/312/R%20Stuff/AdvancedFactorFunctions.txt")

#### CompleteSymmetricMatrix(x) ####
#  x is a vector containing the lower triangular elements of a symmetric matrix. 

R<-CompleteSymmetricMatrix(c(1,.20,1,.30,.15,1)) 
R


#### CompleteCorrelationMatrix(x) ####

# x is a vector containing the lower triangular elements of a correlation
# matrix, excluding the 1’s on the diagonal. 
# This function is similar to CompleteSymmmetricMatrix. However, since there is no need to enter the 1’s on the diagonal, this function allows you to save even more time and omit them. 

R<-CompleteCorrelationMatrix(c(.20,.30,.15)) 
R


####  MakeExactData () #### 
# MakeExactData(MeanVector, CovarianceMatrix, n, use.population=FALSE)

# MeanVector -  p-by-1 vector of means for the p variables,
# CovarianceMatrix is a full rank p-by-p  covariance matrix for the p variables,
# n - is the sample size and must be greater than p. 
# If use.population is TRUE, then the population equivalents (using n instead of n–1 as a denominator) are used to calculate sample variances and covariances instead of the normal sample statistics. 

means <- c(2,3,9)
covariances <- CompleteSymmetricMatrix(c(12,4,13,5,6,12))
covariances
X<-MakeExactData(means,covariances,5)
X
# verify
cov(X) 
apply(X,2,mean)


#### MultivariateNormalSample() ####
# MultivariateNormalSample(mu,Sigma,n)
# mu -     p-by-1 vector of means for the p variables
# Sigma -  full rank p-by-p covariance matrix for the p variables,
# n -      sample size and must be greater than p.
#  simulates a sample of size n from a multivariate normal distribution with mean vector mu and covariance matrix Sigma.

mu <- c(2,3,9)
Sigma <- CompleteSymmetricMatrix(c(12,4,13,5,6,12))
X<-MultivariateNormalSample(mu,Sigma,5)
# verify
cov(X) 
apply(X,2,mean)






