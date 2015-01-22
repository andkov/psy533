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
A
B

# Pre multiply B by A
A %*% B

# Post multiply B by A
B %*% A

## Matrix Division : Inverses
A <- matrix( c(1,3,3,9,6,5,9,1,8), 3,3, byrow=FALSE)
A

# Find the inverse of A
solve(A)

# Verify : AA^-1 should be identity
A %*% solve(A)
zapsmall(A %*% solve(A))
round(A %*% solve(A))

B <- matrix( c(1, 2,3, 0,1,4,5,6,0), 3,3, byrow=TRUE)
solve(B)


## Possible Activity: using A and x matrices on page 40 (AMA) replicate the quadratic form (2.22)

## Inverses and their properties

# Demonstrate: 
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


## Determinants and their properties

# Find the determinant of A
det(A)

# Demonstrate:
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


## The Trace
A
# Find the trace of A
sum(diag(A))

# Define function named "trace" that finds the trace of the matrix that you pass to the function
trace <- function(x){  return(sum(diag(x)))  }
# Pass matrix A to function "trace"
trace(A)

# Demonstrate:
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



## Summation v. Matrix
# Matrix from AMA text, page 11 and 32
X <- matrix(c(
  45, 55, 47, 1, 3, 33,
  51, 54, 57, 0, 1, 23,
  40, 51, 46, 1, 2, 43, 
  49, 45, 48, 0, 3, 42),4,6, byrow=TRUE)
X

#create a function named "unit" that creates a summation vector (in fact, a matrix of 1s of the order (1,n), where n is the argument to pass to the function, representing the length of the vector.
unit <- function(n){matrix(rep(1,n),n,1)}

# using function "unit" create a a unit vector of size 4
unit(4)
# using function "unit" create a unity vector of size 6
unit(6)


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

# slide 28 
# Compute the mean using the summation vector 
Xbar <- t(unit(4)) %*% X / nrow(X)
Xbar
mean(X[,1])

<<<<<<< HEAD
# Converting to deviation scores
X
x <- X[,1]
x
dx <- x - mean(x)
dx
=======

# slide 33
# Standardize the data matrix X multiplying it with D^-(1/2)


# slide 34
#  Production of matrix D^-(1/2)


# slide 36
# Convert S into R using D^-(1/2)


# convert S into R 

>>>>>>> origin/master