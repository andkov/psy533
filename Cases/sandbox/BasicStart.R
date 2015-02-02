# remove all elements for a clean start
rm(list=ls(all=TRUE))
cat("\014")

# install.packages(c("Hmisc","sem","ggplot2","colorspace","corrgram","plotrix","psych"))

library(Hmisc)
library(psych)
library(colorspace)
library(corrgram)
library(gcookbook)
data()

AthleticsData <- read.csv("./Cases/CFA with R/AthleticsData.csv")

dsA <- AthleticsData
names(dsA) 
head(dsA)
dsCA <- psych::Harman.Holzinger # Cognitive Abilities
dsET <- psych::Harman.Burt # Emotional Traits
dsPM <- psych::Harman.8 # Physical Measures



head(dsCA)



