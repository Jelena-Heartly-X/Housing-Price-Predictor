library(ggplot2)
library(dplyr)
library(plotly)
library(GGally)
library(caret)

# Load the housing dataset
housing_data <- read.csv("D:/E-books/SEM 3/Applied Stat and R Lab/Housing.csv")

summary(housing_data)

# Check for any missing values and remove them
housing_data <- na.omit(housing_data)  # Removing rows with missing data

# Visualizing Price vs Area with a Scatter Plot
scatter_plot <- ggplot(housing_data, aes(x = area, y = price)) +
  geom_point(color = 'blue', alpha = 0.6) +
  labs(title = "Price vs Area", x = "Area (in Square Feet)", y = "Price")

print(ggplotly(scatter_plot))

# visualizing Bedrooms vs Price with a Box Plot
box_plot_bedrooms <- ggplot(housing_data, aes(x = factor(bedrooms), y = price)) +
  geom_boxplot(fill = 'purple', alpha = 0.7) +
  labs(title = "Price vs Bedrooms", x = "Number of Bedrooms", y = "Price")

print(ggplotly(box_plot_bedrooms))

# Create a Correlation Heatmap for Key Numeric Variables
numeric_features <- housing_data %>% select(price, area, bedrooms, bathrooms, stories, parking)
correlation_matrix <- cor(numeric_features, use = "complete.obs")

# Generate a heatmap to visualize correlations
print(plot_ly(
  z = correlation_matrix, 
  x = colnames(correlation_matrix), 
  y = rownames(correlation_matrix), 
  type = "heatmap", 
  colors = colorRamp(c("red", "white", "blue"))
) %>%
  layout(
    title = "Correlation Heatmap",
    xaxis = list(title = ""),
    yaxis = list(title = "")
  ))

# Pair Plot to Explore Relationships Between Variables
pair_plot <- ggpairs(numeric_features, title = "Pairwise Relationships Between Key Variables")
suppressWarnings(print(ggplotly(pair_plot)))


#  Main Road Access vs Price with a Box Plot
mainroad_plot <- ggplot(housing_data, aes(x = mainroad, y = price)) +
  geom_boxplot(fill = 'cyan', alpha = 0.7) +
  labs(title = "Price vs Main Road Access", x = "Main Road Access", y = "Price")

print(ggplotly(mainroad_plot))

# Visualizing Price Distribution with a Histogram
histogram_price <- ggplot(housing_data, aes(x = price)) +
  geom_histogram(binwidth = 100000, fill = 'green', alpha = 0.6) +
  labs(title = "Price Distribution", x = "Price", y = "Frequency")

print(ggplotly(histogram_price))

#  Density Plot of Area by Main Road Access
density_plot <- ggplot(housing_data, aes(x = area, fill = mainroad)) +
  geom_density(alpha = 0.7) +
  labs(title = "Density Plot of Area by Main Road Access", x = "Area", y = "Density")

print(ggplotly(density_plot))

# Bar Plot of Average Price by Number of Stories
bar_plot_stories <- ggplot(housing_data, aes(x = factor(stories), y = price, fill = factor(stories))) +
  geom_bar(stat = "summary", fun = "mean", alpha = 0.7) +
  labs(title = "Average Price by Number of Stories", x = "Stories", y = "Average Price")

print(ggplotly(bar_plot_stories))

#  Create a Linear Regression Model to Predict Price
price_model <- lm(price ~ area + bedrooms + bathrooms + stories + parking, data = housing_data)
print(price_model)

# Evaluate the model's performance
predicted_prices <- predict(price_model, newdata = housing_data)
rmse_value <- sqrt(mean((housing_data$price - predicted_prices)^2))
r_squared_value <- summary(price_model)$r.squared

cat("Model Evaluation:\n")
cat("RMSE: ", rmse_value, "\nR-squared: ", r_squared_value ,"\n")

# Create Interaction Feature
housing_data$area_stories <- housing_data$area * housing_data$stories

# Refit the model with the new interaction feature
enhanced_model <- lm(price ~ area + bedrooms + bathrooms + stories + parking + area_stories, data = housing_data)

# Evaluate the new model's performance
predicted_prices_interaction <- predict(enhanced_model, newdata = housing_data)
rmse_interaction_value <- sqrt(mean((housing_data$price - predicted_prices_interaction)^2))

cat("RMSE (with interaction): ", rmse_interaction_value, "\n")

#  Cross-Validation with the Caret Package
train_control <- trainControl(method = "cv", number = 10)
cross_val_model <- train(price ~ area + bedrooms + bathrooms + stories + parking, data = housing_data, 
                         method = "lm", trControl = train_control)

print(cross_val_model)

# Get user inputs 
input_area <- as.numeric(readline(prompt = "Enter the area (in square feet): "))
input_bedrooms <- as.numeric(readline(prompt = "Enter the number of bedrooms: "))
input_bathrooms <- as.numeric(readline(prompt = "Enter the number of bathrooms: "))
input_stories <- as.numeric(readline(prompt = "Enter the number of stories: "))
input_parking <- as.numeric(readline(prompt = "Enter the number of parking spaces: "))

# Create a new data frame for user input
user_data <- data.frame(
  area = input_area,
  bedrooms = input_bedrooms,
  bathrooms = input_bathrooms,
  stories = input_stories,
  parking = input_parking
)

# Predict the house price using the linear regression model
predicted_price <- predict(price_model, newdata = user_data)

cat("The predicted price for the house is: $", round(predicted_price, 2), "\n")

# Final model evaluation metrics
cat("Final RMSE: ", rmse_value, "\nFinal R-squared: ", r_squared_value)