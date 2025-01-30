# Data visualiziation from a .CSV excel file in the specific hard disk folder


# Load necessary libraries
library(ggplot2)

# Read the data from a CSV file
# setwd('C:\\Users\\mbzad\\Downloads\\')
data <- read.csv ('C:\\Users\\mbzad\\Downloads\\PnC.csv')

# Display the first few rows of the dataset to understand its structure
print(head(data))



plot <- ggplot(data, aes(x = hrsWorked ,y = ICID)) + 
  geom_point(color = 'blue', size = 2) +  # Scatter plot with blue points
  geom_smooth(method = 'lm', color = 'red', se = FALSE) +  # Add a linear regression line
  theme_minimal() +  # Apply a minimal theme
  labs(title = "Data Visualization", x = "HrsWorked", y = "ICID")  # Customize labels

# Display the plot
print(plot)
