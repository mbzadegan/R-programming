# Here’s an example of solving a high-challenging data analysis problem using Principal Component Analysis (PCA) and Clustering to identify patterns in a high-dimensional dataset. This approach is commonly used for feature reduction and understanding structure in large datasets such as gene expression or customer segmentation.



# Load necessary libraries
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("factoextra")) install.packages("factoextra")
if (!require("cluster")) install.packages("cluster")

library(ggplot2)
library(factoextra)
library(cluster)

# Simulate high-dimensional dataset
set.seed(123)
n_samples <- 150
n_features <- 50
data <- matrix(rnorm(n_samples * n_features, mean = 0, sd = 1), 
               nrow = n_samples, ncol = n_features)
colnames(data) <- paste0("Feature_", 1:n_features)

# Standardize the data
data_scaled <- scale(data)

# Step 1: Perform Principal Component Analysis (PCA)
pca_result <- prcomp(data_scaled, center = TRUE, scale. = TRUE)

# Visualize variance explained by each principal component
fviz_eig(pca_result, addlabels = TRUE, ylim = c(0, 50))

# Select top principal components that explain most variance
pca_data <- as.data.frame(pca_result$x[, 1:10])  # Retain first 10 components

# Step 2: Apply k-means clustering on reduced data
set.seed(123)
k <- 3  # Assume 3 clusters
kmeans_result <- kmeans(pca_data, centers = k, nstart = 25)

# Add cluster assignments to the PCA data
pca_data$Cluster <- factor(kmeans_result$cluster)

# Step 3: Visualize clusters in the first two principal components
ggplot(pca_data, aes(x = PC1, y = PC2, color = Cluster)) +
  geom_point(size = 3, alpha = 0.8) +
  labs(title = "Clustering on PCA-reduced Data", x = "Principal Component 1", y = "Principal Component 2") +
  theme_minimal()

# Step 4: Evaluate clustering quality
# Silhouette Analysis
sil <- silhouette(kmeans_result$cluster, dist(pca_data[, -11]))  # Exclude 'Cluster' column for distance computation
fviz_silhouette(sil)

# Print cluster centers (interpretable in PCA space)
print(kmeans_result$centers)

# Step 5: Summarize insights
cat("Summary:\n")
cat("- The PCA reduced the dataset from", n_features, "to 10 principal components.\n")
cat("- The k-means clustering identified", k, "clusters with distinct patterns.\n")
cat("- Visualization reveals separability of clusters in PCA-reduced space.\n")
