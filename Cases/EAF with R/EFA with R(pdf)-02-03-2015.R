rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
options("scipen"=10, "digits"=5) 
######### Set Up Working Directory!!
library(Hmisc)
library(sem)
library(corrgram)
library(psych)
library(sem)

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
eigen<-eigen(R) # eigen decomposition of R      #  VDV' : $values -eigenvalues, $vectors
svd<-svd(R)   # single value decomposition of R #  UDV' : $d      -eigenvalues, $u,$v

Ve<-eigen$vectors            # eigenvectors   from VDV' of R
De<-diag(eigen$values)       # eigenvalues    from VDV' of R
Us<-svd$u                     # eigenvectors U from UDV' of R
Ds<-diag(svd$d)               # eigenvalues    from UDV' of R
Vs<-svd$v                     # eigenvectors V from UDV' of R

Fe<-(Ve %*% sympower(De,1/2))      # principal component pattern F=V(D^1/2) 
Fs<-(Vs) %*% sympower(Ds,1/2)  # same computed from UDV'


# Renaming for convenience
rownames(Ve)<-colnames(R) 
rownames(De)<-colnames(R)
rownames(Us)<-colnames(R)
rownames(Ds)<-colnames(R)
rownames(Vs)<-colnames(R)

colnames(Ve)<-paste0("PC",1:ncol(R)) # name the components
colnames(De)<-paste0("PC",1:ncol(R)) # name the components
colnames(Us)<-paste0("PC",1:ncol(R)) # name the components
colnames(Ds)<-paste0("PC",1:ncol(R)) # name the components
colnames(Vs)<-paste0("PC",1:ncol(R)) # name the components

rownames(Fe)<-colnames(R)      # names the variables
rownames(Fs)<-colnames(R)      # names the variables
colnames(Fe)<-paste0("PC",1:ncol(R)) # name the components
colnames(Fs)<-paste0("PC",1:ncol(R))# name the components

# the values in eigen values are the a the same.
round(abs(Ve)-abs(Vs),3)
round(abs(Ve)-abs(Us),3)
round(abs(Vs)-abs(Us),3)

# but signs differ
sign(Ve)+sign(Vs)
sign(Ve)+sign(Us)
sign(Vs)+sign(Us)

R1<-Ve %*% De %*% t(Ve) # eigen decomposition  R = VDV' 
round(sum((R-R1)^2),10) # should perfectly reconstruct = 0

R1s<- Us %*% Ds %*% t(Vs) # single value R = UDV'
round(((R-R1s)^2),10) # should perfectly reconstruct = 0

######### Compare VDV'(eigen) and UDV'(svd) solutions ##########################
str(R)
head(R)

svd$d
eigen$values

Ve                          # V from VDV'
svd$u                      # U from UDV'
round(abs(Ve)-abs(svd$u),2) # values are the same, signs differ
round(Ve-svd$u,2)           # but not for all columns!
                                                
Ve                          # V from VDV'                                
svd$v                      # V from UDV'                                
round(abs(Ve)-abs(svd$v),2) # values are the same, signs differ          
round(Ve-svd$v,2)           # but not for all columns!                   
########################### this is because we work with square matrices


# Reconstruct R using Grahn Factors from VDV'
R2<-Fe%*%t(Fe) # R2 =(FF') (VD1/2)(VD1/2)'= (VDV') = R
round(sum((R-R2)^2),10) # should perfectly reconstruct = 0

# Reconstruct R using Grahn Factors from UDV'
R2s<-Fs%*%t(Fs) # Factors reconstruct UDV': R2s =(FF') = (VDV') =R
round(sum((R-R2s)^2),10) # should perfectly reconstruct = 0

# # But is is Graph Factor of 
# pcPatternEV
# pcPatternSVD
# round((abs(pcPatternEV)-abs(pcPatternSVD) ),3) # values of loading are the same 
# sign(round(((pcPatternEV-pcPatternSVD)),3)) # the sign differ
# solutions   [1]       [2]        [3]
solution<-c("eigen()", "svd()","principal()")
whatsolution<- solution[3] 
# rotation   [1]      [2]       [3]       [4]       [5]       [6]        [7]  
rotation<-c("none","varimax","quatimax","promax","oblimin","simplimax","cluster")
whatrotation<-as.character(rotation[1])
nfactors<-9
  
fit <- principal(r=AthleticsData, nfactors=nfactors, rotate=whatrotation) 
fit # print results   
# fit$values
# fit$loadings
# str(fit)
F<-fit$loadings[1:9,1:9]
# extract the parameter values from fitted object
eigens<-colSums(fit$loadings*fit$loadings) # eigenvalues
explained<-colSums(fit$loading*fit$loading)/dim(fit$loading)[1]  # variance explained
cumulative<-cumsum(colSums(fit$loading*fit$loading)/dim(fit$loading)[1]) # cummulative
# Create  D matrix with eigenvalues and thier informations
Dplus<-rbind(eigens,explained,cumulative)


# Ve       # Eigen decomposition, eigenvectors,  V from VDV' of R
# De       # Eigen decomposition, eigenvalues,   D from VDV' of R

# Us      # SVD decomposition,   eigenvectors,  U from UDV' of R
# Ds      # SVD decomposition,   eigenvalues,   D from UDV' of R
# Vs      # SVD decomposition,   eigenvectors,  V from UDV' of R

# Dplus   # Eigensvalues from solution of the dedicated routine

# Fe   # principal component pattern F=V(D^1/2) , from EiGenDecomposition
# Fs  # same computed from UDV' # from single value decomposition
# F     # pattern loading from function

#          R            Correlation/Covariance matrix - R  
#      F      F'        Grahm-Factors                 - F
#   VD1/2   D1/2V'      Principle Component patterns  - pcPattern
#   V     D     V'      Earhart-Young decomposition   - V, D   
#      Rv = cv          Eigenvalues and Eigenvectors  

######   Producing graphs   # Ctrl+Alt+E - Run from line to end
pathScree<-file.path(getwd(),"R Support Materials","functions","scree.R")
pathPattern<-file.path(getwd(),"R Support Materials","functions","factor pattern.R")

# palette <- choose_palette() # run to initiate a dialogue to choose palette
# colors<-palette(2) # assign the vector containing the N colorcodes 
colors<- c("darksalmon" ,"lightskyblue")
                                #choose where the file will be stored
pathImageOut<-file.path(getwd(), 
"R Support Materials/Exploratory Factor Analysis with R/principal")
pattern<-F   # matrix for the factor pattern
drawing<- "F"  # name of file with graph

title<- paste0("Pattern values from ",whatsolution," \rotation : ",whatrotation,", Factors = ",nfactors)
ylims<-c(0,3)           # max for eigenvalue plot 
width<-450              # width of pattern in pixels
height<-900             # height of pattern in pixels
width2<-300            # width of scree in pixels
height2<-200            # height of scree in pixels

# source(pathPattern) #produces the graph of pattern loadings


Dplus<- Dplus   # matrix with eigenvalues
title2<- paste0("Scree plot ",whatsolution," rotation : ",whatrotation)
title3<- paste0("Var Explnd from ",whatsolution,".","rotation - ",whatrotation)
source(pathScree) 























