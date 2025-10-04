# Load the JuliaCall package
library(JuliaCall)

# Initialize Julia
julia_setup()

# Enable Julia's parallel processing.
julia_command("using Distributed")
julia_command("addprocs()")  # Add worker processes for parallel computation
julia_command("
    @everywhere function parallel_matrix_multiplication(A, B)
        @sync begin
            return A * B
        end
    end
")

# Generate two random matrices in R
set.seed(123)  # For reproducibility
matrix_A <- matrix(runif(100), nrow = 10, ncol = 10)  # 10x10 random matrix
matrix_B <- matrix(runif(100), nrow = 10, ncol = 10)  # 10x10 random matrix

# Send the matrices to Julia
julia_assign("A", matrix_A)
julia_assign("B", matrix_B)

# Perform parallel matrix multiplication in Julia
result <- julia_eval("parallel_matrix_multiplication(A, B)")

# Print the result
print("Matrix A:")
print(matrix_A)
print("Matrix B:")
print(matrix_B)
print("Result of A * B using Julia parallel programming:")
print(result)

