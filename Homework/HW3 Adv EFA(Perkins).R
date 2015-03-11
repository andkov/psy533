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
pathFile <- file.path(pathHome,"Homework/LongPerkinsTime1SCI.csv")

#### Data prep ####

ds <- read.table(pathFile, sep=",", header=T) # read in the data
head(ds) # print the first few lines
str(ds) # examine the structure of the object
dim(ds)
nrow(ds)


# convert variables back into numeric
for(i in  colnames(ds)){
  ds[,i]<- as.numeric(ds[,i])
}


# subset the data to keep only the row without any missing values
ds <- na.omit(ds)


##  Data originated from the following questionnaire :
# I am going to read some things that people might say about their block. Each time I read one of these
# statements, please tell me if it is mostly true or mostly false about your block simply by saying "true" (2=MORE SOC) or "false" (1=LESS SOC).

# SCI1 - I think my block is a good place for me to live.
# SCI2 - People on this block do not share the same values. (reverse)
# SCI3 - My neighbors and I want the same things from the block.
# SCI4 - I can recognize most of the people who live on my block.
# SCI5 - I feel at home on this block.
# SCI6 - Very few of my neighbors know me. (reverse)
# SCI7 - I care about what my neighbors think of my actions.
# SCI8 - I have almost no influence over what this block is like. (reverse)
# SCI9 - If there is a problem on this block people who live here can get it solved.
# SCI10 - It is very important to me to live on this particular block.
# SCI11 - People on this block generally don't get along with each other. (reverse)
# SCI12 - I expect to live on this block for a long time.
#
# NOTE: Items 2,6,8,11 are reverse coded! This means that the loading on this item may
# be negative on the designated factor.


# assigning descriptive names to the variables

# varNames <- c(“varname1", "varname2", ... , "varname12")  # Andrea, please edit


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
Scree.Plot(R, main="Scree plot of Sence of Community (SOC) variables (n=575)") # plot the eigen values

#### Question 2 ####
# How many factors does the scree plot suggest to extract? Explain your reasoning 
# A: 3, 4, or 5, depending on the rules you adopt in decision making

# Use FA.Stats() function to request Chi-Square and RMSEA statistics, add a descriptive title
FA.Stats(R, n.factors=1:5, n.obs=575, main="RMSEA plot of Sence of Community (SOC) variables (n=575)") # Request Chi-Square and RMSEA stats

#### Question 3 ####
# How many factors does the Chi-Square criteria suggest to extract? Explain your reasoning 
# A: 4, with 4 factors we can fail to reject the hypothesis of perfect fit at apha=.05

#### Question 4 ####
# How many factors does the RMSEA criteria suggest to extract? Explain your reasoning 
# A: 4, with 4 factors the confidence interval for the point estimate includes zero

out <- MLFA(Correlation.Matrix = R, n.factors=4, n.obs=575) # conduct MLFA and collect all rotations in a single object
Loadings(out, cutoff=.3, num.digits=2) 


#### Question 5 ####
# Does examining the solutions for 3, 4, and 5 factors change what factors you can see?  (Use MLFA() function to study three different sets of solutions)

out.3 <- MLFA(Correlation.Matrix = R, n.factors=3, n.obs=575) 
out.4 <- MLFA(Correlation.Matrix = R, n.factors=4, n.obs=575) 
out.5 <- MLFA(Correlation.Matrix = R, n.factors=5, n.obs=575) 
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
