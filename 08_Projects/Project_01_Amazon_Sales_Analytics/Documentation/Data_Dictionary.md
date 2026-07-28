# Data Dictionary

## Overview

This document describes every field used in the Amazon Product Analytics project.

---

| Column Name | Data Type | Description |
|--------------|-----------|-------------|
| product_id | String | Unique product identifier |
| product_name | String | Name of the product |
| category | String | Product category |
| discounted_price | Float | Current selling price after discount |
| actual_price | Float | Original product price |
| discount_percentage | Float | Percentage discount offered |
| rating | Float | Average customer rating |
| rating_count | Integer | Number of customer ratings |
| about_product | Text | Product description |
| user_id | String | Customer identifier |
| user_name | String | Customer name |
| review_id | String | Review identifier |
| review_title | Text | Review headline |
| review_content | Text | Customer review |
| img_link | String | Product image URL |
| product_link | String | Amazon product URL |

---

# Data Types

## Numerical Columns

- discounted_price
- actual_price
- discount_percentage
- rating
- rating_count

---

## Categorical Columns

- product_id
- product_name
- category
- user_name

---

## Text Columns

- about_product
- review_title
- review_content

---

## URL Columns

- img_link
- product_link

---

# Data Quality

The following preprocessing was performed before analysis:

- Missing value handling
- Numeric conversion
- Currency symbol removal
- Percentage conversion
- Duplicate verification
- Data type validation

---

# Dataset Summary

| Metric | Value |
|---------|------:|
| Total Records | 1462 |
| Total Columns | 16 |
| Missing Values | Cleaned |
| Duplicate Records | Checked |

---

# Purpose

This data dictionary provides a reference for all attributes used throughout the Python analysis, SQL analysis, Power BI dashboard, and Business Report.