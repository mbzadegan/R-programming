# Function to fit a polynomial of degree n-1 to the given points
fit_polynomial - function(matrix_data) {
  # Ensure the input is a 2n matrix
  if (nrow(matrix_data) != 2) {
    stop(Input must be a 2n matrix.)
  }

  # Extract x and y values
  x - matrix_data[1, ]
  y - matrix_data[2, ]
  n - length(x)
  
  # Ensure degree is less than n
  degree - n - 1
  
  # Fit the polynomial using a linear model
  poly_fit - lm(y ~ poly(x, degree, raw = TRUE))
  
  # Extract coefficients
  coefficients - coef(poly_fit)
  
  # Display results
  print(paste(Coefficients of the polynomial of degree, degree, ))
  return(coefficients)
}

# Input the matrix
cat(Enter the number of points (n) )
n - as.integer(readline())

cat(Enter the x-coordinates (space-separated) )
x_coords - as.numeric(strsplit(readline(),  )[[1]])

cat(Enter the y-coordinates (space-separated) )
y_coords - as.numeric(strsplit(readline(),  )[[1]])

if (length(x_coords) != n  length(y_coords) != n) {
  stop(Number of points does not match the input size.)
}

# Create a 2n matrix
input_matrix - rbind(x_coords, y_coords)

# Perform polynomial fitting
tryCatch({
  result - fit_polynomial(input_matrix)
  print(result)
}, error = function(e) {
  cat(Error, e$message, n)
})
