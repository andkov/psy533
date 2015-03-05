#### SETUP ####
rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
options("scipen"=10, "digits"=3) # control the decimal places in the output

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


pathHome <- getwd()
pathFile <- file.path(pathHome,"Homework/HW3.txt")
pathVarnames <- file.path(pathHome,"Homework/varnames.txt")

#### Data prep ####

ds <- read.table(pathFile, as.is=T) # read in the data
head(ds) # print the first few lines
str(ds) # examine the structure of the object
dim(ds)
nrow(ds)

# convert "." into missing values 
ds[ds == "."] <- NA
ds[ds == "No"] <- 0
ds[ds == "Yes"] <- 1


View(ds)
# # convert into factors and assign labels
# noyesLevels<- c(0,1) # what numeric values should represent levels
# noyesLabels<- c("NO", "YES") # what character strings should represent levels
# # loop through all  variable names
# for(i in  colnames(ds)){
#   ds[,i]<- factor(ds[,i], levels = noyesLevels,labels = noyesLabels)
# }

for(i in  colnames(ds)){
  ds[,i]<- as.numeric(ds[,i])
}

# subset the data to keep only the row without any missing values
ds <- na.omit(ds)
  

# passing descriptive names to the variables
#varNames <- paste("var",1:19)
varNames <- c(“activity”,”anxious”,”quick”,”noreason”,”backgrnd”,”cheerful”,”late”,”tired”,”lively”,”quickly”,
                ”thoughts”,”reserved”,”sensitiv”,”restless”,”nosleep”,”keepself”,”nervous”,”joke”,”worry") 


#### Examine correlations ####

# compute correlation matrix
R <- cor(ds)

# Print the corrleation matrix 
R
# print a correlogram of the correlation matrix using corrgram() function of the corrgram package, use default options
corrgram(R)
# customize the correlogram so that the lower triangle gives pie graphs and upper triangle shows the numerical values for the correlation
corrgram(R,upper.panel=panel.conf,lower.panel=panel.pie) 
# further customize the correlogram so that variable are ordered according to the PCA logic
corrgram(R,upper.panel=panel.conf,lower.panel=panel.pie, order = T) 


#### Question 1 ####
# How many clusters does a visual inspection of the correlogram suggest?
# A: looks like two

#### Conduct factor analysis ####

# list the numerical values of the eignevalues to be examined directly
eigen(R)$values
# Use Scree.Plot() function to request the graph of eigenvalues, add a descriptive title
Scree.Plot(R, main="Scree plot of 19 Psychological variables (n=360)") # plot the eigen values

#### Question 2 ####
# How many factors does the scree plot suggest to extract? Explain your reasoning 
# A: 3, 4, or 5, depending on the rules you adopt in decision making

# Use FA.Stats() function to request Chi-Square and RMSEA statistics, add a descriptive title
FA.Stats(R, n.factors=1:10, n.obs=360, main="RMSEA plot of 19 Psych Variables (n=360)") # Request Chi-Square and RMSEA stats

#### Question 3 ####
# How many factors does the Chi-Square criteria suggest to extract? Explain your reasoning 
# A: 4, with 4 factors we can fail to reject the hypothesis of perfect fit at apha=.05

#### Question 4 ####
# How many factors does the RMSEA criteria suggest to extract? Explain your reasoning 
# A: 4, with 4 factors the confidence interval for the point estimate includes zero

out <- MLFA(Correlation.Matrix = R, n.factors=4, n.obs=360) # conduct MLFA and collect all rotations in a single object
Loadings(out, cutoff=.3, num.digits=2) 

#### Note on RMSEA ####
#### NOTE : The RMSEA index can be thought of roughly as a root mean square standardized residual. 
#### values above .10 indicate an inadequate fit, 
#### values below .05 indicate a very good fit.
#### Point estimates below .01 indicate an outstanding fit, and are seldom obtained.
#### CONFIDENCE INTERVALS must be interpreted, not the point estimates!!!
#### Look for the point estimate whose confidence interval includes zero 
####    (indicating a failure to reject the null hypothesis of perfect fit, i.e., RMSEA = 0, at the 0.05 level).


#### Note on MLFA ####
#### MLFA() function comes with the following rotation options:
#### Uncorrelated Factors: Unrotated - Varimax - Quartimin - Bifactor  
####   Correlated Factors:           - Promax              - BifactorOblique 
