import pandas as pd

# Load Dataset
df = pd.read_csv("08_Projects/Project_01_Amazon_Sales_Analytics/Dataset/amazon.csv")

# Remove missing values
df = df.dropna()

print("========== DATASET OVERVIEW ==========\n")

# Shape
print("Shape:")
print(df.shape)

# Columns
print("\nColumns:")
print(df.columns.tolist())

# Data Types
print("\nData Types:")
print(df.dtypes)

# Statistical Summary
print("\nStatistical Summary:")
print(df.describe(include="all"))

# Number of Unique Categories
print("\nUnique Categories:")
print(df["category"].nunique())

# Top 10 Categories
print("\nTop Categories:")
print(df["category"].value_counts().head(10))