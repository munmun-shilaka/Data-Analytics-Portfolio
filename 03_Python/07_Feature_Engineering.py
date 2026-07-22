import pandas as pd

# Load Dataset
df = pd.read_csv("08_Projects/Project_01_Amazon_Sales_Analytics/Dataset/amazon.csv")

# Remove Missing Values
df = df.dropna()

# Convert Price Columns
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

# Convert Rating
df["rating"] = pd.to_numeric(df["rating"], errors="coerce")

# ================================
# Feature 1 : Discount Amount
# ================================
df["discount_amount"] = df["actual_price"] - df["discounted_price"]

# ================================
# Feature 2 : Savings Percentage
# ================================
df["saving_percentage"] = (
    df["discount_amount"] / df["actual_price"]
) * 100

# ================================
# Feature 3 : Product Name Length
# ================================
df["product_name_length"] = df["product_name"].str.len()

# ================================
# Feature 4 : Review Length
# ================================
df["review_length"] = df["review_content"].str.len()

# ================================
# Feature 5 : Rating Category
# ================================
df["rating_category"] = pd.cut(
    df["rating"],
    bins=[0, 2, 3, 4, 5],
    labels=["Poor", "Average", "Good", "Excellent"]
)

print("\n===== New Columns =====")
print(df[[
    "discount_amount",
    "saving_percentage",
    "product_name_length",
    "review_length",
    "rating_category"
]].head())

# Save Feature Engineered Dataset
df.to_csv(
    "08_Projects/Project_01_Amazon_Sales_Analytics/Output/feature_engineered_data.csv",
    index=False
)

print("\nFeature Engineered Dataset Saved Successfully!")