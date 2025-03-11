library(cluster)
library(factoextra)

# Example dataset (can be replaced with your data)  
data(iris)  
data_matrix <- as.matrix(iris[, -5])  

# Hierarchical clustering (using Ward's method)  
dist_matrix <- dist(data_matrix)
hc <- hclust(dist_matrix, method = "ward.D")

# Method 1: Dendrogram 
plot(hc,
     main = paste('Dendrogram'),
     xlab = 'Customers',
     ylab = 'Euclidean distances')

# Method 2: Silhouette Method

fviz_nbclust(data_matrix, hcut, method = "silhouette") + 
  ggtitle("Silhouette Method for Optimal Clusters")
