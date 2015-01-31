# The Great SVD Mystery  - Blues lecture slides
rm(list=ls(all=TRUE))
install.packages(c("matrixcalc","psych"))

source("Steiger R library functions.txt")
library(matrixcalc)
library(psych)

# see survey at http://www.statmethods.net/advstats/matrix.html

# The Great SVD mystery
#2.23
# A - any nxp data matrix, with a rank of k
A <- matrix(c(4,7,-1,8,-5,-2,4,2,-1,3,-3,6),4,3)

(qr(A))$rank # rank of A - independent columns/variables

# A = UDV'    # Single Value Decomposition
svdA<-svd(A)
U_svd<-svdA$u                # U 
D_svd<-svdA$d                # D         
V_svd<-svdA$v                # V
U_svd %*% diag(D_svd) %*% t(V_svd) # reconstruction A with UDV' decomposition

# A = VDV'    # Eigen decomposition, special case of SVD
evevAAp <-eigen(A%*%t(A))   
D_AAp   <-evevAAp$values    # eigenvalues  of AA'
V_AAp   <-evevAAp$vectors    # eigenvectors of AA'

evevApA <-eigen(t(A)%*%A)
D_ApA   <-evevApA$values     # eigenvalues  of A'A
V_ApA   <-evevApA$vectors    # eigenvectors of A'A

#    claims to verify:
# 1. D = sqrt(diag(non-zero eigenvalues of A %*% t(A)))    
# 2. U = eigenvectors of AAp, normalized: U'U = I          
# 3. V = eigenvectors of ApA, normalized: V'V = I          



# 1. D from UDV' = sqrt(diag(non-zero eigenvalues of A %*% t(A)))    
D_svd     # D from UDV'
D_AAp     # D from VDV' of AA'
(D_AAp3<-D_AAp[1:3]) # get only the first nonzero (3) compoenents
sqrt(D_AAp)
sqrt(D_AAp3)
all.equal(D_svd,sqrt(D_AAp3)) # if TURE -> Claim veryfied

# 2. U from UDV' are eigenvectors of AAp, normalized: U'U = I         
U_svd     # U from UDV'
V_AAp     # V from VDV' of AA' 
t(U_svd)%*%U_svd # if I -> normalized
t(V_AAp)%*%V_AAp # if I -> normalized
# since nonsymetric matrix A is the rank of
(qr(A))$rank
# we need to grab only the first three eigenvectors 
# to make it compatible with D from UDV'
U_V_AAp<-V_AAp[,1:3]
all.equal(U_svd,U_V_AAp) # if TRUE -> U    =  V     -> Claim veryfied
#                                     UDV'    VDV'

# 3. V = eigenvectors of ApA, normalized: V'V = I
V_svd     # V from UDV'
V_ApA     # V from VDV' of A'A
t(V_svd)%*%V_svd # if I -> normalized
t(V_ApA)%*%V_ApA # if I -> normalized
V_svd-V_ApA  # -> matrices are not equal


# Reproduce UDV' form from eigin decomposition
A
   U_svd       %*%      diag(D_svd)       %*% t(V_svd) # from UDV'
#       U                   D                V' 
  V_AAp[,1:3] %*% sqrt(diag(D_AAp[1:3])) %*% t(V_ApA) # Oops! doesn't reconstruct! Why?
# Because the V from UDV'
V_svd
# is not generally equal to the V from VDV' of A'A
V_ApA
# there is a indeterminancy in the solution of "eigen()" function
# however, U from UDV' 
U_svd
#is in fact equal to the V in VDV' of AA'
V_AAp
# well, upto the rank of the matrix
V_AAp[,1:3]

#       U                   D                V' 
  V_AAp[,1:3] %*% sqrt(diag(D_AAp[1:3])) %*% solve(sqrt(diag(D_AAp[1:3]))) %*% t(V_AAp[,1:3]) %*% A #      # now works
#                                                                   inv(D)U'A

V_AAp[,1:3]%*% sqrt(diag(D_AAp[1:3]))%*% t(V_svd)

# Resume: Use svd() function and not the eigen() fuction!
 






