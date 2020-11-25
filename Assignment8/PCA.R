library(datasets)
data(iris)

#Taking the numeric part of the IRIS data
data_iris <- iris[1:4]
#Calculating the covariance matrix
Cov_data <- cov(data_iris)
#Find out the eigen vectors and eigen values using the covariance matrix
Eigen_data <- eigen(Cov_data)
#using the inbuilt function
PCA_data <- princomp(data_iris,cor = "False")

#Let's now compare the output variances
Eigen_data$values
PCA_data$sdev^2
PCA_data$loadings[,1:4]
Eigen_data$vectors
summary(PCA_data)
biplot(PCA_data)
screeplot(PCA_data,type = "lines")

#Select the first principal component for the second model
model2 = PCA_data$loadings[,1]
#For the second model, we need to calculate scores by multiplying our loadings with the data
model2_scores <- as.matrix(data_iris) %*% model2

#Loading libraries for naiveBayes model
library(class)
library(e1071)

#Fitting the first model over the entire data
mod1 <- naiveBayes(iris[,1:4],iris[,5])
#Fitting the second model using the first principal component
mod2 <- naiveBayes(model2_scores,iris[,5])

# Accuracy for the first model
table(predict(mod1,iris[,1:4]),iris[,5])
# Accuracy for the second model
table(predict(mod2,model2_scores),iris[,5])