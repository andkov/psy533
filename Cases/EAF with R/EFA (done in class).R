#### Setup ####

rm(list=ls(all=TRUE))  #removes all objects from current environment

options("scipen"=10, "digits"=2)

source("http://www.statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")

install.packages("psych")  # installs package
install.packages("corrgram")
library(psych)             # loads for this session
library(corrgram)

#### Data read ####

AthleticData <- read.csv("http://www.statpower.net/Content/312/Homework/AthleticsData.csv")
str(AthleticData)
dim(AthleticData)
class(AthleticData)
head(AthleticData)
names(AthleticData)

R <- cor(AthleticData)

dsR <- as.data.frame(R)

#### PCA by hand ####
#        R        Correlation matrix
#     F   F'      Gram-factor
#  VD1/2 D1/2V'   Principal Components
#     V D V'      Earnhart-Young decomposition
#    Rv = cv      Eigenvalues and Eigenvectors

eigen <- eigen(R)

eigen
str(eigen)
eigen$values    # prints the $values that are part of object eigen
eigen$vectors

V <- eigen$vectors
D <- diag(eigen$values)

Rnew <- V %*% D %*% t(V)

R - Rnew

round(R - Rnew)
all.equal(R, Rnew)


F <- V %*% sqrt(D)
F

Rnew2 <- F %*% t(F)
all.equal(Rnew, Rnew2)

#### PCA with Princomp ####

principal(AthleticData, nfactors=3, rotate="none")

#### Create correlograms ####

corrgram::corrgram(R)
corrgram(R, upper.panel=panel.conf, lower.panel=panel.pie, order=TRUE)

#### EFA with factanal()  ####

fit.efa.2<- factanal(AthleticData, factors=2, rotation="none")
fit.efa.2
fit.efa.3<- factanal(AthleticData, factors=3, rotation="none")
fit.efa.3

print(fit.efa.3, digits=2, cutoff=0)

print(fit.efa.3, digits=2, cutoff=0.2, sort=TRUE)

fit.efa<- factanal(AthleticData, factors=2, rotation="varimax")

fit.efa<- factanal(AthleticData, factors=2, rotation="promax")




