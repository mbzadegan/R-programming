# Load the JuliaCall package
library(JuliaCall)

# Initialize Julia
julia_setup()

# Enable Julia's parallel processing
julia_command("using Distributed")
julia_command("addprocs()")  # Add worker processes for parallel computation
julia_command("
    @everywhere begin
        using SHA  # Julia library for SHA256
        using Base.Filesystem

        # Function to compute SHA256 for a file
        function compute_sha256(file_path::String)
            open(file_path, "r") do io
                return sha256(io)
            end
        end

        # Function to process files in parallel
        function parallel_sha256(file_paths::Vector{String})
            return pmap(compute_sha256, file_paths)
        end
    end
")

# Provide file paths in R
file_paths <- c("file1.txt", "file2.txt", "file3.txt")  # Replace with your file paths

# Send the file paths to Julia
julia_assign("file_paths", file_paths)

# Perform parallel SHA256 computation in Julia
hash_results <- julia_eval("parallel_sha256(file_paths)")

# Print results
print("SHA256 Hashes of Files:")
for (i in seq_along(file_paths)) {
  cat(sprintf("File: %s\nHash: %s\n\n", file_paths[i], hash_results[[i]]))
}

