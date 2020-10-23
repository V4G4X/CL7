library(Metrics) 
library(DAAG)

# Get the data set
data_set <- read.csv("Advertising.csv", header=TRUE)

# Summary of the data set
summary(data_set)

print(nrow(data_set))
print(ncol(data_set))

# Drop index column
data_set <- data_set[c(2:8)]

colnames(data_set)

#Rename columns
names(data_set)[1] <- "Transaction_Date"
names(data_set)[2] <- "Age"
names(data_set)[3] <- "Distance"
names(data_set)[4] <- "Convenience_Stores"
names(data_set)[5] <- "Latitude"
names(data_set)[6] <- "Longitude"
names(data_set)[7] <- "Price"

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

lr_age <- lm(Price~Age, data=train)
summary(lr_age)

lr_dist <- lm(Price~Distance, data=train)
summary(lr_dist)

lr_conv <- lm(Price~Convenience_Stores, data=train)
summary(lr_conv)

lr_lat <- lm(Price~Latitude, data=train)
summary(lr_lat)

lr_long <- lm(Price~Longitude, data=train)
summary(lr_long)

# PLOT GRAPH FOR RELATIONSHIP BETWEEN FEATURES AND TARGET

plot(train$Price~train$Age, xlab="Age", ylab ="Price")
abline(lr_age)

plot(train$Price~train$Distance, xlab="Distance", ylab ="Price")
abline(lr_dist)

plot(train$Price~train$Convenience_Stores, xlab="Convenience_Stores", ylab ="Price")
abline(lr_conv)

plot(train$Price~train$Latitude, xlab="Latitude", ylab ="Price")
abline(lr_lat)

plot(train$Price~train$Longitude, xlab="Longitude", ylab ="Price")
abline(lr_long)


# Calculate MSE for distance
lr_dist_1 <- lm(Price~log(Distance), data=train)
View(lr_dist_1)

# Prediction on train
lr_train_1 <- predict(lr_dist_1, train)
lr_train_1

# Prediction on test
lr_pred_1 <- predict(lr_dist_1, test)
lr_pred_1

# Calculate MSE 
train_mse_1 = mse(train$Price, lr_train_1)
print(train_mse_1)

test_mse_1 = mse(test$Price, lr_pred_1)
print(test_mse_1)

# Graph of test vs train mse
plotter <- c(train_mse_1, test_mse_1)
barplot(plotter, width = 0.02, xlab="data", names.arg = c("Train MSE","Test MSE"), ylab="error", main="Error (dist price)")

# Correlation (Subset Selection Method)
res <- cor(train)
print(res)

lin_gen <- lm(Price~Convenience_Stores+Latitude+Longitude, data=train)
print(lin_gen)

# Prediction on train
lin_train <- predict(lin_gen, train)
lin_train

# Prediction on test
lin_pred <- predict(lin_gen, test)
lin_pred

# Calculate MSE on subset
train_mse = mse(train$Price, lin_train)
print(train_mse)

test_mse = mse(test$Price, lin_pred)
print(test_mse)

# Graph of test vs train mse for subset
plotter <- c(train_mse, test_mse)
barplot(plotter, width = 0.02, xlab="data", names.arg = c("Train MSE","Test MSE"), ylab="error", main="Error (Subset)")

# K fold cross validation
model = cv.lm(df, (Price~Convenience_Stores+Latitude+Longitude), m=5)
