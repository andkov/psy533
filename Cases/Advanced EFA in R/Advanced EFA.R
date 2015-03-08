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

# Please consult the website of James Steiger (www.statpower.net) for all materials pertaining to this demonstration. ( See Psychology 312). For this particular demonstration, please follow his handout on "Advanced EFA" ( http://statpower.net/Content/312/Handout/Advanced%20Exploratory%20Factor%20Analysis%20in%20R.pdf ) and the lecture on "Practical EFA" ( http://statpower.net/Content/319SEM/Lecture%20Notes/PracticalEFA.pdf )

## load some custom functions
# Useful function for multivariate stats
source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")
# Functions to assist you in FA and SEM
source("http://statpower.net/Content/312/R%20Stuff/AdvancedFactorFunctions.txt")
# Functions by Dirk Enzmann to aid promax rotation
source("http://statpower.net/Content/312/R%20Stuff/fa.promax.R")
# Load Athletic data directly from James Stieger's website

#### Data prep ####

data() # lists all availible datasets
data(Harman74.cor) # calling Harman74.cor into existence inside RStudio session
R <- as.matrix(Harman74.cor[[1]]) # segregating the correlation matrix
colnames(R) # lists the names of the columns
row.names(R) # lists the names of the rows
R # print the correlation matrix

# for more on the dataset see  Harman, H. H. (1976) Modern Factor Analysis, Third Edition Revised, University of Chicago Press, Table 7.4. ( http://books.google.ca/books?id=e-vMN68C3M4C&printsec=frontcover&source=gbs_ge_summary_r&cad=0#v=twopage&q&f=false , page 125)

#### Data Explorations ####

corrgram(R) # get the basic correlogram
corrgram(R,upper.panel=panel.conf,lower.panel=panel.pie) # customize panels
corrgram(R,upper.panel=panel.conf,lower.panel=panel.pie, order = T) # sort by PCA

#### FA of 24 Psychological Variables ####

eigen(R)$values # examine eigenvalues directly
Scree.Plot(R, main="Scree plot of 24 Psychological variables (n=145)") # plot the eigen values
FA.Stats(R, n.factors=1:10, n.obs=145, main="RMSEA plot of 24 Psych Variables (n=145)") # Request Chi-Square and RMSEA stats
out <- MLFA(Correlation.Matrix = R, n.factors=4, n.obs=145) # conduct MLFA and collect all rotations in a single object
Loadings(out, cutoff=.3, num.digits=2) # print and examine factor loadings

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

out$Unrotated # request only Unrotated
out$Varimax # request only Varimax roation
out$Promax # request only Promax


#### FA of Thurstone data ####

data(Thurstone) # call a dataset "Thurstone" into existence inside RStudio session
R.2 <- as.matrix(Thurstone) # save it as a correlation matrix called R.2
R.2 # print R.2

# explore the correlations

corrgram(R,upper.panel=panel.conf,lower.panel=panel.pie, order = T) # ordered correlogram
corrgram(R,upper.panel=panel.conf,lower.panel=panel.pie, order = F) # unordered correlogram


Scree.Plot(R.2, main="Scree plot of Thurstone data (n=213)") # plot the eigen values
FA.Stats(R.2, n.factors=1:4, n.obs=213, main="RMSEA plot of 24 Psych Variables (n=145)") # Find ML solutions and rotations
out.2 <- MLFA(Correlation.Matrix = R.2, n.factors=3, n.obs=213) # Conduct MLFA
Loadings(out.2, cutoff=.3, num.digits=2) # print and examine factor loadings




