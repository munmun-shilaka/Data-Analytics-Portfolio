-- ============================================================
-- PROJECT 02: NYC AIRBNB BUSINESS INTELLIGENCE
-- CUSTOMER & REVIEW INSIGHTS
-- ============================================================


-- 1. Total reviews
SELECT
    SUM(number_of_reviews) AS total_reviews
FROM listings;


-- 2. Average reviews per listing
SELECT
    ROUND(AVG(number_of_reviews), 2) AS average_reviews_per_listing
FROM listings;


-- 3. Listings with and without reviews
SELECT
    CASE
        WHEN number_of_reviews = 0 THEN 'No Reviews'
        ELSE 'Has Reviews'
    END AS review_status,
    COUNT(*) AS listings
FROM listings
GROUP BY review_status;


-- 4. Top 20 most reviewed listings
SELECT
    id,
    name,
    host_name,
    neighbourhood_group AS borough,
    neighbourhood,
    room_type,
    price,
    number_of_reviews
FROM listings
ORDER BY number_of_reviews DESC
LIMIT 20;


-- 5. Highest review activity by borough
SELECT
    neighbourhood_group AS borough,
    COUNT(*) AS listings,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews,
    SUM(number_of_reviews) AS total_reviews
FROM listings
GROUP BY neighbourhood_group
ORDER BY average_reviews DESC;


-- 6. Review activity by room type
SELECT
    room_type,
    COUNT(*) AS listings,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews,
    ROUND(AVG(reviews_per_month), 2) AS average_reviews_per_month
FROM listings
GROUP BY room_type
ORDER BY average_reviews DESC;


-- 7. Review activity by price segment
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


-- 8. High-engagement listings
SELECT
    id,
    name,
    host_name,
    neighbourhood_group AS borough,
    neighbourhood,
    room_type,
    price,
    number_of_reviews,
    reviews_per_month
FROM listings
WHERE number_of_reviews >= 100
ORDER BY reviews_per_month DESC
LIMIT 25;


-- 9. Listings with strong review activity but below-average price
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
WHERE price < (
    SELECT AVG(price)
    FROM listings
    WHERE price > 0
)
AND number_of_reviews > (
    SELECT AVG(number_of_reviews)
    FROM listings
)
ORDER BY number_of_reviews DESC
LIMIT 25;


-- 10. Expensive listings with weak review activity
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


-- 11. Neighbourhoods with strongest customer engagement
SELECT
    neighbourhood,
    neighbourhood_group AS borough,
    COUNT(*) AS listings,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews,
    ROUND(AVG(reviews_per_month), 2) AS average_reviews_per_month
FROM listings
GROUP BY neighbourhood, neighbourhood_group
HAVING COUNT(*) >= 20
ORDER BY average_reviews DESC
LIMIT 20;


-- 12. Executive customer summary
SELECT
    COUNT(*) AS total_listings,

    SUM(number_of_reviews) AS total_reviews,

    ROUND(
        AVG(number_of_reviews),
        2
    ) AS average_reviews_per_listing,

    ROUND(
        AVG(reviews_per_month),
        2
    ) AS average_reviews_per_month,

    SUM(
        CASE
            WHEN number_of_reviews > 0 THEN 1
            ELSE 0
        END
    ) AS listings_with_reviews

FROM listings;