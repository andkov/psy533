# remove all elements for a clean start
rm(list=ls(all=TRUE))
cat("\014")

# install.packages(c("Hmisc","sem","ggplot2","colorspace","corrgram","plotrix","psych"))

library(Hmisc)
library(psych)
library(colorspace)
library(corrgram)
library(ggplot2)
library(reshape2)
library(ggvis)
library(GGally)

AthleticsData <- read.csv("./Cases/CFA with R/AthleticsData.csv")

dsA <- AthleticsData

g <- ggplot(dsA,aes(x=PINBALL,y=BILLIARD))
g <- g + geom_point()
g

rownames(dsA)
ds <- melt(dsA,id.vars=rownames(dsA),variable.name="sport", value.name="performance")

g <- ggplot(dsA, aes(x=))

plotmatrix(ds)

dsHappy <- happy


GGally::ggpairs(ds)
head(iris)
GGally::ggpairs(iris, color="Species")

names(dsA) 
head(dsA)

mtcars %>% 
  ggvis(~wt, ~mpg, 
        size := input_slider(10, 100),
        opacity := input_slider(0, 1)
  ) %>% 
  layer_points()

data(package="psych")

ds <- psych::sat.act
head(sat.act)
# GGally::ggpairs(ds[,c("ACT", "SATV","SATQ")])

# GGally::ggpairs(ds)
ds$genderF <- factor(ds$gender, levels=c(1,2), labels=c("Male","Female"))
GGally::ggpairs(ds, color="genderF")


ds[ ,c("ACT", "SATV","SATQ")]

ds[,"ACT"]