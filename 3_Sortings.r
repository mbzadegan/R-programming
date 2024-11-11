# Set the number of elements to sort
n <- 1000
set.seed(42)  # Set a seed for reproducibility

# Generate a random series of n numbers
random_series <- runif(n, min = 0, max = 1000)

# 1. Bubble Sort
bubble_sort <- function(x) {
  for (i in 1:(length(x) - 1)) {
    for (j in 1:(length(x) - i)) {
      if (x[j] > x[j + 1]) {
        # Swap the elements
        temp <- x[j]
        x[j] <- x[j + 1]
        x[j + 1] <- temp
      }
    }
  }
  return(x)
}

# 2. Selection Sort
selection_sort <- function(x) {
  for (i in 1:(length(x) - 1)) {
    min_index <- i
    for (j in (i + 1):length(x)) {
      if (x[j] < x[min_index]) {
        min_index <- j
      }
    }
    # Swap the elements
    temp <- x[i]
    x[i] <- x[min_index]
    x[min_index] <- temp
  }
  return(x)
}

# 3. Quick Sort (Using R's built-in `sort()` function)
quick_sort <- function(x) {
  return(sort(x))
}

# Measure and report processing times for each method
cat("Sorting a series of", n, "random numbers:\n\n")

# Timing Bubble Sort
bubble_time <- system.time({
  sorted_bubble <- bubble_sort(random_series)
})
cat("Bubble Sort time:\n")
print(bubble_time)

# Timing Selection Sort
selection_time <- system.time({
  sorted_selection <- selection_sort(random_series)
})
cat("Selection Sort time:\n")
print(selection_time)

# Timing Quick Sort
quick_time <- system.time({
  sorted_quick <- quick_sort(random_series)
})
cat("Quick Sort (built-in) time:\n")
print(quick_time)

# Summary of times
cat("\nSummary of processing times (in seconds):\n")
cat("Bubble Sort    :", bubble_time["elapsed"], "seconds\n")
cat("Selection Sort :", selection_time["elapsed"], "seconds\n")
cat("Quick Sort     :", quick_time["elapsed"], "seconds\n")
