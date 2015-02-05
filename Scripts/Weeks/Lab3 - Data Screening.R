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

## @knitr DummyChunck
#### ds0 ####

## @knitr LoadDataInitial
pathDir <- getwd() # establish home directory
pathDs<- file.path(pathDir,"Data/AMA/ch3ex1.dat")


# record variable names from MPlus script 
namesDs<- c( 'id','Exam_Score', 'Aptitude_Measure', 'Age_in_Years',
             'Intelligence_Score', 'Attention_Span') 

# ds <- read.table(pathDs,col.names = namesDs)
ds <- read.table(pathDs,header = TRUE)



## @knitr RenameVariables
ds <- plyr::rename(ds, replace=c("Exam_Score"="score",
                                 'Aptitude_Measure' = "aptit",
                                 'Age_in_Years' = "age",
                                 'Intelligence_Score' = "intel",
                                 'Attention_Span' = "atten"))


# ## @knitr Pairs0
# GGally::ggpairs(ds,columns = 2:ncol(ds))

# ## @knitr BasicTables
attach(ds)
table(aptit,score)
detach(ds)

# ## Finding Score outlier
head(ds)
ds <- ds[order(ds$score),]
head(ds)

ds <- ds[order(ds$score,decreasing=T),]
head(ds)


# ## Remove entire case
# ds <- ds[ds$score!=152,]
# head(ds)

## Replace outlier with missing
# ds$score[ds$score==152] <- NA
head(ds)

 
# ## @knitr Pairs1
# GGally::ggpairs(ds,columns = 2:ncol(ds))
 

## Finding Aptitude outlier
head(ds)
ds <- ds[order(ds$aptit,decreasing=T),]
head(ds)

## Replace outlier with missing
# ds$aptit[ds$aptit==44] <- NA
head(ds)

# GGally::ggpairs(ds,columns = 2:ncol(ds))





# create an indicator of multivariate outliers
means <- colMeans(ds[,2:ncol(ds)])
means
covar <- cov(ds[,2:ncol(ds)])
covar

ds$mahal <- mahalanobis(ds[,2:ncol(ds)], means, covar)
ds <- ds[order(ds$mahal,decreasing=T),]
ds

ds[,"out"] <- ifelse(ds[,"mahal"]>=10 , 1, 0)
ds

dsNew <- ds[ds$out==0,]

# GGally::ggpairs(dsNew,columns = 2:5)


## @knitr DummyChunck
### Basic Graphs  ####

## @knitr LoadGraphThemes
baseSize <- 12 # set as the point of further reference
theme1 <- ggplot2::theme_bw(base_size=baseSize) +
  ggplot2::theme(title=ggplot2::element_text(colour="gray20",size = baseSize+1)) +
  ggplot2::theme(axis.text=ggplot2::element_text(colour="gray40", size=baseSize-2)) +
  ggplot2::theme(axis.title=ggplot2::element_text(colour="gray40")) +
  ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80")) +
  ggplot2::theme(axis.ticks.length = grid::unit(0, "cm")) +
  ggplot2::theme(text = element_text(size =baseSize+7)) 



#### Historgrapm ####
g <- ggplot2::ggplot(ds, aes(x=score))
g <- g + geom_bar()
g

#### Historgrapm, no OUT ####
g <- ggplot2::ggplot(dsNew, aes(x=score))
g <- g + geom_bar()
g


#### Scatterplot ####
g <- ggplot(ds, aes(x=score,y=intel))
g <- g + geom_point()
g

#### Scatterplot, no OUT ####
g <- ggplot(dsNew, aes(x=score,y=intel))
g <- g + geom_point()
g

#### Violins ####
dsL <- reshape2::melt(ds[,1:6],id.vars="id", variable.name="measure" )
str(dsL)
head(dsL)
g <- ggplot2::ggplot(dsL, aes(x=measure,y=value))
g <- g + geom_violin( adjust=1, alpha=.4, fill="red" )
g <- g + geom_boxplot(width=.5, fill=NA, color="black", alpha=.5, outlier.colour="red")
g <- g + stat_summary(fun.y=mean, geom="point", fill="white", shape=21, size=4)
g


#### Violins, standardized ####
dsNewZ <- as.data.frame(scale(dsNew))
dsL <- reshape2::melt(dsNewZ[,1:6],id.vars="id", variable.name="measure" )
str(dsL)
head(dsL)
g <- ggplot2::ggplot(dsL, aes(x=measure,y=value))
g <- g + geom_violin( adjust=1, alpha=.4, fill="red" )
g <- g + geom_boxplot(width=.5, fill=NA, color="black", alpha=.5, outlier.colour="red")
g <- g + stat_summary(fun.y=mean, geom="point", fill="white", shape=21, size=4)
g





