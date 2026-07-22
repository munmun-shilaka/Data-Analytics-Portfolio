import pandas as pd
# Load dataset
df = pd.read_csv("08_Projects/Project_01_Amazon_Sales_Analytics/Dataset/amazon.csv")

# First 5 rows
print("===== FIRST 5 ROWS =====")
print(df.head())

# Dataset Shape
print("\n===== DATASET SHAPE =====")
print(df.shape)

# Column Names
print("\n===== COLUMN NAMES =====")
print(df.columns)

# Dataset Information
print("\n===== DATASET INFO =====")
print(df.info())

# Missing Values
print("\n===== MISSING VALUES =====")
print(df.isnull().sum())