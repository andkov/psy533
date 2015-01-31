rm(list=ls(all=TRUE))

#Load Steiger functions
source(file.path(getwd(),"R Support Materials/functions","Steiger R library functions.txt"))

x1<-as.matrix(c(1,2,3,4,5))# data for vector x
x2<-as.matrix(c(7,6,8,9,10))# data for vectore y
X<-cbind(x1,x2)

N<-nrow(X)            # define the  number of rows in this matrix 
I<-UnitVector(n)


x<-matrix(data1,n,1)  # create 4 by 1 vector x; matrix(data,rows,columns)
xT<-t(x)                    # row vector x, the transpose
x; xT

xTx<-(t(x)%*%x) # scalar      # sum of squared deviation from zero
xxT<-(x%*%t(x)) # 5x5 matrix  # 

xTxInv<-solve(xT%*%x)   # get the inverse of the 1 by 1 matrix xTx
xTxInv

# Px (orthogonal projector of x) matrix to be used in all consequent operations
Px<-x%*%xTxInv%*%xT
Px

# Creating comformable diagonal matrix
(I<-diag(numrows))

# Qx matrix to be used in all consequant operations
(Qx<-I-Px)            
dim(Px)
dim(Qx)

##########################################################################
# (a) Prove that Px is idempotent. That is show that (Px)^2 = Px * Px = Px
(matrix1a<- Px)
(matrix2a<-(Px%*%Px))
all.equal(matrix1a,matrix2a)