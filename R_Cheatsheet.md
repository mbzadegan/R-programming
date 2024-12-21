# R Programming Cheat Sheet

## Basics

### Hello World
```r
print("Hello, World!")
```

### Variables
```r
x <- 10         # Integer
y <- 3.14       # Float
name <- "R"     # String
flag <- TRUE    # Boolean
```

### Comments
- Single-line comment: `# This is a comment`

## Data Types

| Type      | Description                  |
|-----------|------------------------------|
| `numeric` | Numeric values (e.g., 3.14)  |
| `integer` | Whole numbers                |
| `character` | Strings                     |
| `logical` | Boolean (TRUE/FALSE)         |
| `factor`  | Categorical data             |

### Type Checking and Conversion
```r
typeof(x)           # Check type
as.numeric("3.14")  # Convert to numeric
```

## Control Flow

### If-Else
```r
if (x > 0) {
    print("Positive")
} else if (x < 0) {
    print("Negative")
} else {
    print("Zero")
}
```

### Loops

#### For Loop
```r
for (i in 1:5) {
    print(i)
}
```

#### While Loop
```r
while (x > 0) {
    print(x)
    x <- x - 1
}
```

## Functions

### Function Definition
```r
add <- function(a, b) {
    return(a + b)
}
```

## Vectors

### Create a Vector
```r
vec <- c(1, 2, 3, 4, 5)
```

### Operations
```r
length(vec)         # Length of vector
vec[1]              # Access element
vec <- c(vec, 6)    # Add element
```

## Data Frames

### Create a Data Frame
```r
data <- data.frame(
    Name = c("Alice", "Bob", "Charlie"),
    Age = c(25, 30, 35),
    Salary = c(50000, 60000, 70000)
)
```

### Access Data
```r
data$Name       # Access column
data[1, ]       # Access row
data[1, 2]      # Access element
```

## Input/Output

### Read CSV File
```r
data <- read.csv("data.csv")
```

### Write CSV File
```r
write.csv(data, "output.csv")
```

## Plotting

### Basic Plot
```r
plot(x = 1:10, y = (1:10)^2, type = "b", col = "blue")
```

### Histogram
```r
hist(rnorm(100), col = "green")
```

## Common R Commands

### Install and Load Packages
```r
install.packages("ggplot2")
library(ggplot2)
```

### View Structure of Data
```r
str(data)
```

### Summary Statistics
```r
summary(data)
