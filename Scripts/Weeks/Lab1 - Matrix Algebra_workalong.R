rm(list=ls(all=TRUE)) # cleans the environment
cat("\014") # clean console; hotkey 

## Linear Transformations, Means, Deviations

# Enter a vector of numbers named X


# Create a linear tranformation Y = bX + a, where b = 2,  a = 5



# Compute mean of X


# Linear tranform of the mean : bX + a, where b = 2,  a = 5


# Compute mean of Y


# Compute Deviation Score of X named dx


# Variance


# Standard Deviation



## Activity #1 
# Demonstrate the effect of linear transformation on variance and standard deviation



## Operations with vectors and matrices

#### Enter data by row









#### Retreive data from matrices






#### Demonstrate Communtative law
## Particular example





# A more general  demonstration with simulated numbers







#### Demonstrate Associative law (HM1)
#### Demonstrate Distributive law (HM1)



#### Scalar multiplication




# 2A = A2






####  Transposing matrices: Properties





# Demonstrate that (A’)’ = A


### Activity : Demonstrate Key properties of the transpose

# Demonstrate that (cA)’ = cA’

# Demonstrate that (A + B)’ =  A’ + B’

# Demonstrate that (AB)’ = B’A’





### Demonstrate 3 rules of matrix multiplication (HM1)


#### Vector by Vector multiplication














#### Matrix by Matrix Multiplication









#### Matrix Division : Inverses











### Class Activity: using A and x matrices on page 40 (AMA) replicate the quadratic form (2.22)

### Inverses and their properties

# AA^-1 = I = A^-1A




# (AB)^-1 =  (B^-1)(A^-1)




# (A^-1)^-1 = A




# (A')^-1 = (A^-1)'





### Determinants and their properties


# |A'| = |A| 





# |A^-1| = 1/|A| 





# |AB| = |A||B|






### The Trace






# Tr(A + B) = Tr(A) + Tr(B)






# Tr(A) = Tr(A’)






# Tr(cA) = c Tr(A)







### Summation v. Matrix
X <- matrix(c(
  45, 55, 47, 1, 3, 33,
  51, 54, 57, 0, 1, 23,
  40, 51, 46, 1, 2, 43, 
  49, 45, 48, 0, 3, 42),4,6, byrow=TRUE)
X



# pre-multiplying by a summation vector
# summary over individuals for each variable


# post-multiplying by a summation vector
#  summary for each individuals over all variables


# weight vector 

# post-multiplying by a weight vector



# Comput mean using the summation vector



