import pandas as pd

# Load Dataset
df = pd.read_csv("08_Projects/Project_01_Amazon_Sales_Analytics/Dataset/amazon.csv")

print("===== BEFORE CLEANING =====")
print(df.shape)

print("\nMissing Values:")
print(df.isnull().sum())

# Remove rows with missing values
df = df.dropna()

print("\n===== AFTER CLEANING =====")
print(df.shape)

print("\nMissing Values:")
print(df.isnull().sum())