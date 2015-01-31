#CREATING CUSTOM FUNCTION,examle from Quick R

# function example - get measures of central tendency
# and spread for a numeric vector x. The user has a
# choice of measures and whether the results are printed.

mysummary <- function(x,npar=TRUE,print=TRUE) {
  
  if (!npar) 
  { center <- mean(x); spread <- sd(x)}
  
  else                    { center <- median(x); spread <- mad(x)}
  
  if (print & !npar) 
    
  { cat("Mean=", center, "\n", "SD=", spread, "\n")} 
  
  else if  (print & npar) 
    
  {cat("Median=", center, "\n", "MAD=", spread, "\n")}
  
  result <- list(center=center,spread=spread)
  return(result)
}

# invoking the function 
set.seed(1234)
x <- rpois(500, 4) 
y <- mysummary(x)
Median= 4
MAD= 1.4826 
# y$center is the median (4) 
# y$spread is the median absolute deviation (1.4826)

y <- mysummary(x, npar=FALSE, print=TRUE)
str(y)
y <- mysummary(x, npar=TRUE, print=TRUE)
str(y)
y
y$center

# no output 
# y$center is the mean (4.052)
# y$spread is the standard deviation (2.01927)



























