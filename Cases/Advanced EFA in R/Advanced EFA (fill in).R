#### SETUP ####
rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
options("scipen"=10, "digits"=5) # control the decimal places in the output

# Install packages if necessary
# install.packages("psych")  
# install.packages("corrgram") 

## load the packages
library(psych) # multipurpose for psychologist
library(corrgram) # for graphing correlation matrices
library(Hmisc)# multipurpose
library(sem) # structural equation modeling
library(reshape2) # data transformation
library(ggplot2) # general graphing
library(plotrix) # ploting matrix graphs

# Please consult the website of James Steiger (www.statpower.net) for all materials pertaining to this demonstration. ( See Psychology 312)

## load some custom functions
# Useful function for multivariate stats
source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")
# Functions to assist you in FA and SEM
source("http://statpower.net/Content/312/R%20Stuff/AdvancedFactorFunctions.txt")
# Functions by Dirk Enzmann to aid promax rotation
source("http://statpower.net/Content/312/R%20Stuff/fa.promax.R")
# Load Athletic data directly from James Stieger's website

#### Data prep ####


  # lists all availible datasets in the enviroment
  # calling Harman74.cor into existence inside RStudio session
  # segregating the correlation matrix
  # lists the names of the columns
  # lists the names of the rows
  # print the correlation matrix

# for more on the dataset see  Harman, H. H. (1976) Modern Factor Analysis, Third Edition Revised, University of Chicago Press, Table 7.4. ( http://books.google.ca/books?id=e-vMN68C3M4C&printsec=frontcover&source=gbs_ge_summary_r&cad=0#v=twopage&q&f=false , page 125)

#### Data Explorations ####
 
 # get the basic correlogram
 # customize panels
 # sort by PCA


#### FA of 24 Psychological Variables ####

 # examine eigenvalues directly
 # plot the eigen values
 # Request Chi-Square and RMSEA stats
 # conduct MLFA and collect all rotations in a single object
 # print and examine factor loadings

#### Note on RMSEA ####
#### NOTE : The RMSEA index can be thought of roughly as a root mean square standardized residual. # values above .10 indicate an inadequate fit, 
#### values below .05 indicate a very good fit.
#### Point estimates below .01 indicate an outstanding fit, and are seldom obtained.
#### CONFIDENCE INTERVALS must be interpreted, not the point estimates!!!
#### Look for the point estimage whose confidence interval includes zero (indicating a failure to reject the null hypothesis of perfect fit, i.e., RMSEA = 0, at the 0.05 level).


#### Note on MLFA ####
#### MLFA() function comes with the following rotation options:
#### Uncorrelated Factors: Unrotated - Varimax - Quartimin - Bifactor  
####   Correlated Factors:           - Promax              - BifactorOblique 

 # request only Unrotated
 # request only Varimax roation
 # request only Promax


#### FA of Thurstone data ####

 # call a dataset "Thurstone" into existence inside RStudio session
 # save it as a correlation matrix called R.2
 # print R.2

## Explore the correlations graphically
 
 # ordered correlogram
 # unordered correlogram

 # Plot the eigen values in a scree plot
 # Request Chi-Square and RMSEA stats
 # Conduct MLFA and collect all rotations in a single object
 # print and examine factor loadings




