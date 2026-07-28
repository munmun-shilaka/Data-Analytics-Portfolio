# ============================================================
# Amazon Product Analytics
# Data Visualization
# Author : Munmun Shilaka
# ============================================================

import os
import warnings

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

warnings.filterwarnings("ignore")

# ============================================================
# CREATE IMAGE FOLDER
# ============================================================

IMAGE_FOLDER = "08_Projects/Project_01_Amazon_Sales_Analytics/Images"

os.makedirs(IMAGE_FOLDER, exist_ok=True)

# ============================================================
# LOAD DATA
# ============================================================

DATA_PATH = "08_Projects/Project_01_Amazon_Sales_Analytics/Dataset/amazon.csv"

df = pd.read_csv(DATA_PATH)

print("=" * 60)
print("Dataset Loaded Successfully")
print("=" * 60)

print(df.head())

# ============================================================
# CLEAN DATA
# ============================================================

def clean_currency(column):
    return (
        column.astype(str)
        .str.replace("₹", "", regex=False)
        .str.replace(",", "", regex=False)
        .astype(float)
    )

df["actual_price"] = clean_currency(df["actual_price"])
df["discounted_price"] = clean_currency(df["discounted_price"])

df["discount_percentage"] = (
    df["discount_percentage"]
    .astype(str)
    .str.replace("%", "", regex=False)
    .astype(float)
)

df["rating"] = pd.to_numeric(df["rating"], errors="coerce")

df["rating_count"] = (
    df["rating_count"]
    .astype(str)
    .str.replace(",", "", regex=False)
)

df["rating_count"] = pd.to_numeric(df["rating_count"], errors="coerce")

df.dropna(inplace=True)

print("\nDataset Shape:", df.shape)

# ============================================================
# PLOT SETTINGS
# ============================================================

plt.style.use("ggplot")

TITLE_SIZE = 18
LABEL_SIZE = 12

# ============================================================
# CHART 1
# Rating Distribution
# ============================================================

plt.figure(figsize=(10,6))

plt.hist(
    df["rating"],
    bins=20,
    edgecolor="black"
)

plt.title("Distribution of Product Ratings", fontsize=TITLE_SIZE)
plt.xlabel("Rating", fontsize=LABEL_SIZE)
plt.ylabel("Number of Products", fontsize=LABEL_SIZE)

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "01_Rating_Distribution.png"
    ),
    dpi=300
)

plt.close()

print("Chart 1 Saved")

# ============================================================
# CHART 2
# Category Distribution
# ============================================================

top_categories = (
    df["category"]
    .value_counts()
    .head(10)
)

plt.figure(figsize=(12,7))

top_categories.sort_values().plot(
    kind="barh"
)

plt.title("Top 10 Product Categories", fontsize=TITLE_SIZE)
plt.xlabel("Product Count")
plt.ylabel("Category")

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "02_Category_Distribution.png"
    ),
    dpi=300
)

plt.close()

print("Chart 2 Saved")

# ============================================================
# CHART 3
# Price Distribution
# ============================================================

plt.figure(figsize=(10,6))

plt.hist(
    df["discounted_price"],
    bins=30,
    edgecolor="black"
)

plt.title("Discounted Price Distribution", fontsize=TITLE_SIZE)
plt.xlabel("Price")
plt.ylabel("Number of Products")

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "03_Price_Distribution.png"
    ),
    dpi=300
)

plt.close()

print("Chart 3 Saved")

# ============================================================
# CHART 4
# Discount Distribution
# ============================================================

plt.figure(figsize=(10,6))

plt.hist(
    df["discount_percentage"],
    bins=25,
    edgecolor="black"
)

plt.title("Discount Percentage Distribution", fontsize=TITLE_SIZE)
plt.xlabel("Discount (%)")
plt.ylabel("Products")

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "04_Discount_Distribution.png"
    ),
    dpi=300
)

plt.close()

print("Chart 4 Saved")

print("=" * 60)
print("PART 1 COMPLETED")
print("=" * 60)
# ============================================================
# CHART 5
# Top 10 Highest Rated Products
# ============================================================

top_rated = (
    df.sort_values(by="rating", ascending=False)
      .head(10)
)

plt.figure(figsize=(14,8))

plt.barh(
    top_rated["product_name"],
    top_rated["rating"]
)

plt.title("Top 10 Highest Rated Products", fontsize=TITLE_SIZE)
plt.xlabel("Rating")
plt.ylabel("Product")

plt.gca().invert_yaxis()

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "05_Top10_Highest_Rated_Products.png"
    ),
    dpi=300
)

plt.close()

print("Chart 5 Saved")


# ============================================================
# CHART 6
# Top 10 Most Reviewed Products
# ============================================================

most_reviewed = (
    df.sort_values(
        by="rating_count",
        ascending=False
    ).head(10)
)

plt.figure(figsize=(14,8))

plt.barh(
    most_reviewed["product_name"],
    most_reviewed["rating_count"]
)

plt.title("Top 10 Most Reviewed Products", fontsize=TITLE_SIZE)
plt.xlabel("Number of Ratings")
plt.ylabel("Product")

plt.gca().invert_yaxis()

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "06_Top10_Most_Reviewed_Products.png"
    ),
    dpi=300
)

plt.close()

print("Chart 6 Saved")


# ============================================================
# CHART 7
# Price vs Rating
# ============================================================

plt.figure(figsize=(10,6))

plt.scatter(
    df["discounted_price"],
    df["rating"],
    alpha=0.6
)

plt.title("Price vs Rating", fontsize=TITLE_SIZE)
plt.xlabel("Discounted Price")
plt.ylabel("Rating")

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "07_Price_vs_Rating.png"
    ),
    dpi=300
)

plt.close()

print("Chart 7 Saved")


# ============================================================
# CHART 8
# Discount vs Rating
# ============================================================

plt.figure(figsize=(10,6))

plt.scatter(
    df["discount_percentage"],
    df["rating"],
    alpha=0.6
)

plt.title("Discount Percentage vs Rating", fontsize=TITLE_SIZE)
plt.xlabel("Discount Percentage")
plt.ylabel("Rating")

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "08_Discount_vs_Rating.png"
    ),
    dpi=300
)

plt.close()

print("Chart 8 Saved")


# ============================================================
# CATEGORY-WISE AVERAGE RATING
# ============================================================

category_rating = (
    df.groupby("category")["rating"]
      .mean()
      .sort_values(ascending=False)
      .head(10)
)

plt.figure(figsize=(14,8))

category_rating.sort_values().plot(kind="barh")

plt.title("Top Categories by Average Rating", fontsize=TITLE_SIZE)
plt.xlabel("Average Rating")
plt.ylabel("Category")

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "09_Category_Average_Rating.png"
    ),
    dpi=300
)

plt.close()

print("Chart 9 Saved")


print("="*60)
print("PART 2 COMPLETED")
print("="*60)
# ============================================================
# IMPORT FOR HEATMAP
# ============================================================

import matplotlib.colors as mcolors

# ============================================================
# CHART 10
# Correlation Heatmap
# ============================================================

correlation = df[
    [
        "actual_price",
        "discounted_price",
        "discount_percentage",
        "rating",
        "rating_count"
    ]
].corr()

fig, ax = plt.subplots(figsize=(8,6))

heatmap = ax.imshow(
    correlation,
    cmap="coolwarm"
)

ax.set_xticks(range(len(correlation.columns)))
ax.set_yticks(range(len(correlation.columns)))

ax.set_xticklabels(correlation.columns, rotation=45, ha="right")
ax.set_yticklabels(correlation.columns)

for i in range(len(correlation.columns)):
    for j in range(len(correlation.columns)):
        ax.text(
            j,
            i,
            f"{correlation.iloc[i,j]:.2f}",
            ha="center",
            va="center",
            color="black"
        )

plt.colorbar(heatmap)

plt.title(
    "Correlation Heatmap",
    fontsize=TITLE_SIZE
)

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "10_Correlation_Heatmap.png"
    ),
    dpi=300
)

plt.close()

print("Chart 10 Saved")


# ============================================================
# CHART 11
# Discounted Price Boxplot
# ============================================================

plt.figure(figsize=(8,6))

plt.boxplot(
    df["discounted_price"],
    vert=True
)

plt.title(
    "Boxplot of Discounted Price",
    fontsize=TITLE_SIZE
)

plt.ylabel("Price")

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "11_Boxplot_Discounted_Price.png"
    ),
    dpi=300
)

plt.close()

print("Chart 11 Saved")


# ============================================================
# CHART 12
# Rating Boxplot
# ============================================================

plt.figure(figsize=(8,6))

plt.boxplot(
    df["rating"],
    vert=True
)

plt.title(
    "Boxplot of Product Rating",
    fontsize=TITLE_SIZE
)

plt.ylabel("Rating")

plt.tight_layout()

plt.savefig(
    os.path.join(
        IMAGE_FOLDER,
        "12_Boxplot_Rating.png"
    ),
    dpi=300
)

plt.close()

print("Chart 12 Saved")


# ============================================================
# SUMMARY STATISTICS
# ============================================================

summary = df[
    [
        "actual_price",
        "discounted_price",
        "discount_percentage",
        "rating",
        "rating_count"
    ]
].describe()

summary.to_csv(
    "08_Projects/Project_01_Amazon_Sales_Analytics/Output/summary_statistics.csv"
)

print("Summary Statistics Saved")


# ============================================================
# CATEGORY ANALYSIS
# ============================================================

category_summary = (
    df.groupby("category")
    .agg(
        Average_Rating=("rating", "mean"),
        Average_Price=("discounted_price", "mean"),
        Product_Count=("product_name", "count")
    )
    .sort_values(
        by="Average_Rating",
        ascending=False
    )
)

category_summary.to_csv(
    "08_Projects/Project_01_Amazon_Sales_Analytics/Output/category_analysis.csv"
)

print("Category Analysis Saved")


# ============================================================
# BUSINESS INSIGHTS
# ============================================================

business_insights = pd.DataFrame({

    "Insight":[

        "Average Product Rating",

        "Average Discount",

        "Average Discounted Price",

        "Highest Rated Product",

        "Most Reviewed Product"

    ],

    "Value":[

        round(df["rating"].mean(),2),

        round(df["discount_percentage"].mean(),2),

        round(df["discounted_price"].mean(),2),

        df.loc[
            df["rating"].idxmax(),
            "product_name"
        ],

        df.loc[
            df["rating_count"].idxmax(),
            "product_name"
        ]

    ]

})
business_insights.to_csv(
    os.path.join(
        IMAGE_FOLDER,
        "..",
        "Output",
        "business_insights.csv"
    ),
    index=False
)

print("Business Insights Saved")


# ============================================================
# FINAL MESSAGE
# ============================================================

print("\n")
print("="*70)
print(" AMAZON PRODUCT ANALYTICS VISUALIZATION COMPLETED ")
print("="*70)

print(f"Total Products : {len(df)}")
print(f"Average Rating : {df['rating'].mean():.2f}")
print(f"Average Discount : {df['discount_percentage'].mean():.2f}%")
print(f"Average Price : ₹{df['discounted_price'].mean():.2f}")

print("\nGenerated Files")

print("✔ 12 Professional Charts")
print("✔ Summary Statistics")
print("✔ Category Analysis")
print("✔ Business Insights")

print("\nLocation:")

print(IMAGE_FOLDER)

print("="*70)
print("END OF PROGRAM")
print("="*70)

DATA_PATH = "08_Projects/Project_01_Amazon_Sales_Analytics/Dataset/amazon.csv"
import os

print("Current Working Directory:")
print(os.getcwd())
DATA_PATH = "08_Projects/Project_01_Amazon_Sales_Analytics/Dataset/amazon.csv"

from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

DATA_PATH = (
    BASE_DIR
    / "08_Projects"
    / "Project_01_Amazon_Sales_Analytics"
    / "Dataset"
    / "amazon.csv")
df = pd.read_csv(DATA_PATH)
