# Simulate the energy eigenstates and eigenfunctions of a particle confined in a 1D potential well (quantum box) using the time-independent Schrödinger equation.


# Load necessary library for matrix computations
if (!require("pracma")) install.packages("pracma")
library(pracma)

# Step 1: Define constants and parameters
hbar <- 1          # Reduced Planck's constant (set to 1 for simplicity)
m <- 1             # Particle mass (set to 1 for simplicity)
L <- 1             # Length of the box
n_points <- 100    # Number of spatial grid points

# Step 2: Define the spatial grid and step size
x <- seq(0, L, length.out = n_points)
dx <- x[2] - x[1]

# Step 3: Construct the Hamiltonian matrix
# Kinetic energy operator (-hbar^2 / 2m * d^2/dx^2)
kinetic <- -hbar^2 / (2 * m) * (diag(rep(-2, n_points)) + 
                                diag(rep(1, n_points - 1), 1) +
                                diag(rep(1, n_points - 1), -1)) / dx^2

# Potential energy operator (V(x) = 0 inside the box, infinity outside)
potential <- diag(rep(0, n_points))  # Particle in an infinite box has V(x) = 0

# Hamiltonian (H = T + V)
H <- kinetic + potential

# Step 4: Solve the eigenvalue problem (Hψ = Eψ)
eig <- eigen(H)
eigenvalues <- eig$values
eigenvectors <- eig$vectors

# Step 5: Normalize the eigenfunctions
normalize <- function(vec, dx) {
  return(vec / sqrt(sum(vec^2) * dx))
}

eigenfunctions <- apply(eigenvectors, 2, normalize, dx = dx)

# Step 6: Visualize energy eigenstates and eigenfunctions
# Extract first 5 eigenvalues and eigenfunctions
eigenvalues <- eigenvalues[1:5]
eigenfunctions <- eigenfunctions[, 1:5]

# Plot eigenfunctions
plot(NULL, xlim = c(0, L), ylim = c(-2, 2), xlab = "x", ylab = "ψ(x)", 
     main = "Eigenfunctions of a Particle in a Box")
for (i in 1:5) {
  lines(x, eigenfunctions[, i] + i, col = i, lwd = 2)  # Offset eigenfunctions for clarity
  text(L, i, paste0("E", i, " = ", round(eigenvalues[i], 2)), pos = 4, col = i)
}

# Step 7: Print energy eigenvalues
cat("Energy Eigenvalues (first 5 states):\n")
print(eigenvalues)
