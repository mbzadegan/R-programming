# To clean a data frame in R, the process typically involves several steps such as removing missing values, handling duplicates, converting data types, renaming columns, and normalizing values.
# Below is an R program that demonstrates a basic approach to clean a data frame:



# Load required libraries
library(dplyr)
library(tidyr)

# Example data frame
data <- data.frame(
  ID = c(1, 2, 3, NA, 5, 5),
  Name = c("Alice", "Bob", "Charlie", "David", "Eve", "Eve"),
  Age = c(25, 30, 35, NA, 45, 45),
  Salary = c(50000, 60000, 55000, 70000, NA, 55000),
  stringsAsFactors = FALSE
)

# View original data
print("Original Data:")
print(data)

# Clean the data
cleaned_data <- data %>%
  
  # Remove duplicate rows based on all columns
  distinct() %>%
  
  # Handle missing values - Remove rows with NA in any column
  drop_na() %>%
  
  # Alternatively, replace NA values with specific values (e.g., 0 for numeric columns)
  # mutate(Salary = ifelse(is.na(Salary), 0, Salary)) %>%
  
  # Convert columns to the appropriate data types if necessary
  mutate(
    Age = as.integer(Age),
    Salary = as.numeric(Salary)
  ) %>%
  
  # Rename columns to make them more readable (optional)
  rename(
    Employee_ID = ID,
    Employee_Name = Name,
    Employee_Age = Age,
    Employee_Salary = Salary
  )

# View cleaned data
print("Cleaned Data:")
print(cleaned_data)
