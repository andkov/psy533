#### SETUP ####
rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
options("scipen"=10, "digits"=5) # control the decimal places in the output

# Install packages if necessary
install.packages("psych")  
install.packages("corrgram") 

## load the packages
library(psych) # multipurpose for psychologist
library(corrgram) # for graphing correlation matrices
library(Hmisc)# multipurpose
library(sem) # structural equation modeling
library(reshape2) # data transformation
library(ggplot2) # general graphing
library(plotrix) # ploting matrix graphs

# Please consult the website of James Steiger (www.statpower.net) for all materials pertaining to this demonstration. 

## load some custom functions
# Useful function for multivariate stats
source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")
# Functions to assist you in FA and SEM
source("http://statpower.net/Content/312/R%20Stuff/AdvancedFactorFunctions.txt")
# Functions by Dirk Enzmann to aid promax rotation
source("http://statpower.net/Content/312/R%20Stuff/fa.promax.R")
# Load Athletic data directly from James Stieger's website

#### Data prep ####

# Many packages provide data for examples, to see availible data load the packages and execute the following:
data() # lists all availible datasets
data(Harman74.cor) # calling Harman74.cor into existence inside RStudio session
R <- as.matrix(Harman74.cor[[1]]) # segregating the correlation matrix
colnames(R) # lists the names of the columns
row.names(R) # lists the names of the rows
R # print

# for more on the dataset see  Harman, H. H. (1976) Modern Factor Analysis, Third Edition Revised, University of Chicago Press, Table 7.4. ( http://books.google.ca/books?id=e-vMN68C3M4C&printsec=frontcover&source=gbs_ge_summary_r&cad=0#v=twopage&q&f=false , page 125)

#### Data Explorations ####
corrgram(R)
corrgram(R,upper.panel=panel.conf,lower.panel=panel.pie, order = T)
corrgram(R,upper.panel=panel.conf,lower.panel=panel.pie, order = F)


#### Scree plot ####

eigen(R)$values # examine eigenvalues directly
# plot the eigen values
Scree.Plot(R, main="Scree plot of 24 Psychological variables (n=145)")

FA.Stats(R, n.factors=1:10, n.obs=145, main="RMSEA plot of 24 Psych Variables (n=145)")


# NOTE : The RMSEA index can be thought of roughly as a root mean square standardized residual. # values above .10 indicate an inadequate fit, 
# values below .05 indicate a very good fit.
# Point estimates below .01 indicate an outstanding fit, and are seldom obtained.
# CONFIDENCE INTERVALS must be interpreted, not the point estimates!!!
# look for the point estimage whose confidence interval includes zero (indicating a failure to reject the null hypothesis of perfect fit, i.e., RMSEA = 0, at the 0.05 level).




# 
f1 <- row.names(R)[1:4]
f2 <- row.names(R)[5:9]
f3 <- row.names(R)[10:13]
f4 <- row.names(R)[14:19]
f5 <- row.names(R)[20:24]



