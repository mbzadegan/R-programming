# code example in R that solves a challenging time-series forecasting problem using a long short-term memory (LSTM) neural network. This approach is particularly useful for analyzing and forecasting complex time-series data, such as stock prices or climate patterns, where traditional statistical models may fail.


# Install required libraries
if (!require("keras")) install.packages("keras")
if (!require("tibble")) install.packages("tibble")
if (!require("tidyverse")) install.packages("tidyverse")

library(keras)
library(tibble)
library(tidyverse)

# Step 1: Simulate a time-series dataset (e.g., sine wave + noise)
set.seed(123)
n <- 1000
time_series <- tibble(
  time = 1:n,
  value = sin(1:n * 0.02) + rnorm(n, sd = 0.2) # Sine wave with noise
)

# Step 2: Prepare the data for LSTM
lag_transform <- function(data, lag = 1) {
  cbind(value = data[(lag + 1):length(data)], lagged_value = data[1:(length(data) - lag)])
}

# Lagged data (supervised learning format)
lagged_data <- lag_transform(time_series$value, lag = 10)
lagged_data <- as.data.frame(lagged_data)
colnames(lagged_data) <- c("value", paste0("lag_", 1:10))

# Split into train and test sets
train_size <- floor(0.8 * nrow(lagged_data))
train_data <- lagged_data[1:train_size, ]
test_data <- lagged_data[(train_size + 1):nrow(lagged_data), ]

# Scale the data for neural network compatibility
train_data_scaled <- scale(train_data)
test_data_scaled <- scale(test_data, center = attr(train_data_scaled, "scaled:center"), 
                           scale = attr(train_data_scaled, "scaled:scale"))

# Reshape data into 3D array for LSTM
x_train <- array(as.matrix(train_data_scaled[, -1]), dim = c(nrow(train_data_scaled), 10, 1))
y_train <- train_data_scaled[, 1]
x_test <- array(as.matrix(test_data_scaled[, -1]), dim = c(nrow(test_data_scaled), 10, 1))
y_test <- test_data_scaled[, 1]

# Step 3: Build the LSTM model
model <- keras_model_sequential() %>%
  layer_lstm(units = 50, input_shape = c(10, 1), return_sequences = FALSE) %>%
  layer_dense(units = 1)

# Compile the model
model %>% compile(
  loss = "mean_squared_error",
  optimizer = "adam"
)

# Train the model
history <- model %>% fit(
  x_train, y_train,
  epochs = 50,
  batch_size = 32,
  validation_split = 0.2,
  verbose = 1
)

# Step 4: Make predictions
predictions <- model %>% predict(x_test)

# Inverse scale the predictions for interpretation
predictions <- predictions * attr(train_data_scaled, "scaled:scale")[1] + 
  attr(train_data_scaled, "scaled:center")[1]
actual_values <- test_data$value

# Step 5: Evaluate and visualize the results
# Calculate Mean Squared Error
mse <- mean((predictions - actual_values)^2)
cat("Mean Squared Error:", mse, "\n")

# Plot actual vs. predicted values
plot(actual_values, type = "l", col = "blue", lwd = 2, ylab = "Value", xlab = "Time", 
     main = "Actual vs. Predicted")
lines(predictions, col = "red", lwd = 2)
legend("topright", legend = c("Actual", "Predicted"), col = c("blue", "red"), lty = 1, lwd = 2)

