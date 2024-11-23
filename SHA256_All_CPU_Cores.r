# Load necessary libraries
library(parallel)
library(digest)

# Function to calculate SHA-256 hash of a chunk
hash_chunk <- function(chunk) {
  digest(chunk, algo = "sha256", serialize = FALSE, raw = TRUE)
}

# Function to calculate SHA-256 hash of a binary file using all CPU threads
calculate_sha256_parallel <- function(file_path, chunk_size = 1024 * 1024) {
  # Open the binary file
  con <- file(file_path, "rb")
  
  # Get the number of available cores
  num_cores <- detectCores()
  
  # Create a cluster
  cl <- makeCluster(num_cores)
  
  # Initialize a list to store chunk hashes
  chunk_hashes <- list()
  
  # Read and process file in chunks
  repeat {
    chunk <- readBin(con, what = raw(), n = chunk_size)
    if (length(chunk) == 0) break  # Exit if no data remains
    
    # Distribute chunk hashing across workers
    chunk_hashes <- c(chunk_hashes, clusterApply(cl, list(chunk), hash_chunk))
  }
  
  # Close the file and stop the cluster
  close(con)
  stopCluster(cl)
  
  # Combine hashes into a final SHA-256 hash
  final_hash <- Reduce(function(h1, h2) digest(c(h1, h2), algo = "sha256", raw = TRUE), chunk_hashes)
  final_hash_hex <- paste(sprintf("%02x", as.integer(final_hash)), collapse = "")
  
  return(final_hash_hex)
}

# Example Usage
cat("Enter the binary file path: ")
file_path <- readline()
if (file.exists(file_path)) {
  sha256_hash <- calculate_sha256_parallel(file_path)
  cat("SHA-256 Hash:\n", sha256_hash, "\n")
} else {
  cat("File does not exist!\n")
}
