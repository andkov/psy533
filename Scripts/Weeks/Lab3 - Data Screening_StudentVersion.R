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
pathDs<- file.path(pathDir,"ch3ex1.dat")


## import the data
ds <- read.table(pathDs,header = TRUE)



## @knitr RenameVariables
ds <- plyr::rename(ds, replace=c(



# ## @knitr Pairs0
# GGally::ggpairs(ds,columns = 2:ncol(ds))

## @knitr BasicTables



## Finding Score outlier ds[order(ds$var),]



 
## @knitr Pairs1

 

## Finding Aptitude outlier


# GGally::ggpairs(ds,columns = 2:ncol(ds))






# create an indicator of multivariate outliers

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



#### Historgrapm, no OUT ####



#### Scatterplot ####



#### Scatterplot, no OUT ####



#### Violins ####



#### Violins, standardized ####






