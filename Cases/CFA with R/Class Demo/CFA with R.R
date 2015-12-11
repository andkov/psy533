rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
options("scipen"=10, "digits"=5) 
######### Set Up Working Directory!!
#  setwd(dir = "./ ")

library(Hmisc) # matrix and utility functions
library(corrgram) # graphing correlation matrices
library(sem) # structural equation modeling


#### Resources ####

## Please consult the website of James Steiger ( www.statpower.net ) for all materials pertaining to this demonstration. 

## For the demonstraction of factor analysis with 'sem' package see Steiger's tutorial entitled "CFA with R" ( http://statpower.net/Content/312/Handout/Confirmatory%20Factor%20Analysis%20with%20R.pdf )

## For detailed discussion of 'sem' package see John Fox paper "Structural Equation Modeling in R with the sem Package" ( http://socserv.mcmaster.ca/jfox/Books/Companion/appendix/Appendix-SEMs.pdf )

## For 'sem' package documentation see  http://cran.r-project.org/web/packages/sem/sem.pdf  or  http://www.rdocumentation.org/packages/sem 

## For "Exploratory-Confirmatory" Approach see Karl Joreskog 1978 paper ( http://www.researchgate.net/profile/Karl_Joereskog/publication/24062332_Structural_analysis_of_covariance_and_correlation_matrices/links/0046352b8b078d34d6000000.pdf )



#### Custom functions ####
source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")
# Functions to assist you in FA and SEM
source("http://statpower.net/Content/312/R%20Stuff/AdvancedFactorFunctions.txt")
# Functions by Dirk Enzmann to aid promax rotation
source("http://statpower.net/Content/312/R%20Stuff/fa.promax.R")

#### Data and Option prep ####

# Load Athletic data directly from James Stieger's website
AthleticsData <- read.csv("http://statpower.net/Content/312/Homework/AthleticsData.csv")
# attach(AthleticsData)


#          R            Correlation/Covariance matrix - R  
#      F      F'        Grahm-Factors                 - F
#   VD1/2   D1/2V'      Principle Component patterns  - 
#   V     D     V'      Earhart-Young decomposition   - V, D   
#      Rv = cv          Eigenvalues and Eigenvectors  

R<-cor(AthleticsData) # correlation matrix R of variables in AthleticsData
R



## selection of availible fit/information indices
# opt <- options(fit.indices = c("GFI", "AGFI", "RMSEA", "NFI", "NNFI","CFI", "RNI", "IFI", "SRMR", "AIC", "AICc", "BIC", "CAIC"))
opt <- options(fit.indices= c("GFI","RMSEA"))
standardizedCoefficients(cfa1.fit) # a cleaner print of coefficients than summary()

#### 1. Pure Confirmatory Analsyis ####
cfa1.model <- specifyModel("./Cases/CFA with R/Class Demo/CFA1.txt")
cfa1.fit <- sem(cfa1.model, R, 1000)
summary(cfa1.fit, opt)
modIndices(cfa1.fit)

#### 2. "Confirm and Update" Approach 
cfa2.model <- specifyModel("./Cases/CFA with R/Class Demo/CFA2.txt")
cfa2.fit <- sem(cfa2.model, R, 1000)
summary(cfa2.fit, opt)
modIndices(cfa2.fit)

cfa3.model <- specifyModel("./Cases/CFA with R/Class Demo/CFA3.txt")
cfa3.fit <- sem(cfa3.model, R, 1000)
summary(cfa3.fit, opt)
modIndices(cfa3.fit)

cfa4.model <- specifyModel("./Cases/CFA with R/Class Demo/CFA4.txt")
cfa4.fit <- sem(cfa4.model, R, 1000)
summary(cfa4.fit, opt)
modIndices(cfa4.fit)

#### 3. The "Exploratory-Confirmatory" Approach


