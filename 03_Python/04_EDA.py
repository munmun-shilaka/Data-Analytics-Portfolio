import pandas as pd

# Load dataset
df = pd.read_csv("08_Projects/Project_01_Amazon_Sales_Analytics/Dataset/amazon.csv")

# Remove missing values
df = df.dropna()

# Convert rating to numeric
df["rating"] = pd.to_numeric(df["rating"], errors="coerce")

print("=" * 60)
print(" AMAZON SALES DATA ANALYSIS ")
print("=" * 60)

# 1. Average Rating
print("\n1. Average Product Rating")
print(round(df["rating"].mean(), 2))

# 2. Highest Rated Products
print("\n2. Top 10 Highest Rated Products")
print(
    df[["product_name", "rating"]]
    .sort_values(by="rating", ascending=False)
    .head(10)
)

# 3. Lowest Rated Products
print("\n3. Lowest Rated Products")
print(
    df[["product_name", "rating"]]
    .sort_values(by="rating")
    .head(10)
)

# 4. Top Categories
print("\n4. Top 10 Categories")
print(df["category"].value_counts().head(10))

# 5. Average Rating by Category
print("\n5. Average Rating by Category")

avg_rating = (
    df.groupby("category")["rating"]
    .mean()
    .sort_values(ascending=False)
)

print(avg_rating.head(10))