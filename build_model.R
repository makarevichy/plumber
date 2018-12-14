# run this script
library(randomForest)
library(MASS)
library(recipes)
data('Boston')
head(Boston)
nam <- c('medv', 'tax', 'age', 'crim')
df <- Boston[,nam]
rec <- recipe(medv~., data = df) %>% 
  step_center(all_predictors()) %>% 
  step_scale(all_predictors())
pre <- prep(rec, training = df)
df <- bake(pre, df)
model <- randomForest(medv~., data = df, ntree=100)
saveRDS(pre, 'pre.rds') #for pre-processing new data
saveRDS(model, 'rf_model.rds') #for predict

# Start plumber API
pl <- plumber::plumb('boston_rf_score.R')
pl$run(port = 8000)

