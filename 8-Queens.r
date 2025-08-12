# Function to check if the position is safe for a queen
is_safe <- function(board, row, col) {
  # Check the row on the left side
  for (i in 1:(col - 1)) {
    if (board[row, i] == 1) return(FALSE)
  }
  
  # Check the upper diagonal on the left side
  for (i in 1:min(row - 1, col - 1)) {
    if (board[row - i, col - i] == 1) return(FALSE)
  }
  
  # Check the lower diagonal on the left side
  for (i in 1:min(nrow(board) - row, col - 1)) {
    if (board[row + i, col - i] == 1) return(FALSE)
  }
  
  return(TRUE)
}

# Function to solve the N-Queens problem using backtracking
solve_n_queens <- function(board, col, solutions) {
  # Base case: If all queens are placed
  if (col > ncol(board)) {
    solutions[[length(solutions) + 1]] <<- board  # Store the solution
    return(TRUE)
  }
  
  # Consider each row in this column
  for (row in 1:nrow(board)) {
    # Check if the queen can be placed at board[row, col]
    if (is_safe(board, row, col)) {
      # Place the queen
      board[row, col] <- 1
      
      # Recur to place the next queen
      solve_n_queens(board, col + 1, solutions)
      
      # If placing queen doesn't lead to a solution, remove the queen (backtrack)
      board[row, col] <- 0
    }
  }
  return(FALSE)
}

# Main function to initialize the board and solve the problem
n_queens <- function(n) {
  # Initialize an empty chessboard
  board <- matrix(0, n, n)
  
  # List to store solutions
  solutions <- list()
  
  # Solve the problem starting from the first column
  solve_n_queens(board, 1, solutions)
  
  # Print all solutions
  cat("Total solutions found:", length(solutions), "\n")
  for (i in seq_along(solutions)) {
    cat("\nSolution", i, ":\n")
    print(solutions[[i]])
  }
  
  return(solutions)
}

# Run the 8-Queens problem
solutions <- n_queens(8)
