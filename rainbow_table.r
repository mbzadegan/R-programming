# Install and load the digest package
if (!requireNamespace("digest", quietly = TRUE)) {
  install.packages("digest")
}
library(digest)

# Function to generate a rainbow table
generate_rainbow_table <- function(n, algorithm = "md5") {
  # Generate sample input data (e.g., numeric strings from 1 to n)
  inputs <- sprintf("%05d", 1:n) # 5-digit zero-padded strings
  
  # Compute hashes for each input
  hashes <- sapply(inputs, digest, algo = algorithm)
  
  # Combine inputs and their hashes into a data frame
  rainbow_table <- data.frame(Input = inputs, Hash = hashes, stringsAsFactors = FALSE)
  
  return(rainbow_table)
}

# Generate a rainbow table with n entries
n <- 1000  # Size of the rainbow table
rainbow_table <- generate_rainbow_table(n, algorithm = "sha256")

# Print the first few rows of the rainbow table
head(rainbow_table)

# Optionally, save the table to a file
write.csv(rainbow_table, "rainbow_table.csv", row.names = FALSE)

