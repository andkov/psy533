rm(list=ls(all=TRUE)) # cleans the environment
cat("\014") # clean console

## Refresh of statistic basics: 
## Linear Transformations, Means, Deviations

# Enter a vector named X containing numbers 1, 2, 3, 4, and 5 
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
## Demonstrate the effect of linear transformation on variance and standard deviation



## Operations with vectors and matrices

# Enter data by row
A <- matrix(c(1,2,3,4,5,6),2,3,byrow=FALSE)
A

B <- matrix(c(.1,.2,.3,.4,.5,.6),2,3,byrow=FALSE)
B

a <- matrix(c(1,2,3,4,5,6),6,1)
a

# Retreive data from matrices
A[1,2]
A[2,3]
A[2,]
A[,2]
A[,2:3]


## Demonstrate Communtative law

# Particular example
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

## Demonstrate Associative law (HM1)
## Demonstrate Distributive law (HM1)


## Scalar multiplication
A <- matrix(c(1,0,2,5), 2,2)
A
2*A

# 2A = A2
left <- 2 * A
right <- A * 2
print(left,right)
all.equal(left, right)


##  Transposing matrices: Properties
A
t(A)
t(t(A))

# Demonstrate that (A’)’ = A
all.equal(A,t(tA))

## Activity : Demonstrate Key properties of the transpose

# Demonstrate that (cA)’ = cA’
all.equal( t(2*A), 2*t(A) )
# Demonstrate that (A + B)’ =  A’ + B’
all.equal( t(A + B), t(A) + t(B))
# Demonstrate that (AB)’ = B’A’
C <- matrix(round(rnorm(6,4,2)),2,3)
D <- matrix(round(rnorm(6,4,2)),3,2)
all.equal( t(C%*%D), t(D) %*% t(C)) # see matrix multiplication


## Demonstrate 3 rules of matrix multiplication (HM1)


## Vector by Vector multiplication
a <- c(1,2,5)
b <- c(2,4,3)
a
b
# Elementwise multiplication of a and b
a * b

# Adding the results of elementwise multiplication of a and b
sum(a*b)

# The previous two operations can be replicated by 
# Matrix multiplation of a and b
a%*%b

### in Class STOPPED here

# Change numeric vectors into matrices by assigning  dimension attribute
dim(a) <- c(1,3)
dim(b) <- c(3,1)

# Post multiply a by b (matrix)
a%*%b

# Pre multiply a by b (matrix)
b%*%a


## Matrix by Matrix Multiplication
A <- matrix( c(1,0,2,5), 2,2, byrow=FALSE)
B <- matrix(c(-1,-2,4,3),2,2,byrow=F)


# Pre multiply B by A


# Post multiply B by A


## Matrix Division : Inverses


# Find the inverse of A


# Verify : AA^-1 should be identity



## Slide 18
## Inverses and their properties

## Let
A <- matrix( c(1,3,3,9,6,5,9,1,8), 3,3, byrow=FALSE)
B <- matrix( c(1, 2,3, 0,1,4,5,6,0), 3,3, byrow=TRUE)

# Demonstrate: 
# AA^-1 = I = A^-1A
left <- 
right <- 
all.equal(left,right)

# (AB)^-1 =  (B^-1)(A^-1)
left <- 
right <- 
all.equal(left,right)

# (A^-1)^-1 = A
left <- 
right <- 
all.equal(left,right)

# (A')^-1 = (A^-1)'
left <- 
right <- 
all.equal(left,right)


## Determinants and their properties


## Let
A <- matrix( c(1,3,3,9,6,5,9,1,8), 3,3, byrow=FALSE)
B <- matrix( c(1, 2,3, 0,1,4,5,6,0), 3,3, byrow=TRUE)

# Find the determinant of A


# Demonstrate:
# |A'| = |A| 
left  <- 
right <- 
all.equal(left, right)

# |A^-1| = 1/|A| 
left  <- 
right <- 
print(c(left,right))
all.equal(left, right)

# |AB| = |A||B|
left  <- 
right <- 
print(c(left,right))
all.equal(left, right)


## slide 25
## The Trace

## Let
A <- matrix( c(1,3,3,9,6,5,9,1,8), 3,3, byrow=FALSE)
B <- matrix( c(1, 2,3, 0,1,4,5,6,0), 3,3, byrow=TRUE)

# Find the trace of A


# Define function named "trace" that finds the trace of the matrix that you pass to the function
trace <- function(x){  return(sum(diag(x)))  }
# Pass matrix A to function "trace"


# Demonstrate:
# Tr(A + B) = Tr(A) + Tr(B)
left <- 
right <- 
print(c(left,right))
all.equal(left, right)

# Tr(A) = Tr(A’)
left <- 
right <- 
print(c(left,right))
all.equal(left, right)

# Tr(cA) = c Tr(A)
left <- 
right <- 
print(c(left,right))
all.equal(left, right)



## Summation v. Matrix
# Let (Matrix from AMA text, page 11 and 32)
X <- matrix(c(
  45, 55, 47, 1, 3, 33,
  51, 54, 57, 0, 1, 23,
  40, 51, 46, 1, 2, 43, 
  49, 45, 48, 0, 3, 42),4,6, byrow=TRUE)
X

#create a function named "unit" that creates a summation vector (in fact, a matrix of 1s of the order (1,n), where n is the argument to pass to the function, representing the length of the vector.
unit <- function(n){matrix(rep(1,n),n,1)}

# using function "unit" create a a unit vector of size 4

# using function "unit" create a unity vector of size 6


## Slide 26 
# pre-multiplying by a summation vector
# summary over individuals for each variable


## Slide 27 
# post-multiplying by a summation vector
#  summary for each individuals over all variables


# Select only test scores using a dummy vector
# create a vector of dummy weights

# post-multiplying by a weight vector



# slide 28 
# Compute the mean using the summation vector 
Xbar <- 


# slide 29
# Converting to deviation scores
X
x <- X[,1]
x
xbar <- 



# Create a function to compute deviation scores
dev <- function(x){
N <- nrow(x)
sumv <- unit(N)
P <- sumv%*%t(sumv)/N
x - (P %*% x)
}
dX <- dev(X)
dX


# Let (Matrix from AMA text, page 11 and 32)
X <- matrix(c(
  45, 55, 47, 1, 3, 33,
  51, 54, 57, 0, 1, 23,
  40, 51, 46, 1, 2, 43, 
  49, 45, 48, 0, 3, 42),4,6, byrow=TRUE)
X
X <- X[,1:3]
X


## Slide 31

# Compute covariance of matrix X


# Compute variance of matrix X


# Compute correlation of matrix X



# Slide 32



# slide 33 -34
# Standardize the data matrix X multiplying it with D^-(1/2)



# Create D matrix




# Raise D into the power (-1/2)
sympower <- function(x,pow) {
  edecomp <- eigen(x)
  roots <- edecomp$val
  v <- edecomp$vec
  d <- roots^pow
  if(length(roots)==1) d <- matrix(d,1,1) else d <- diag(d)
  sympow <- v %*% d %*% t(v)
  sympow
}
Dn12 <- 
  

### ********** Alternativive
# Or we can create D^-1/2 by hand
# Create vector of values that should go on the diagonal of D^-1/2 

# Create Dn12 from DnD

## *********** Alternative

## slide 36
# Convert S into R using D^-(1/2)
S <- cov(X)
S
R <- 
R
all.equal(cor(X), R)

# convert S into R using D
R <- cor(X)
R
D <- diag(diag(cov(X)))
D
S <- 
all.equal(cov(X), S)



