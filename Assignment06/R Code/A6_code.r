library(Metrics) 
library(DAAG)

# Get the data set
data_set <- read.csv("Advertising.csv", header=TRUE)

# Summary of the data set
summary(data_set)

print(nrow(data_set))
print(ncol(data_set))

# Drop index column
data_set <- data_set[c(2:5)]

colnames(data_set)

# SPLIT DATA SET INTO TRAINING AND TESTING

# 80% of the sample size
ind_split <- floor(0.80 * nrow(data_set))

# Set seed to make your partition reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(data_set)), size = ind_split)

train <- data_set[train_ind, ]
test <- data_set[-train_ind, ]

View(train)
View(test)

# LINEAR REGRESSION

lr_age <- lm(Sales~TV, data=train)
summary(lr_age)

lr_dist <- lm(Sales~Radio, data=train)
summary(lr_dist)

lr_conv <- lm(Sales~Newspaper, data=train)
summary(lr_conv)

# PLOT GRAPH FOR RELATIONSHIP BETWEEN FEATURES AND TARGET

plot(train$Sales~train$TV, xlab="TV", ylab ="Sales")
abline(lr_age)

plot(train$Sales~train$Radio, xlab="Radio", ylab ="Sales")
abline(lr_dist)

plot(train$Sales~train$Newspaper, xlab="Newspaper", ylab ="Sales")
abline(lr_conv)

# Calculate MSE for distance
lr_dist_1 <- lm(Sales~log(TV), data=train)
View(lr_dist_1)

# Prediction on train
lr_train_1 <- predict(lr_dist_1, train)
lr_train_1

# Prediction on test
lr_pred_1 <- predict(lr_dist_1, test)
lr_pred_1

# Calculate MSE 
train_mse_1 = mse(train$Sales, lr_train_1)
print(train_mse_1)

test_mse_1 = mse(test$Sales, lr_pred_1)
print(test_mse_1)

# Graph of test vs train mse
plotter <- c(train_mse_1, test_mse_1)
barplot(plotter, width = 0.02, xlab="data", names.arg = c("Train MSE","Test MSE"), ylab="error", main="Error (TV Sales)")

# Correlation (Subset Selection Method)
res <- cor(train)
print(res)

lin_gen <- lm(Sales~TV+Radio+Newspaper, data=train)
print(lin_gen)

# Prediction on train
lin_train <- predict(lin_gen, train)
lin_train

# Prediction on test
lin_pred <- predict(lin_gen, test)
lin_pred

# Calculate MSE on subset
train_mse = mse(train$Sales, lin_train)
print(train_mse)

test_mse = mse(test$Sales, lin_pred)
print(test_mse)

# Graph of test vs train mse for subset
plotter <- c(train_mse, test_mse)
barplot(plotter, width = 0.02, xlab="data", names.arg = c("Train MSE","Test MSE"), ylab="error", main="Error (Subset)")

# K fold cross validation
model = cv.lm(data_set, (Sales~TV+Radio+Newspaper), m=5)

