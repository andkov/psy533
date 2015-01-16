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

