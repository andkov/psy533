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
#  Tukey filter is a rule for detecting outliers developed by John Tukey, see description and discussion at http://datapigtechnologies.com/blog/index.php/highlighting-outliers-in-your-data-with-the-tukey-method/
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
# Detect a univariate outlier in "aptit" by visul inspection of values   (0.5 points)


# what is the id of the person with a potential outlier?  (0.5 points)




# Are there outlier according to Tukey's filter?  (0.5 points)



#### Historgrapm: Intelligence ####
# Detect a univariate outlier in "aptit" by visul inspection of values   (0.5 points)


# what is the id of the person with a potential outlier?  (0.5 points)



# Are there outlier according to Tukey's filter?  (0.5 points)


#### Historgrapm: Attention ####
# Detect a univariate outlier in "atten" by visul inspection of values  (0.5 points)


# what is the id of the person with a potential outlier?  (0.5 points)

 
# Are there outlier according to Tukey's filter?  (0.5 points)



#### Multivariate outliers #### 

# create an indicator of multivariate outliers
means <- # create a vector of mean using colMeans function  (0.5 points)
means
covar <- # create a matrix of correlation using cor function  (0.5 points)
covar

ds$mahal <- # create a column storing mahalanobis distance using mahalanobis function  (0.5 points)
ds <- # order by descreasing "mahal"
ds 

# create a rule for classifying a multivariate outlier based on the mahal value of 10
ds[,"out"] <-   #  (0.5 points)
ds

# how many observation should be classified as outliers according to mahalanobis distance if 10 is the cutting point?  (0.5 points)


# create a rule for classifying a multivariate outlier based on the chi-square table
ds[,"out"] <-   #  (0.5 points)
  ds

# how many observation should be classified as outliers according to mahalanobis distance if 10 is the cutting point?  (0.5 points)


# how many observation should be classified as outliers according to mahalanobis distance based on the chi-square table?  (0.5 points)


# create a scatter plot in which mahalanobis values are both on the X- and Y-axes.  (0.5 points)



# How many observation should be classified as multivariate outliers according to the visual inspection of the mahal by mahal scatterplot?  (0.5 points)



# Observation of which Ids would you recommend for elementwise deletion?  (0.5 points) 




####  Remove outliers ####

# remove from the dataset the rows for individuals with ids you recommended above
out <-  # create a vector containing the values of id the should be removed   (0.5 points)
dsNew <- # create a new data set without the values in "out" object. Hint: use %in% operator. Another hist: the entire statement must be negated  (0.5 points)


#### Effect of removing outliers ####

# using GGallpy::ggpairs examing the effect of removing the recommended outliers on the correlations withing dataset (0.5 points + 0.5 points).



# linear relationships between what variables disappear after removing outliers?  (0.5 points)



# linear relationships between what variables is affected the least by removing the outliers? compare the correlation matrices before an after removing outliers  (0.5 points)








