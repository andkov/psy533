rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
######### Set Up Working Directory!!
library(Hmisc)
library(sem)
library(corrgram)
source('http://www.statpower.net/Content/312/R Stuff/AdvancedFactorFunctionsV1.04.r')
AthleticsData <- read.csv(file.path(getwd(),"R Support Materials/datasets","AthleticsData.csv"))
attach(AthleticsData)

AD.R <- cor(AthleticsData)
round(cor(AthleticsData),2)
corrgram(x=AD.R,order=TRUE,
         main="Correlogram of Athletic Data",
         upper.panel=panel.pie,
         lower.panel=panel.shade
)

# short- and long-hand code of QuickCFA
pureCFA.fit <- QuickCFA(AD.R,3,1000, "AD_QuickCFA", c("Hand-Eye","Endurance","Strength"))
# QuickCFA(R=AD.R,n.factors=3,n.obs=1000, model.name="AD_QuickCFA",
#          factor.names=c("Hand-Eye","Endurance","Strength"),
#          cutoff=0.30, factor.correlations=FALSE,reference.indicators=FALSE)

summary(pureCFA.fit)
GetPattern(pureCFA.fit)

GetPrettyPattern(pureCFA.fit)
RMSEA(pureCFA.fit)
CheckMod(pureCFA.fit)
fit2 <- UseMod(pureCFA.fit)
CheckMod(fit2)
fit3 <- UseMod(fit2)
RMSEA(fit3)
GetPrettyPattern(fit3)

fit <- QuickEFAtoCFA(AD.R,3,1000)
GetPrettyPattern(fit)
fit <- QuickEFAtoCFA(AD.R,3,1000, cov.matrix=FALSE)
GetPrettyPattern(fit)

CheckMod(fit)
fit <- UseMod(fit)
GetPrettyPattern(fit)

R <- as.matrix(Harman74.cor$cov)
fit <- QuickJoreskog(R,4,145)
GetPrettyPattern(fit)

debug(QuickJoreskog)
