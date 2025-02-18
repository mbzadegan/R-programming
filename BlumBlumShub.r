# Function to generate n random numbers using Blum Blum Shub

blum_blum_shub <- function(n, p, q, seed) {
  # Ensure p and q are congruent to 3 mod 4
  if (p %% 4 != 3 || q %% 4 != 3) {
    stop("p and q must be prime and congruent to 3 mod 4.")
  }
  
  # Calculate modulus
  M <- p * q
  
  # Initialize seed
  x <- seed %% M
  
  # Generate random numbers
  random_numbers <- numeric(n)
  for (i in 1:n) {
    x <- (x^2) %% M  # Blum Blum Shub iteration
    random_numbers[i] <- x / M  # Normalize to [0, 1)
  }
  
  return(random_numbers)
}

# Assess randomness using statistical tests
assess_randomness <- function(random_numbers) {
  cat("Randomness Assessment:\n")
  
  # Chi-squared test for uniformity
  observed <- hist(random_numbers, plot = FALSE, breaks = 10)$counts
  expected <- rep(length(random_numbers) / 10, 10)
  chi_sq_test <- chisq.test(observed, p = rep(1/10, 10))
  cat("Chi-squared Test:\n")
  print(chi_sq_test)
  
  # Kolmogorov-Smirnov test against uniform distribution
  ks_test <- ks.test(random_numbers, "punif", 0, 1)
  cat("\nKolmogorov-Smirnov Test:\n")
  print(ks_test)
}

# Input parameters for BBS
cat("Enter the number of random numbers (n): ")
n <- as.integer(readline())

cat("Enter two prime numbers (p and q, congruent to 3 mod 4): ")
p <- as.integer(readline())
q <- as.integer(readline())

cat("Enter the seed: ")
seed <- as.integer(readline())

# Generate random numbers
tryCatch({
  random_numbers <- blum_blum_shub(n, p, q, seed)
  cat("Generated Random Numbers:\n")
  print(random_numbers)
  
  # Assess randomness
  assess_randomness(random_numbers)
}, error = function(e) {
  cat("Error:", e$message, "\n")
})
