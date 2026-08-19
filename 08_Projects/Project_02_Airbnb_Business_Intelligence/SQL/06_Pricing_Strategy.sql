-- ============================================================
-- PROJECT 02: NYC AIRBNB BUSINESS INTELLIGENCE
-- PRICING STRATEGY ANALYSIS
-- ============================================================


-- 1. Average price by borough
SELECT
    neighbourhood_group AS borough,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(MIN(price), 2) AS minimum_price,
    ROUND(MAX(price), 2) AS maximum_price
FROM listings
WHERE price > 0
GROUP BY neighbourhood_group
ORDER BY average_price DESC;


-- 2. Average price by room type
SELECT
    room_type,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews
FROM listings
WHERE price > 0
GROUP BY room_type
ORDER BY average_price DESC;


-- 3. Price segmentation
SELECT
    CASE
        WHEN price < 100 THEN 'Budget'
        WHEN price < 200 THEN 'Standard'
        WHEN price < 500 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_segment,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM listings WHERE price > 0),
        2
    ) AS market_share_percentage
FROM listings
WHERE price > 0
GROUP BY price_segment
ORDER BY
    CASE price_segment
        WHEN 'Budget' THEN 1
        WHEN 'Standard' THEN 2
        WHEN 'Premium' THEN 3
        WHEN 'Luxury' THEN 4
    END;


-- 4. Most expensive neighbourhoods
-- Minimum 20 listings to reduce small-sample distortion.
SELECT
    neighbourhood,
    neighbourhood_group AS borough,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_price
FROM listings
WHERE price > 0
GROUP BY neighbourhood, neighbourhood_group
HAVING COUNT(*) >= 20
ORDER BY average_price DESC
LIMIT 20;


-- 5. Most affordable neighbourhoods
SELECT
    neighbourhood,
    neighbourhood_group AS borough,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_price
FROM listings
WHERE price > 0
GROUP BY neighbourhood, neighbourhood_group
HAVING COUNT(*) >= 20
ORDER BY average_price
LIMIT 20;


-- 6. Price vs review engagement
SELECT
    CASE
        WHEN price < 100 THEN 'Budget'
        WHEN price < 200 THEN 'Standard'
        WHEN price < 500 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_segment,
    COUNT(*) AS listings,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews,
    ROUND(AVG(reviews_per_month), 2) AS average_reviews_per_month
FROM listings
WHERE price > 0
GROUP BY price_segment
ORDER BY
    CASE price_segment
        WHEN 'Budget' THEN 1
        WHEN 'Standard' THEN 2
        WHEN 'Premium' THEN 3
        WHEN 'Luxury' THEN 4
    END;


-- 7. High-price listings with low review engagement
SELECT
    id,
    name,
    host_name,
    neighbourhood_group AS borough,
    neighbourhood,
    price,
    number_of_reviews,
    reviews_per_month
FROM listings
WHERE price > (
    SELECT AVG(price)
    FROM listings
    WHERE price > 0
)
AND number_of_reviews < (
    SELECT AVG(number_of_reviews)
    FROM listings
)
ORDER BY price DESC
LIMIT 25;


-- 8. Potential value opportunities
-- Lower-than-borough-average price with above-average reviews.
WITH borough_metrics AS (
    SELECT
        neighbourhood_group,
        AVG(price) AS avg_borough_price,
        AVG(number_of_reviews) AS avg_borough_reviews
    FROM listings
    WHERE price > 0
    GROUP BY neighbourhood_group
)

SELECT
    l.id,
    l.name,
    l.neighbourhood_group AS borough,
    l.neighbourhood,
    ROUND(l.price, 2) AS price,
    l.number_of_reviews,
    ROUND(b.avg_borough_price, 2) AS borough_average_price,
    ROUND(b.avg_borough_reviews, 2) AS borough_average_reviews
FROM listings l
JOIN borough_metrics b
    ON l.neighbourhood_group = b.neighbourhood_group
WHERE l.price < b.avg_borough_price
AND l.number_of_reviews > b.avg_borough_reviews
ORDER BY l.number_of_reviews DESC
LIMIT 25;


-- 9. Premium listings with strong customer engagement
SELECT
    id,
    name,
    host_name,
    neighbourhood_group AS borough,
    neighbourhood,
    price,
    number_of_reviews,
    reviews_per_month
FROM listings
WHERE price >= (
    SELECT AVG(price) + (
        SELECT AVG(price)
        FROM listings
        WHERE price > 0
    )
)
AND number_of_reviews > (
    SELECT AVG(number_of_reviews)
    FROM listings
)
ORDER BY number_of_reviews DESC
LIMIT 25;


-- 10. Executive pricing summary
SELECT
    ROUND(AVG(price), 2) AS overall_average_price,
    ROUND(
        AVG(CASE WHEN room_type = 'Entire home/apt'
                 THEN price END), 2
    ) AS entire_home_average_price,
    ROUND(
        AVG(CASE WHEN room_type = 'Private room'
                 THEN price END), 2
    ) AS private_room_average_price,
    ROUND(
        AVG(CASE WHEN room_type = 'Shared room'
                 THEN price END), 2
    ) AS shared_room_average_price
FROM listings
WHERE price > 0;