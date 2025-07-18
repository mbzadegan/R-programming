# Here's an example of R code tackling a challenging AI problem: "Training a neural network to classify handwritten digits using the MNIST dataset" 
# This problem is a classic in AI and machine learning.
# We will use the keras package in R, which provides an interface to TensorFlow, a powerful AI framework.
# Install TensorFlow and Keras for R please run:
# install_keras()


# Install and load necessary libraries
if (!requireNamespace("keras")) install.packages("keras")
library(keras)

# Load the MNIST dataset
mnist <- dataset_mnist()

# Preprocess the data
x_train <- mnist$train$x / 255  # Normalize pixel values
x_test <- mnist$test$x / 255

# Reshape the data to fit the input shape of the neural network
x_train <- array_reshape(x_train, c(nrow(x_train), 28, 28, 1))
x_test <- array_reshape(x_test, c(nrow(x_test), 28, 28, 1))

# One-hot encode the labels
y_train <- to_categorical(mnist$train$y, 10)
y_test <- to_categorical(mnist$test$y, 10)

# Build the neural network model
model <- keras_model_sequential() %>%
  layer_conv_2d(filters = 32, kernel_size = c(3, 3), activation = 'relu',
                input_shape = c(28, 28, 1)) %>%
  layer_max_pooling_2d(pool_size = c(2, 2)) %>%
  layer_dropout(rate = 0.25) %>%
  layer_flatten() %>%
  layer_dense(units = 128, activation = 'relu') %>%
  layer_dropout(rate = 0.5) %>%
  layer_dense(units = 10, activation = 'softmax')

# Compile the model
model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = optimizer_adam(),
  metrics = c('accuracy')
)

# Train the model
history <- model %>% fit(
  x_train, y_train,
  epochs = 10,
  batch_size = 128,
  validation_split = 0.2
)

# Evaluate the model
score <- model %>% evaluate(x_test, y_test)
cat("Test loss:", score$loss, "\n")
cat("Test accuracy:", score$accuracy, "\n")

# Make predictions
predictions <- model %>% predict_classes(x_test[1:10, , , ])

# Display the first 10 predictions with their corresponding images
par(mfrow = c(2, 5))
for (i in 1:10) {
  image(x_test[i, , , 1], col = gray.colors(256), main = paste("Pred:", predictions[i]))
}
