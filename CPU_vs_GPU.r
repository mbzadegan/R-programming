#### Please run -->>    install.packages("gpuR")

# Load required libraries
library(gpuR)

# Set matrix size
n <- 1024

# Generate two random matrices
set.seed(123)
A <- matrix(runif(n * n), nrow = n, ncol = n)
B <- matrix(runif(n * n), nrow = n, ncol = n)

# ***** CPU Matrix Multiplication *****
cat("CPU computation:\n")
cpu_start <- Sys.time()
C_cpu <- A %*% B
cpu_end <- Sys.time()
cpu_time <- as.numeric(difftime(cpu_end, cpu_start, units = "secs"))
cat("CPU Time: ", cpu_time, " seconds\n")

# ***** GPU Matrix Multiplication *****
cat("\nGPU computation:\n")
gpu_start <- Sys.time()

# Convert matrices to GPU objects
gpu_A <- gpuMatrix(A, type = "float")
gpu_B <- gpuMatrix(B, type = "float")

# Perform matrix multiplication on the GPU
gpu_C <- gpu_A %*% gpu_B

gpu_end <- Sys.time()
gpu_time <- as.numeric(difftime(gpu_end, gpu_start, units = "secs"))
cat("GPU Time: ", gpu_time, " seconds\n")

# Compare the results for correctness (optional)
C_gpu <- as.matrix(gpu_C)  # Convert GPU result back to matrix for comparison
if (all.equal(C_cpu, C_gpu, tolerance = 1e-6)) {
  cat("\nResults match!\n")
} else {
  cat("\nResults do not match!\n")
}

# Output comparison of times
cat("\nTime comparison:\n")
cat("CPU Time: ", cpu_time, " seconds\n")
cat("GPU Time: ", gpu_time, " seconds\n")
cat("Speedup: ", cpu_time / gpu_time, "x\n")
