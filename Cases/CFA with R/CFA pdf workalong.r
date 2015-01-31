rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
######### Set Up Working Directory!!
install.packages("Himsc","sem","colorspace","corrgram","ggplot2" )
library(Hmisc)
library(sem)
library(colorspace)
library(corrgram)
library(psych)
# source('http://www.statpower.net/Content/312/R Stuff/AdvancedFactorFunctionsV1.04.r')
source(file.path(getwd(),"R Support Materials","functions","Steiger R library functions.txt"))
source(file.path(getwd(),"R Support Materials","functions","AdvancedFactorFunctions.txt"))
AthleticsData <- read.csv(file.path(getwd(),"R Support Materials/datasets","AthleticsData.csv"))
attach(AthleticsData)

AD.R <- cor(AthleticsData)
round(cor(AthleticsData),2)
corrgram(x=AD.R,order=TRUE,
         main="Correlogram of Athletic Data",
         upper.panel=panel.pie,
         lower.panel=panel.shade
)


cfa1.model<-specifyModel(file.path(getwd(),"R Support Materials/CFA with R/CFA1.txt"))
cfa1.fit<-sem(cfa1.model,AD.R,1000)
summary(cfa1.fit)
str(cfa1.fit)
cfa1.fit$S

modIndices(cfa1.fit)
summary()

#          R            Correlation/Covariance matrix - R  
#      F      F'        Grahm-Factors                 - F
#   VD1/2   D1/2V'      Principle Component patterns  - pcPattern
#   V     D     V'      Earhart-Young decomposition   - V, D   
#      Rv = cv          Eigenvalues and Eigenvectors  

R<-cor(AthleticsData) # correlation matrix R of variables in AthleticsData

eigen<-eigen(R) # eigen decomposition of R      #  VDV' : $values -eigenvalues, $vectors
svd<-svd(R)   # single value decomposition of R #  UDV' : $d      -eigenvalues, $u,$v

Ve<-eigen$vectors            # eigenvectors   from VDV' of R
De<-diag(eigen$values)       # eigenvalues    from VDV' of R
Us<-svd$u                     # eigenvectors U from UDV' of R
Ds<-diag(svd$d)               # eigenvalues    from UDV' of R
Vs<-svd$v                     # eigenvectors V from UDV' of R

Fe<-(Ve %*% sympower(De,1/2))      # principal component pattern F=V(D^1/2) 
Fs<-(Vs) %*% sympower(Ds,1/2)  # same computed from UDV'

corp<-corrgram(x=cor(AthleticsData),order=TRUE,
         main="Correlogram of Athletic Data",
         upper.panel=panel.pie,
         lower.panel=panel.shade
)

?corrgram

