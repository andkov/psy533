#### Setup ####

rm(list=ls(all=TRUE)) # removes all objects from the current evironment
options("scipen"=10, "digits"=2)

source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")


install.packages("psych")
install.packages("corrgram")
library(psych)
library(corrgram)

#### Data prep ####

AthleticData <- read.csv("http://statpower.net/Content/312/Homework/AthleticsData.csv")

str(AthleticData)
class(AthleticData)
dim(AthleticData)

head(AthleticData)
names(AthleticData)




R <- cor(AthleticData)

dsR <- as.data.frame(R)

#### PCA "by hand" ####

#       R          Correlation matrix
#     F   F'       Grahm-Factors
# VD1/2  D1/2V'    Principle Componet pattern 
#    V  D V'       Earhart-Young decomposition
#    Rv = cv       Eigenvalues and Eigenvectors

eigen <- eigen(R)

V <- eigen$vectors
D <- diag(eigen$values)

Rnew <- V %*% D %*% t(V)
round(R - Rnew)

GF <- V %*% sqrt(D)

Rnew2 <- GF %*% t(GF)

all.equal(Rnew,Rnew2)

#### PCA wih princomp ####

fit <- principal(AthleticData, nfactors=9, rotate="none")


#### Create Correlograms ####
corrgram::corrgram(R)
corrgram(R, upper.panel=panel.conf)
corrgram(R, upper.panel=panel.conf, order=T)
corrgram(R, upper.panel=panel.conf, lower.panel=panel.pie, order=T)

#### EFA with factanal() ####

fit.efa.2 <- factanal(AthleticData, 
                    factors=2, rotation="varimax")

fit.efa.3 <- factanal(AthleticData, 
                      factors=3, rotation="varimax")

print(fit.efa.3)
print(fit.efa.3, digits=2)
print(fit.efa.3, digits=2, cutoff=.2)
print(fit.efa.3, digits=2, cutoff=.2,sort = TRUE)







