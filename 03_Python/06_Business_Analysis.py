import pandas as pd

# Load Dataset
df = pd.read_csv("08_Projects/Project_01_Amazon_Sales_Analytics/Dataset/amazon.csv")

# Clean Data
df = df.dropna()

# Convert Columns
df["rating"] = pd.to_numeric(df["rating"], errors="coerce")
df["discounted_price"] = (
    df["discounted_price"]
    .replace("[₹,]", "", regex=True)
    .astype(float)
)
df["actual_price"] = (
    df["actual_price"]
    .replace("[₹,]", "", regex=True)
    .astype(float)
)

# ===============================
# Dataset Shape
# ===============================
print("\n===== Dataset Shape =====")
print(df.shape)

# ===============================
# Average Rating
# ===============================
print("\n===== Average Rating =====")
print(df["rating"].mean())

# ===============================
# Highest Rated Products
# ===============================
print("\n===== Top 10 Highest Rated Products =====")

top_products = (
    df[
        ["product_name", "rating"]
    ]
    .sort_values(by="rating", ascending=False)
    .head(10)
)

print(top_products)

# ===============================
# Most Expensive Products
# ===============================
print("\n===== Top 10 Expensive Products =====")

expensive = (
    df[
        ["product_name", "actual_price"]
    ]
    .sort_values(by="actual_price", ascending=False)
    .head(10)
)

print(expensive)

# ===============================
# Biggest Discounts
# ===============================
print("\n===== Biggest Discounts =====")

discounts = (
    df[
        ["product_name", "discount_percentage"]
    ]
    .sort_values(by="discount_percentage", ascending=False)
    .head(10)
)

print(discounts)

# ===============================
# Average Price
# ===============================
print("\n===== Average Price =====")

print(df["actual_price"].mean())