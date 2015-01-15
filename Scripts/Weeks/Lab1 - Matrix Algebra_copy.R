rm(list=ls(all=TRUE)) # cleans the environment
cat("\014") # clean console

## Linear Transformations, Means, Deviations

# Enter a vector of numbers named X
X <- c(1, 2, 3, 4, 5)

# Create a linear tranformation Y = bX + a, where b = 2,  a = 5
Y <- 2 * X + 5
Y

# Compute mean of X
mean(X)

# Linear tranform of the mean : bX + a, where b = 2,  a = 5
2 * mean(X) + 5

# Compute mean of Y
mean(Y)

# Compute Deviation Score of X named dx
dx <- X - mean(X)

# Variance
var(X)

# Standard Deviation
sd(X)


## Activity #1 
# Demonstrate the effect of linear transformation on variance and standard deviation



## Operations with vectors and matrices

#### Enter data by row
A <- matrix(c(1,2,3,4,5,6),2,3,byrow=FALSE)
A

B <- matrix(c(.1,.2,.3,.4,.5,.6),2,3,byrow=FALSE)
B

a <- matrix(c(1,2,3,4,5,6),6,1)
a

#### Retreive data from matrices
A[1,2]
A[2,3]
A[2,]
A[,2]
A[,2:3]

#### Demonstrate Communtative law
## Particular example
left <- A + B
right <- B + A
print(left,right)
all.equal(left, right)

# A more general  demonstration with simulated numbers
A <- matrix(round(rnorm(6,4,2)),2,3)
B <- matrix(round(rnorm(6,4,2)),2,3)
left <- A + B
right <- B + A
print(left,right)
all.equal(left, right)

#### Demonstrate Associative law (HM1)
#### Demonstrate Distributive law (HM1)



#### Scalar multiplication
A <- matrix(c(1,0,2,5), 2,2)
A
2*A

# 2A = A2
left <- 2 * A
right <- A * 2
print(left,right)
all.equal(left, right)


####  Transposing matrices: Properties
A
t(A)
t(t(A))

# Demonstrate that (A’)’ = A
all.equal(A,t(tA))

### Activity : Demonstrate Key properties of the transpose

# Demonstrate that (cA)’ = cA’
all.equal( t(2*A), 2*t(A) )
# Demonstrate that (A + B)’ =  A’ + B’
all.equal( t(A + B), t(A) + t(B))
# Demonstrate that (AB)’ = B’A’
C <- matrix(round(rnorm(6,4,2)),2,3)
D <- matrix(round(rnorm(6,4,2)),3,2)
all.equal( t(C%*%D), t(D) %*% t(C))


### Demonstrate 3 rules of matrix multiplication (HM1)


# #### Enter correlation matrix
# Rxx <- matrix(c(1.0, 0.5, 0.4,
#                 0.5, 1.0, 0.3,
#                 0.4, 0.3, 1.0),3,3)
# Rxx
# 
# # Take the diagonal
# d <- diag(Rxx)
# d
# 
# 
# # Creat a diagonal matrix
# I <- diag(4)
# I
# 
# # Using only diag function and Rxx object, create an identity matrix of the same size
# D <- diag(diag(Rxx))
# D

#### Vector by Vector multiplication
a <- c(1,2,5)
b <- c(2,4,3)
a
b
sum(a*b)
a%*%b

dim(a) <- c(1,3)
dim(b) <- c(3,1)

a%*%b

b%*%a

#### Matrix by Matrix Multiplication
A <- matrix( c(1,0,2,5), 2,2, byrow=FALSE)
B <- matrix(c(-1,-2,4,3),2,2,byrow=F)
A
B
A %*% B

B %*% A

#### Matrix Division : Inverses
A <- matrix( c(1,3,3,9,6,5,9,1,8), 3,3, byrow=FALSE)
A
solve(A)
A %*% solve(A)
zapsmall(A %*% solve(A))
round(A %*% solve(A))

B <- matrix( c(1, 2,3, 0,1,4,5,6,0), 3,3, byrow=TRUE)
solve(B)


### Class Activity: using A and x matrices on page 40 (AMA) replicate the quadratic form (2.22)

### Inverses and their properties

# AA^-1 = I = A^-1A
left <- A %*% solve(A)
right <- solve(A) %*% A
all.equal(left,right)

# (AB)^-1 =  (B^-1)(A^-1)
left <- solve(A %*% B)
right <- solve(B) %*% solve(A)
all.equal(left,right)

# (A^-1)^-1 = A
left <- solve(solve(A))
right <- A
all.equal(left,right)

# (A')^-1 = (A^-1)'
left <- solve(t(A))
right <- t(solve(A))
all.equal(left,right)


### Determinants and their properties
det(A)

# |A'| = |A| 
left  <- det(t(A))
right <- det(A)
all.equal(left, right)

# |A^-1| = 1/|A| 
left  <- det(solve(A))
right <- 1/det(A)
print(c(left,right))
all.equal(left, right)

# |AB| = |A||B|
left  <- det (A %*% B)
right <- det(A) * det(B)
print(c(left,right))
all.equal(left, right)


### The Trace
A
sum(diag(A))

trace <- function(x){  return(sum(diag(x)))  }
trace(A)

# Tr(A + B) = Tr(A) + Tr(B)
left <- trace(A + B)
right <- trace(A) + trace(B)
print(c(left,right))
all.equal(left, right)

# Tr(A) = Tr(A’)
left <- trace(A)
right <- trace(t(A))
print(c(left,right))
all.equal(left, right)

# Tr(cA) = c Tr(A)
left <- trace(3*A)
right <- 3 * trace(A)
print(c(left,right))
all.equal(left, right)



### Summation v. Matrix
X <- matrix(c(
  45, 55, 47, 1, 3, 33,
  51, 54, 57, 0, 1, 23,
  40, 51, 46, 1, 2, 43, 
  49, 45, 48, 0, 3, 42),4,6, byrow=TRUE)
X

unit <- function(n){matrix(rep(1,n),n,1)}

# pre-multiplying by a summation vector
# summary over individuals for each variable
t(unit(4)) %*% X

# post-multiplying by a summation vector
#  summary for each individuals over all variables
X %*% unit(6)

# weight vector 
w <- c(1,1,1,0,0,0)
# post-multiplying by a weight vector
Y <- X %*% w
Y

# Comput mean using the summation vector
Xbar <- t(unit(4)) %*% X / nrow(X)
Xbar
mean(X[,1])

