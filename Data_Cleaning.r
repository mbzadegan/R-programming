# Here is R program to automate data cleaning. It includes various steps like handling missing values, removing duplicates, normalizing column names, detecting and handling outliers, and standardizing formats. You can modify the parameters based on your dataset.


# Load necessary libraries
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)

# Function to automate data cleaning
clean_data <- function(df) {
  cat("Starting data cleaning...\n")
  
  # 1. Normalize column names
  df <- df %>%
    rename_with(~ str_to_lower(.) %>%
                  str_replace_all("[^[:alnum:]_]", "_") %>%
                  str_replace_all("__+", "_"))
  cat("Step 1: Column names normalized.\n")
  
  # 2. Remove duplicate rows
  df <- df %>%
    distinct()
  cat("Step 2: Duplicate rows removed.\n")
  
  # 3. Handle missing values
  #    Drop columns with more than 50% missing
  threshold <- 0.5
  df <- df %>%
    select(where(~ mean(is.na(.)) < threshold))
  cat("Step 3: Columns with >50% missing values removed.\n")
  
  #    Impute remaining missing values
  df <- df %>%
    mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>%
    mutate(across(where(is.character), ~ ifelse(is.na(.), "Unknown", .)))
  cat("Step 4: Missing values imputed.\n")
  
  # 4. Detect and handle outliers for numeric columns
  df <- df %>%
    mutate(across(where(is.numeric), ~ ifelse(
      . > quantile(., 0.99, na.rm = TRUE) |
        . < quantile(., 0.01, na.rm = TRUE),
      NA, .
    )))
  df <- df %>%
    mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))
  cat("Step 5: Outliers handled.\n")
  
  # 5. Standardize categorical data
  df <- df %>%
    mutate(across(where(is.character), ~ str_to_lower(.) %>% str_trim()))
  cat("Step 6: Categorical data standardized.\n")
  
  # 6. Convert date columns to Date format
  df <- df %>%
    mutate(across(where(~ any(class(.) %in% c("character", "factor")) & 
                         grepl("\\d{4}-\\d{2}-\\d{2}", .)), 
                  ~ as.Date(., format = "%Y-%m-%d")))
  cat("Step 7: Date columns standardized.\n")
  
  # 7. Return cleaned data
  cat("Data cleaning completed!\n")
  return(df)
}

# Example usage
# Load sample data
data <- data.frame(
  Name = c("Alice ", "BOB", "Charlie", NA, "David"),
  Age = c(25, 30, 35, NA, 40),
  Salary = c(50000, 60000, NA, 80000, 90000),
  Joining_Date = c("2022-01-15", "2023-02-20", "2021-05-01", NA, "2020-07-25"),
  stringsAsFactors = FALSE
)

# Clean the data
cleaned_data <- clean_data(data)

# View the cleaned data
print(cleaned_data)
