rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
options("scipen"=10, "digits"=5) 
######### Set Up Working Directory!!
library(Hmisc)
library(corrgram)
library(sem)

# library(semTools)


#### Resources ####

## Please consult the website of James Steiger ( www.statpower.net ) for all materials pertaining to this demonstration. 

## For the demonstraction of factor analysis with 'sem' package see Steiger's tutorial entitled "CFA with R" ( http://statpower.net/Content/312/Handout/Confirmatory%20Factor%20Analysis%20with%20R.pdf )

## For detailed discussion of 'sem' package see John Fox paper "Structural Equation Modeling in R with the sem Package" ( http://socserv.mcmaster.ca/jfox/Books/Companion/appendix/Appendix-SEMs.pdf )

## 'sem' package documentation ( http://cran.r-project.org/web/packages/sem/sem.pdf  or  http://www.rdocumentation.org/packages/sem )



# Useful function for multivariate stats
source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")
# Functions to assist you in FA and SEM
source("http://statpower.net/Content/312/R%20Stuff/AdvancedFactorFunctions.txt")
# Functions by Dirk Enzmann to aid promax rotation
source("http://statpower.net/Content/312/R%20Stuff/fa.promax.R")
# Load Athletic data directly from James Stieger's website
AthleticsData <- read.csv("http://statpower.net/Content/312/Homework/AthleticsData.csv")
# attach(AthleticsData)

