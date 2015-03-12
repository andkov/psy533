
- Goodness of fit
- Relative fit
- Significance of parameter estimates (Wald test)
- Nested models and difference chi-square test

- Modification indices

- Df = p(p+1)/2



-  specifically mention the fact that the coefficient from e to y is fixed to 1. It is easy to forget that when you see “+ e” in an equation that it actually means “ + 1e”.

-  describe explicitly the sem syntax: <Relation>, <Parameter… etc.

-	explain that NA asks the computer to use an automatic start value, but that the user can select a specific one 




opt <- options(fit.indices= c("GFI","RMSEA"))

# opt <- options(fit.indices = c("GFI", "AGFI", "RMSEA", "NFI", "NNFI",
#                                "CFI", "RNI", "IFI", "SRMR", "AIC", "AICc", "BIC", "CAIC"))
standardizedCoefficients(cfa1.fit)

cfa1.model <- specifyModel("./Cases/CFA with R/Class Demo/CFA1.txt")
cfa1.fit <- sem(cfa1.model, R, 1000, opt)
summary(cfa1.fit, opt)
modIndices(cfa1.fit)



cfa2.model <- specifyModel("./Cases/CFA with R/Class Demo/CFA2.txt")
cfa2.fit <- sem(cfa2.model, R, 1000)
summary(cfa2.fit)
modIndices(cfa2.fit)

cfa3.model <- specifyModel("./Cases/CFA with R/Class Demo/CFA3.txt")
cfa3.fit <- sem(cfa3.model, R, 1000)
summary(cfa3.fit)
modIndices(cfa3.fit)

cfa4.model <- specifyModel("./Cases/CFA with R/Class Demo/CFA4.txt")
cfa4.fit <- sem(cfa4.model, R, 1000)
summary(cfa4.fit)
modIndices(cfa4.fit)
