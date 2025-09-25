# Load the necessary library
library(readxl)

# Define the file path
file_path <- "path_to_your_excel_file.xlsx"  # Replace with the actual file path.

# Read the Excel file into a data frame
# Specify the sheet name or index if needed, e.g., sheet = 1
data_frame <- read_excel(file_path)

# Convert the data frame to a matrix
data_matrix <- as.matrix(data_frame)

# Print the matrix to verify the conversion
print(data_matrix)

# Optional: Save the matrix to a file (e.g., CSV) if needed
write.csv(data_matrix, "converted_matrix.csv", row.names = FALSE)

