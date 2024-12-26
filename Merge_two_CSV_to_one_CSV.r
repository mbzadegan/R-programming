# Load necessary library
library(readr)

# Read the two CSV files into data frames
file1 <- read_csv("path_to_file1.csv")  # Replace with actual path to the first file
file2 <- read_csv("path_to_file2.csv")  # Replace with actual path to the second file

# Merge the two data frames (by default, it merges by common column names)
merged_data <- merge(file1, file2, by = "common_column_name", all = TRUE)  # Replace "common_column_name" with the column you want to merge by, or leave it out for automatic matching

# Write the merged data to a new CSV file
write_csv(merged_data, "path_to_merged_file.csv")  # Replace with the desired output file path
