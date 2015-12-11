<pre><div class="text_to_html">#### SETUP ####
rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
options("scipen"=10, "digits"=3) # control the decimal places in the output

# Install packages if necessary
# install.packages("psych")  
# install.packages("corrgram") 
# install.packages("Hmisc")
# install.packages("sem")
# install.packages("reshape2")
# install.packages("ggplot2")
# install.packages("plotrix")

## load the packages
library(psych) # multipurpose for psychologist
library(corrgram) # for graphing correlation matrices
library(Hmisc)# multipurpose
library(sem) # structural equation modeling
library(reshape2) # data transformation
library(ggplot2) # general graphing
library(plotrix) # ploting matrix graphs

# Please consult the website of James Steiger (<a href="http://www.statpower.net" class="_blanktarget">www.statpower.net</a>) for all materials pertaining to this demonstration. ( See Psychology 312)

## load some custom functions
# Useful function for multivariate stats
source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")
# Functions to assist you in FA and SEM
source("http://statpower.net/Content/312/R%20Stuff/AdvancedFactorFunctions.txt")
# Functions by Dirk Enzmann to aid promax rotation
source("http://statpower.net/Content/312/R%20Stuff/fa.promax.R")


pathHome <- getwd()
pathFile <- file.path(pathHome,"Homework/LongPerkinsTime1SCI.csv")

#### Data prep ####

ds <- read.table(pathFile, sep=",", header=T) # read in the data
head(ds) # print the first few lines
str(ds) # examine the structure of the object
dim(ds)
nrow(ds)


#convert variables back into numeri
for(i in  colnames(ds)){
  ds[,i]<- as.numeric(ds[,i])
}


# subset the data to keep only the rows without any missing values
ds <- na.omit(ds)
ds


##  Data originated from the following questionnaire :
# I am going to read some things that people might say about their block. Each time I read one of these
# statements, please tell me if it is mostly true or mostly false about your block simply by saying "true" (2=MORE SOC) or "false" (1=LESS SOC).

# SCI1 - I think my block is a good place for me to live.
# SCI2 - People on this block do not share the same values. (reverse)
# SCI3 - My neighbors and I want the same things from the block.
# SCI4 - I can recognize most of the people who live on my block.
# SCI5 - I feel at home on this block.
# SCI6 - Very few of my neighbors know me. (reverse)
# SCI7 - I care about what my neighbors think of my actions.
# SCI8 - I have almost no influence over what this block is like. (reverse)
# SCI9 - If there is a problem on this block people who live here can get it solved.
# SCI10 - It is very important to me to live on this particular block.
# SCI11 - People on this block generally don't get along with each other. (reverse)
# SCI12 - I expect to live on this block for a long time.
#
# NOTE: Items 2,6,8,11 are reverse coded! This means that the loading on this item may
# be negative on the designated factor.

# assigning descriptive names to the variables
# varNames <- c(“varname1", "varname2", ... , "varname12")  # To edit if you want more meaningful variable names   

usevars <- c("SCI1", "SCI2", "SCI4", "SCI5", "SCI6", "SCI8", "SCI9", "SCI10", "SCI11", "SCI12")
dsR <- ds[usevars]
#### Examine correlations ####

# compute correlation matrix (.5)
S <- cov(dsR)

# Print the correlation matrix (.5)
S

# print a correlogram of the correlation matrix using corrgram() function of the corrgram package, use default options (.5)
#corrgram(R)

# customize the correlogram so that the lower triangle gives pie graphs and upper triangle shows the numerical values for the correlation (.5)

corrgram(R, upper.panel=panel.conf, lower.panel=panel.pie)

# further customize the correlogram so that variable are ordered according to the PCA logic  (.5)

corrgram(R, upper.panel=panel.conf, lower.panel=panel.pie, order = TRUE)


sci1.model <- specifyModel("SCI1.txt")
sci1.fit <- sem(sci1.model, S, 575)
summary(sci1.fit)
