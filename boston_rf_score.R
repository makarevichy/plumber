bos_rf <- readRDS("rf_model.rds") #load rf model
pre <- readRDS('pre.rds') # load recipes
#load libraries
library(randomForest)
library(recipes)

#* @param df data frame of variables
#* @get /score
function(tax, age, crim)
{
  df <- data.frame(tax = as.numeric(tax), age = as.numeric(age), crim = as.numeric(crim))
  df <- bake(pre, new_data = df)
  list(predict(bos_rf, df), df$tax, df$age, df$crim)
}