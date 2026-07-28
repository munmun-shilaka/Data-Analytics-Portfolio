-- ===========================================================
-- AMAZON PRODUCT ANALYTICS
-- SQL ANALYSIS
-- ===========================================================

-- ===========================================================
-- BASIC SQL
-- ===========================================================

-- 1. View Complete Dataset
SELECT * FROM amazon_products;

-- 2. Total Products
SELECT COUNT(*) AS Total_Products
FROM amazon_products;

-- 3. Distinct Categories
SELECT COUNT(DISTINCT category) AS Total_Categories
FROM amazon_products;

-- 4. Average Product Rating
SELECT ROUND(AVG(rating),2) AS Average_Rating
FROM amazon_products;

-- 5. Average Discount Percentage
SELECT ROUND(AVG(discount_percentage),2) AS Average_Discount
FROM amazon_products;

-- 6. Average Selling Price
SELECT ROUND(AVG(discounted_price),2) AS Average_Selling_Price
FROM amazon_products;

-- ===========================================================
-- INTERMEDIATE SQL
-- ===========================================================

-- 7. Highest Rated Products
SELECT product_name,rating
FROM amazon_products
ORDER BY rating DESC
LIMIT 10;

-- 8. Most Reviewed Products
SELECT product_name,rating_count
FROM amazon_products
ORDER BY rating_count DESC
LIMIT 10;

-- 9. Highest Discount Products
SELECT product_name,discount_percentage
FROM amazon_products
ORDER BY discount_percentage DESC
LIMIT 10;

-- 10. Most Expensive Products
SELECT product_name,actual_price
FROM amazon_products
ORDER BY actual_price DESC
LIMIT 10;

-- 11. Cheapest Products
SELECT product_name,discounted_price
FROM amazon_products
ORDER BY discounted_price
LIMIT 10;

-- 12. Products With Rating Above 4.5
SELECT product_name,rating
FROM amazon_products
WHERE rating > 4.5
ORDER BY rating DESC;

-- ===========================================================
-- CATEGORY ANALYSIS
-- ===========================================================

-- 13. Products Per Category
SELECT
category,
COUNT(*) AS Product_Count
FROM amazon_products
GROUP BY category
ORDER BY Product_Count DESC;

-- 14. Average Rating By Category
SELECT
category,
ROUND(AVG(rating),2) AS Avg_Rating
FROM amazon_products
GROUP BY category
ORDER BY Avg_Rating DESC;

-- 15. Average Discount By Category
SELECT
category,
ROUND(AVG(discount_percentage),2) AS Avg_Discount
FROM amazon_products
GROUP BY category
ORDER BY Avg_Discount DESC;

-- 16. Average Selling Price By Category
SELECT
category,
ROUND(AVG(discounted_price),2) AS Avg_Price
FROM amazon_products
GROUP BY category
ORDER BY Avg_Price DESC;

-- ===========================================================
-- BUSINESS ANALYSIS
-- ===========================================================

-- 17. Premium Products (>10000)
SELECT
product_name,
discounted_price
FROM amazon_products
WHERE discounted_price > 10000
ORDER BY discounted_price DESC;

-- 18. Products With Lowest Ratings
SELECT
product_name,
rating
FROM amazon_products
ORDER BY rating
LIMIT 20;

-- 19. Products With Maximum Customer Engagement
SELECT
product_name,
rating,
rating_count
FROM amazon_products
ORDER BY rating_count DESC
LIMIT 20;

-- 20. Products Having Discount Greater Than 50%
SELECT
product_name,
discount_percentage
FROM amazon_products
WHERE discount_percentage > 50
ORDER BY discount_percentage DESC;

-- ===========================================================
-- ADVANCED SQL
-- ===========================================================

-- 21. Price Difference
SELECT
product_name,
actual_price,
discounted_price,
(actual_price-discounted_price) AS Price_Difference
FROM amazon_products
ORDER BY Price_Difference DESC;

-- 22. Top Categories By Rating Count
SELECT
category,
SUM(rating_count) AS Total_Ratings
FROM amazon_products
GROUP BY category
ORDER BY Total_Ratings DESC;

-- 23. Highest Rated Product In Every Category
SELECT
category,
MAX(rating) AS Highest_Rating
FROM amazon_products
GROUP BY category;

-- 24. Products Above Average Price
SELECT
product_name,
discounted_price
FROM amazon_products
WHERE discounted_price >
(
SELECT AVG(discounted_price)
FROM amazon_products
);

-- 25. Products Below Average Rating
SELECT
product_name,
rating
FROM amazon_products
WHERE rating <
(
SELECT AVG(rating)
FROM amazon_products
);

-- 26. Average Actual Price Vs Selling Price
SELECT
ROUND(AVG(actual_price),2) AS Actual_Price,
ROUND(AVG(discounted_price),2) AS Selling_Price
FROM amazon_products;

-- 27. Top 5 Categories By Average Price
SELECT
category,
ROUND(AVG(discounted_price),2) AS Avg_Price
FROM amazon_products
GROUP BY category
ORDER BY Avg_Price DESC
LIMIT 5;

-- 28. Categories With More Than 50 Products
SELECT
category,
COUNT(*) AS Product_Count
FROM amazon_products
GROUP BY category
HAVING COUNT(*) > 50
ORDER BY Product_Count DESC;

-- 29. Top Products By Rating And Reviews
SELECT
product_name,
rating,
rating_count
FROM amazon_products
ORDER BY rating DESC,rating_count DESC
LIMIT 20;

-- 30. Final Business Summary
SELECT
COUNT(*) AS Total_Products,
ROUND(AVG(rating),2) AS Avg_Rating,
ROUND(AVG(discount_percentage),2) AS Avg_Discount,
ROUND(AVG(discounted_price),2) AS Avg_Price
FROM amazon_products;