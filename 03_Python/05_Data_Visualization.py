import pandas as pd
import matplotlib.pyplot as plt

# Load Dataset
df = pd.read_csv("08_Projects/Project_01_Amazon_Sales_Analytics/Dataset/amazon.csv")

# Remove missing values
df = df.dropna()

# Convert rating to numeric
df["rating"] = pd.to_numeric(df["rating"], errors="coerce")

# Top 10 Categories
top_categories = df["category"].value_counts().head(10)

# Plot
plt.figure(figsize=(18,8))
top_categories.plot(kind="bar")

plt.title("Top 10 Product Categories")
plt.xlabel("Category")
plt.ylabel("Number of Products")

plt.xticks(rotation=45, ha="right")

plt.tight_layout()

plt.xticks(rotation=45, ha="right")

plt.tight_layout()

plt.savefig("chart.png")

print("Chart Saved Successfully!")

plt.close()