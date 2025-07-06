# Housing Price Predictor in R

This project is a complete R-based analysis of a housing dataset, including:
- Exploratory Data Analysis (EDA)
- Interactive visualizations using Plotly
- Correlation analysis and pair plots
- Linear regression modeling
- Model evaluation using RMSE and R-squared
- 10-fold cross-validation using the `caret` package
- Interactive user input for real-time price prediction

---

## Dataset

The dataset contains information about housing attributes and their prices. Key features include:

- `area` (in square feet)
- `bedrooms`
- `bathrooms`
- `stories`
- `parking`
- `mainroad`
- `price`

> 📌 Note: Replace the dataset path in the code with your own path if necessary:
```r
housing_data <- read.csv("D:/E-books/SEM 3/Applied Stat and R Lab/Housing.csv")
```

---

## Visualizations Included

- Scatter plot: Price vs Area
- Box plot: Price vs Bedrooms
- Box plot: Price vs Main Road Access
- Histogram: Price Distribution
- Density plot: Area by Main Road Access
- Bar plot: Average Price by Number of Stories
- Correlation heatmap (Plotly)
- Pairwise plots using GGally::ggpairs

---

## Modeling

- Linear regression using:
    - area, bedrooms, bathrooms, stories, parking
- Enhanced model with interaction term: area * stories
- Performance metrics:
    - RMSE
    - R-squared
- Cross-validation (10-fold) using caret

---

## How to run the project:

1. Open the .R file in RStudio.
2. Ensure the required libraries are installed:
```r
install.packages(c("ggplot2", "dplyr", "plotly", "GGally", "caret"))
```
3. Run the entire script or execute code blocks step-by-step.
4. At the end of the script, enter your own housing features when prompted to get a predicted price.

