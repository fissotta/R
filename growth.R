# install.packages("growthcurver")
# install.packages("reshape2")
library(dplyr)
library(reshape2)
library(ggplot2)
library(growthcurver)
library(purrr)


######################
# Dataset ejemplo OD #
######################

df <- growthdata

ggplot(df, aes(x = time, y = A1)) + geom_point(alpha=0.7)

df <- df %>% filter(time<=40)
model.A1 <- SummarizeGrowth(df$time, df$A1)

model.A1$vals # gives you all the values (the growth rate etc. See the Growthcurver manual for more info)

predict(model.A1$model) # gives you the predicted OD values (according to the model)

growth.values.plate <- SummarizeGrowthByPlate(df)
write.csv2(growth.values.plate, file="growth-values-plate.tab")

plot(model.A1)

p1 <- ggplot(df, aes(x=time,y=A1)) + geom_point(alpha=0.5) + theme_bw()
p1

df.predicted <- data.frame(time = df$time, pred.A1 = predict(model.A1$model))
p1 + geom_line(data=df.predicted, aes(y=pred.A1), color="red")


summG <- function(x) {SummarizeGrowth(df$time,x)}
lapply(df[2:ncol(df)], summG)

models.all <- lapply(df[2:ncol(df)], function(x) SummarizeGrowth(df$time, x))

df.predicted.plate <- data.frame(time = df$time)
for (i in names(df[2:ncol(df)])) 
{df.predicted.plate[[i]] <- predict(models.all[[i]]$model)}

models.all <- lapply(df[2:ncol(df)], function(x) SummarizeGrowth(df[!is.na(x), 1], x[!is.na(x)]))
df.predicted.plate <- data.frame(time = df$time)
for (i in names(df[2:ncol(df)])) 
{df.predicted.plate[[i]] <- predict(models.all[[i]]$model, newdata = list(t = df$time))}

melt1 <- melt(df, id.vars = "time", variable.name = "sample", value.name = "od")
melt2 <- melt(df.predicted.plate, id.vars = "time", variable.name = "sample", value.name = "pred.od")
df.final <- cbind(melt1, pred.od=melt2[,3])
rm(melt1)
rm(melt2)

ggplot(df.final, aes(x=time, y=od)) + geom_point(aes(), alpha=0.5) + geom_line(aes(y=pred.od), color="red") + facet_wrap(~sample, ncol = 12) + theme_bw()



##############################
# Dataset ejemplo cell count #
##############################


df <- read.table(file.choose(), header = TRUE, sep = ";", dec = ".", check.names = TRUE)

ggplot(df, aes(x = time, y = X20C_pH1)) + geom_point(alpha=0.7)

# df <- df %>% filter(time<100)
model.X20C_pH1 <- SummarizeGrowth(df$time, df$X20C_pH1)

model.X20C_pH1$vals # gives you all the values (the growth rate etc. See the Growthcurver manual for more info)

predict(model.X20C_pH1$model) # gives you the predicted OD values (according to the model)

plot(model.X20C_pH1)
model.X20C_pH1

summG <- function(x) {SummarizeGrowth(df$time,x)}
lapply(df[2:ncol(df)], summG)

models.all <- lapply(df[2:ncol(df)], function(x) SummarizeGrowth(df$time, x))

j=1
for(i in models.all){
    j = j+1
    plot(i, main=colnames(df)[j])}


