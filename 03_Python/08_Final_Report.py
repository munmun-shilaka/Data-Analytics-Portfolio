import pandas as pd

# Load Dataset
df = pd.read_csv(
    "08_Projects/Project_01_Amazon_Sales_Analytics/Output/feature_engineered_data.csv"
)

print("=" * 60)
print(" AMAZON SALES ANALYTICS REPORT ")
print("=" * 60)

print("\nTotal Products :", len(df))

print("\nAverage Rating :", round(df["rating"].mean(), 2))

print("\nAverage Actual Price : ₹", round(df["actual_price"].mean(), 2))

print("\nAverage Discounted Price : ₹", round(df["discounted_price"].mean(), 2))

print("\nAverage Savings : ₹", round(df["discount_amount"].mean(), 2))

print(
    "\nHighest Rated Product:\n"
)

print(
    df[
        ["product_name", "rating"]
    ]
    .sort_values("rating", ascending=False)
    .head(1)
)

print(
    "\nMost Expensive Product:\n"
)

print(
    df[
        ["product_name", "actual_price"]
    ]
    .sort_values("actual_price", ascending=False)
    .head(1)
)

print("\nTop 5 Categories")

print(df["category"].value_counts().head())

print("\nRating Distribution")

print(df["rating_category"].value_counts())

print("\nReport Generated Successfully!")

with open(
    "08_Projects/Project_01_Amazon_Sales_Analytics/Documentation/Business_Report.txt",
    "w"
) as f:

    f.write("AMAZON SALES ANALYTICS REPORT\n")
    f.write("="*50 + "\n\n")

    f.write(f"Total Products : {len(df)}\n")
    f.write(f"Average Rating : {round(df['rating'].mean(),2)}\n")
    f.write(f"Average Price : ₹ {round(df['actual_price'].mean(),2)}\n")
    f.write(f"Average Discount : ₹ {round(df['discount_amount'].mean(),2)}\n")

print("Business Report Saved!")