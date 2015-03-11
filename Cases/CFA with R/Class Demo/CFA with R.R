rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
options("scipen"=10, "digits"=5) 
######### Set Up Working Directory!!
library(Hmisc)
library(sem)
library(corrgram)
library(psych)
library(sem)
library(ggplot2)

# Please consult the website of James Steiger (www.statpower.net) for all materials pertaining to this demonstration. 


# Useful function for multivariate stats
source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")
# Functions to assist you in FA and SEM
source("http://statpower.net/Content/312/R%20Stuff/AdvancedFactorFunctions.txt")
# Functions by Dirk Enzmann to aid promax rotation
source("http://statpower.net/Content/312/R%20Stuff/fa.promax.R")
# Load Athletic data directly from James Stieger's website
AthleticsData <- read.csv("http://statpower.net/Content/312/Homework/AthleticsData.csv")
# attach(AthleticsData)


#          R            Correlation/Covariance matrix - R  
#      F      F'        Grahm-Factors                 - F
#   VD1/2   D1/2V'      Principle Component patterns  - pcPattern
#   V     D     V'      Earhart-Young decomposition   - V, D   
#      Rv = cv          Eigenvalues and Eigenvectors  

R<-cor(AthleticsData) # correlation matrix R of variables in AthleticsData
R

# cfa1.model <- specify.model("./Cases/CFA with R/Class Demo/CFA1.txt")
cfa1.model <- specifyModel("./Cases/CFA with R/Class Demo/CFA1.txt")
