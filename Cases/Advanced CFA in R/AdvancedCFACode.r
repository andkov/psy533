rm(list=ls(all=TRUE)) #Clear out variables from previous runs.
######### Set Up Working Directory!!
library(Hmisc)
library(sem)
source("http://statpower.net/Content/312/R%20Stuff/AdvancedFactorFunctions.txt")
AthleticsData <- spss.get("AthleticsData.sav")
attach(AthleticsData)
AD.R <- cor(AthleticsData)
pureCFA.fit <- QuickCFA(AD.R,3,1000,"pureCFA",
                        c("HandEye","Endurance","Strength"))
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
