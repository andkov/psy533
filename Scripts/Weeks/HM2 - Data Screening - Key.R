#### Prep ####

# remove all elements for a clean start
rm(list=ls(all=TRUE))
cat("\014")


## @knitr InstallPackage
# source("./Scripts/Utility/InstallPackages.R")



## @knitr LoadPackages
require(sas7bdat) # for inputting data 
library(dplyr) # for general data manipulation
library(reshape2) # for data : wide <-> long
library(GGally) # graphing
library(plyr) # data manipulation
library(psych) # data summary + etc
library(ggplot2) # graphing



## @knitr LoadDataInitial
pathDir <- getwd() # establish home directory
pathDs<- file.path(pathDir,"Data/HM2/hm2data.csv")


# record variable names from MPlus script 
namesDs<- c( 'id','Exam_Score', 'Aptitude_Measure', 'Age_in_Years',
             'Intelligence_Score', 'Attention_Span') 

# ds <- read.table(pathDs,col.names = namesDs)
# ds <- read.table(pathDs,header = TRUE)
ds <- read.csv(pathDs,header = TRUE)


## @knitr RenameVariables
ds <- plyr::rename(ds, replace=c("Exam_Score"="score",
                                 'Aptitude_Measure' = "aptit",
                                 'Age_in_Years' = "age",
                                 'Intelligence_Score' = "intel",
                                 'Attention_Span' = "atten"))

## @knitr LoadGraphThemes
baseSize <- 12 # set as the point of further reference
theme1 <- ggplot2::theme_bw(base_size=baseSize) +
  ggplot2::theme(title=ggplot2::element_text(colour="gray20",size = baseSize+1)) +
  ggplot2::theme(axis.text=ggplot2::element_text(colour="gray40", size=baseSize-2)) +
  ggplot2::theme(axis.title=ggplot2::element_text(colour="gray40")) +
  ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80")) +
  ggplot2::theme(axis.ticks.length = grid::unit(0, "cm")) +
  ggplot2::theme(text = element_text(size =baseSize+7)) 


#### Finding Univariate outliers ####

#### Historgrapm: Score ####
# Are there univarite outliers in the variable "score" when values are inspected visually with a histogram?
g <- ggplot2::ggplot(ds, aes(x=score))
g <- g + geom_bar()
g
# what is the id of the person with a potential outlier?
ds <- ds[order(ds$score,decreasing=F),]
head(ds)
# Visual inspection of "score" suggests that id=39 is a univariate outlier

# Are there outlier according to Tukey's filter?
Q1 <- quantile(ds$score)[2]
Q3 <- quantile(ds$score)[4]
IQR <- Q3 - Q1
names(IQR) <- "IQR"
lowerBound <- Q1 - (1.5 * IQR)
names(lowerBound) <- "LB"
upperBound <- Q3 + (1.5 * IQR)
names(upperBound) <- "UB"
c(lowerBound,upperBound)
ds[ds$id==39,"score"]
ds[ds$id==39,"score"] < lowerBound # True if outlier
ds[ds$id==39,"score"] > upperBound # True if outlier
# value of score in id=39 is an outlier according to Tukey filter



#### Historgrapm: Aptitude ####
# Detect a univariate outlier in "aptit" by visul inspection of values
g <- ggplot2::ggplot(ds, aes(x=aptit))
g <- g + geom_bar()
g
# what is the id of the person with a potential outlier?
ds <- ds[order(ds$aptit,decreasing=T),]
head(ds)
# No outliers were detected visually

# Are there outlier according to Tukey's filter?
Q1 <- quantile(ds$aptit)[2]
Q3 <- quantile(ds$aptit)[4]
IQR <- Q3 - Q1
names(IQR) <- "IQR"
lowerBound <- Q1 - (1.5 * IQR)
names(lowerBound) <- "LB"
upperBound <- Q3 + (1.5 * IQR)
names(upperBound) <- "UB"
c(lowerBound,upperBound)
ds[ds$id==28,"aptit"]
ds[ds$id==28,"aptit"] < lowerBound # True if outlier
ds[ds$id==28,"aptit"] > upperBound # True if outlier
# yes, value of aptit" in id=28, 39,20 are outliers according to Tukey filter



#### Historgrapm: Intelligence ####
# Detect a univariate outlier in "aptit" by visul inspection of values
g <- ggplot2::ggplot(ds, aes(x=intel))
g <- g + geom_bar()
g
# what is the id of the person with a potential outlier?
ds <- ds[order(ds$intel,decreasing=F),]
head(ds)
# value of score in id=13 is an outlier according to Tukey filter

# Are there outlier according to Tukey's filter?
Q1 <- quantile(ds$intel)[2]
Q3 <- quantile(ds$intel)[4]
IQR <- Q3 - Q1
names(IQR) <- "IQR"
lowerBound <- Q1 - (1.5 * IQR)
names(lowerBound) <- "LB"
upperBound <- Q3 + (1.5 * IQR)
names(upperBound) <- "UB"
c(lowerBound,upperBound)
ds[ds$id==13,"intel"]
ds[ds$id==13,"intel"] < lowerBound # True if outlier
ds[ds$id==13,"intel"] > upperBound # True if outlier
# yes, value of intel " in id=13 is an outlier according to Tukey filter


#### Historgrapm: Attention ####
# Detect a univariate outlier in "atten" by visul inspection of values
g <- ggplot2::ggplot(ds, aes(x=atten))
g <- g + geom_bar()
g
# what is the id of the person with a potential outlier?
ds <- ds[order(ds$atten,decreasing=T),]
head(ds)
# Visual inspection of "atten" suggests that id=39 is a univariate outlier

# Are there outlier according to Tukey's filter?
Q1 <- quantile(ds$atten)[2]
Q3 <- quantile(ds$atten)[4]
IQR <- Q3 - Q1
names(IQR) <- "IQR"
lowerBound <- Q1 - (1.5 * IQR)
names(lowerBound) <- "LB"
upperBound <- Q3 + (1.5 * IQR)
names(upperBound) <- "UB"
c(lowerBound,upperBound)
ds[ds$id==39,"atten"]
ds[ds$id==39,"atten"] < lowerBound # True if outlier
ds[ds$id==39,"atten"] > upperBound # True if outlier
# yes, value of intel " in id=13 is an outlier according to Tukey filter



#### Multivariate outliers #### 

# create an indicator of multivariate outliers
means <- colMeans(ds[,2:ncol(ds)]) # create a vector of mean using colMeans function
means
covar <- cov(ds[,2:ncol(ds)]) # create a matrix of correlation using cor function
covar

ds$mahal <- mahalanobis(ds[,2:ncol(ds)], means, covar) # create a column storing mahalanobis distance using mahalanobis() function
ds <- ds[order(ds$mahal,decreasing=T),] # order by descreasing "mahal"
ds 

# create a rule for classifying a multivariate outlier based on the mahal value of 10
ds[,"out"] <- ifelse(ds[,"mahal"]>=10 , 1, 0)
ds

# how many observation should be classified as outliers according to mahalanobis distance if 10 is the cutting point?

# Answer : 4


# create a scatter plot of mahal by mahal
g <- ggplot(ds, aes(x=mahal,y=mahal))
g <- g + geom_point()
g

# How many observation should be classified as multivariate outliers according to the visual inspection of the mahal by mahal scatterplot?

# answer : 3

# Observation of which Id would you recommend for elementwise deletion?

# answer : id = 39, 28, 13.

####  Remove outliers ####

# remove from the dataset the rows for individuals with ids you recommended above
out <- c(39, 28, 13) #  create a vector containing the values of id the should be removed
dsNew <- ds[!(ds$id %in% out),] # create a new data set without the values in "out" object. Hint: use %in% operator. Another hist: the entire statement must be negated


#### Effect of removing outliers ####

# using GGallpy::ggpairs examing the effect of removing the recommended outliers on the correlations withing dataset

GGally::ggpairs(ds,columns = 2:6)
GGally::ggpairs(dsNew,columns = 2:6)

# linear relationships between what variables disappear after removing outliers?
# answer: age v score, atten vs score, atten vs aptit

# linear relationships between what variables is affected the least by removal of the outliers? compare the correlation matrices before an after removing outliers
cor(ds[,2:6]) - cor(dsNew[,2:6]) 
# answer : 1) intel vs aptit and 2) intel vs age 3) atten vs intel






