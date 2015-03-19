rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
options("scipen"=10, "digits"=5) 
######### Set Up Working Directory!!
setwd(dir = "C:/Users/koval_000/Documents/533")

library(Hmisc) # matrix and utility functions
library(corrgram) # graphing correlation matrices
library(sem) # structural equation modeling


#### Resources ####

## Please consult the website of James Steiger ( www.statpower.net ) for all materials pertaining to this demonstration.

## For the demonstraction of factor analysis with 'sem' package see Steiger's tutorial entitled "CFA with R" ( http://statpower.net/Content/312/Handout/Confirmatory%20Factor%20Analysis%20with%20R.pdf )

## For the demonstration of FA with custom functions see Steiger's tutorial entitled "Advanced CFA with R" ( http://statpower.net/Content/312/Handout/Advanced%20Confirmatory%20Factor%20Analysis%20in%20R.pdf )

## For detailed discussion of 'sem' package see John Fox paper "Structural Equation Modeling in R with the sem Package" ( http://socserv.mcmaster.ca/jfox/Books/Companion/appendix/Appendix-SEMs.pdf )

## For 'sem' package documentation see http://cran.r-project.org/web/packages/sem/sem.pdf or http://www.rdocumentation.org/packages/sem

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


# R Correlation/Covariance matrix - R 
# F F' Grahm-Factors - F
# VD1/2 D1/2V' Principle Component patterns - 
# V D V' Earhart-Young decomposition - V, D 
# Rv = cv Eigenvalues and Eigenvectors

R<-cor(AthleticsData) # correlation matrix R of variables in AthleticsData
R
round(cor(AthleticsData),2)
corrgram(x=R,order=TRUE,
         main="Correlogram of Athletic Data",
         upper.panel=panel.pie,
         lower.panel=panel.shade)

## selection of availible fit/information indices
# opt <- options(fit.indices = c("GFI", "AGFI", "RMSEA", "NFI", "NNFI","CFI", "RNI", "IFI", "SRMR", "AIC", "AICc", "BIC", "CAIC"))
opt <- options(fit.indices= c("GFI","AGFI","RMSEA","AIC","BIC"))

####  Pure CFA ####

pureCFA.fit.T <- QuickCFA(R=R, n.factors=3, n.obs=1000, factor.names = c("Hand-Eye","Endurance","Strength"))
# summary(pureCFA.fit.T,opt)
# RMSEA(pureCFA.fit.T) 
# GetPattern(pureCFA.fit.T)
cat("\014") # clear console OR pres  Ctrl + L
GetPrettyPattern(pureCFA.fit.T)
summary(pureCFA.fit.T)[c(1:7)]


#### Confirm and Update CFA ####

cat("\014") # clear console 
# summary(pureCFA.fit.T) # overview of the model
sem::modIndices(pureCFA.fit.T)
CheckMod(pureCFA.fit.T) # largest legal mod index
fit.2 <- UseMod(pureCFA.fit.T) # fit new model
GetPrettyPattern(fit.2) # examine factor loading
summary(fit.2)[c(1:7)] # evaluate model performance


cat("\014") # clear console 
# summary(fit.2) # overview of the model
CheckMod(fit.2)# largest legal mod index
fit.3 <- UseMod(fit.2)# fit new model
GetPrettyPattern(fit.3)# examine factor loading
summary(fit.3)[c(1:7)]# evaluate model performance

cat("\014") # clear console 
# summary(fit.4) # overview of the model
CheckMod(fit.3)# largest legal mod index
sem::modIndices(fit.3) # examine top 5 mod Indices
fit.4 <- UseMod(fit.3)# fit new model
GetPrettyPattern(fit.4)# examine factor loading
summary(fit.4)[c(1:7)]# evaluate model performance


CheckMod(fit.4)# largest legal mod index
sem::modIndices(fit.4) # examine top 5 mod Indices
# Should we continue? Decide.
# fit.5 <- UseMod(fit.4)# fit new model
# GetPrettyPattern(fit.5)# examine factor loading
# summary(fit.5)[c(1:7)]# evaluate model performance
# 


####  CFA from EFA ####

#### Note on MLFA ####
#### MLFA() function comes with the following rotation options:
#### Uncorrelated -- Correlated Factors

#### Unrotated --
#### Varimax -- Promax
#### Quartimin --
#### Bifactor -- BifactorOblique
R <- cor(AthleticsData) # remind what R is
fit <- MLFA(R, n.factors = 3, n.obs=1000) # conduct FA
fit # Examine patterns/rotations
FA.Stats(R, n.factors=1:7, n.obs =1000) # verify retention decision
Loadings(fit,cutoff=.5) # examine patterns
#  imports EFA solution to be tested with CFA
#  all values above cutoff= are freely estimated, others fixed to 0
#  default cov.matrix=TRUE, oblique solution
#  can specify what rotatation to use with rotation= option
fit.1 <- QuickEFAtoCFA(R=R,n.factors = 3, n.obs = 1000, cov.matrix=T, cutoff=.3)
fit.2 <- QuickEFAtoCFA(R=R,n.factors = 3, n.obs = 1000, cov.matrix=F, cutoff=.4)

## Examin how CFA tested the theory supplied by EFA
GetPrettyPattern(fit.1)# examine factor loading (obliQue)
GetPrettyPattern(fit.2)# examine factor loading  (orThogonal)

fit.1$semmod # examine the model specification

cefa.fit <- sem::sem(fit.1$semmod, R, 1000)
summary(cefa.fit, opt)
modIndices(cefa.fit)
GetPrettyPattern(cefa.fit)# examine factor loading
CheckMod(cefa.fit)


sem::modIndices(fit.2) # examine top 5 mod Indices
CheckMod(fit.2)# largest legal mod index
fit.3 <- UseMod(fit.2)# fit new model
GetPrettyPattern(fit.3)# examine factor loading
summary(fit.3)[c(1:7)]# evaluate model performance

##... and so on.


#### Joreskog approach ####

## select the largest value in each row of factor pattern matrix
## fix the rest values on the row to zero
## estimate as CFA
## read more about Joreskog approach in Steiger's tutorial entitled "Advanced CFA with R" ( http://statpower.net/Content/312/Handout/Advanced%20Confirmatory%20Factor%20Analysis%20in%20R.pdf )
jor.fit <- QuickJoreskog(R,3,1000)
GetPrettyPattern(jor.fit)










