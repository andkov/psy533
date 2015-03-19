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

## For the demonstration of FA with custom functions see Steiger's tutorial entitled "Advanced CFA with R" (   http://statpower.net/Content/312/Handout/Advanced%20Confirmatory%20Factor%20Analysis%20in%20R.pdf )

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
round(cor(AthleticsData),2)
corrgram(x=R,order=TRUE,
         main="Correlogram of Athletic Data",
         upper.panel=panel.pie,
         lower.panel=panel.shade)

## selection of availible fit/information indices
# opt <- options(fit.indices = c("GFI", "AGFI", "RMSEA", "NFI", "NNFI","CFI", "RNI", "IFI", "SRMR", "AIC", "AICc", "BIC", "CAIC"))
opt <- options(fit.indices= c("GFI","RMSEA"))


#### 1. Pure Confirmatory Analsyis ####
FNames <- c("Hand-Eye","Endurance","Strength")

# orThogonal = factors are not correlated (default)
pureCFA.fit.T <- QuickCFA(R=R,n.factors=3, n.obs = 1000, factor.names = FNames )
summary(pureCFA.fit.T, opt)
GetPattern(pureCFA.fit.T)
GetPrettyPattern(pureCFA.fit.T)
RMSEA(pureCFA.fit.T)

# obliQue = factors are allowed to correlate
pureCFA.fit.Q <- QuickCFA(R=R,n.factors=3, n.obs = 1000, factor.names = FNames, factor.correlations = TRUE)
summary(pureCFA.fit.Q, opt)
GetPattern(pureCFA.fit.Q)
GetPrettyPattern(pureCFA.fit.Q)
RMSEA(pureCFA.fit.Q)

# Check and use modification indices
modIndices(pureCFA.fit.T) # print all, not all are legal though
CheckMod(pureCFA.fit.T) # print the largest legal modification index
CheckMod(pureCFA.fit.T, loadings.only=FALSE) # prinet largest modIndixes, regardless of legality

fit.2 <- UseMod(pureCFA.fit.T) # update  the fit object with the largest (legal) modIndex
RMSEA(fit.2)
GetPrettyPattern(fit.2)


CheckMod(fit.2)
fit.3 <- UseMod(fit.2)
RMSEA(fit.3)
GetPrettyPattern(fit.3)
summary(fit.3)[c(1:7)]

#### 2. CFA from EFA ####
fromEFA.fit <- QuickEFAtoCFA(R=R, n.factors = 3, n.obs = 1000, rotation = "Varimax")
summary(fromEFA.fit)
GetPrettyPattern(fromEFA.fit)

#### 3. "Confirm and Update" Approach 


#### 4. The "Exploratory-Confirmatory" Approach


