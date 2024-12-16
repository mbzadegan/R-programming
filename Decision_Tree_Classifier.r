# Here’s a sample R program to solve a machine learning problem using a decision tree to classify data. 


# Install necessary packages
if (!require("rpart")) install.packages("rpart", dependencies = TRUE)
if (!require("rpart.plot")) install.packages("rpart.plot", dependencies = TRUE)

# Load libraries
library(rpart)
library(rpart.plot)

# Load the dataset
data(iris)

# Preview the data
print(head(iris))

# Split the dataset into training and testing sets
set.seed(123)  # Set seed for reproducibility
train_indices <- sample(1:nrow(iris), size = 0.7 * nrow(iris))  # 70% training data
train_data <- iris[train_indices, ]
test_data <- iris[-train_indices, ]

# Create a decision tree model
tree_model <- rpart(Species ~ ., data = train_data, method = "class")

# Plot the decision tree
rpart.plot(tree_model, main = "Decision Tree for Iris Dataset")

# Make predictions on the test dataset
predictions <- predict(tree_model, test_data, type = "class")

# Evaluate the model's performance
conf_matrix <- table(Predicted = predictions, Actual = test_data$Species)
print("Confusion Matrix:")
print(conf_matrix)

# Calculate accuracy
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
cat("Accuracy of the Decision Tree Model:", round(accuracy * 100, 2), "%\n")
