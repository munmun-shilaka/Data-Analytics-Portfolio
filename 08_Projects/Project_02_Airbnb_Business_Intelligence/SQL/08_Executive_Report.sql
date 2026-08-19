-- ============================================================
-- PROJECT 02: NYC AIRBNB BUSINESS INTELLIGENCE
-- EXECUTIVE REPORT
-- ============================================================


-- 1. Executive KPI Summary

SELECT
    COUNT(*) AS total_listings,

    COUNT(DISTINCT host_id) AS total_hosts,

    COUNT(DISTINCT neighbourhood) AS total_neighbourhoods,

    COUNT(DISTINCT neighbourhood_group) AS total_boroughs,

    SUM(number_of_reviews) AS total_reviews,

    ROUND(
        AVG(
            CASE
                WHEN price > 0 THEN price
            END
        ),
        2
    ) AS average_price,

    ROUND(
        AVG(number_of_reviews),
        2
    ) AS average_reviews_per_listing,

    ROUND(
        AVG(
            CASE
                WHEN minimum_nights > 0 THEN minimum_nights
            END
        ),
        2
    ) AS average_minimum_nights

FROM listings;


-- 2. Borough Performance
SELECT
    neighbourhood_group AS borough,
    COUNT(*) AS listings,
    COUNT(DISTINCT host_id) AS hosts,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews,
    ROUND(AVG(minimum_nights), 2) AS average_minimum_nights
FROM listings
WHERE price > 0
GROUP BY neighbourhood_group
ORDER BY listings DESC;


-- 3. Room Type Performance
SELECT
    room_type,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews,
    ROUND(AVG(minimum_nights), 2) AS average_minimum_nights
FROM listings
WHERE price > 0
GROUP BY room_type
ORDER BY listings DESC;


-- 4. Price Segment Performance
SELECT
    CASE
        WHEN price < 100 THEN 'Budget'
        WHEN price < 200 THEN 'Standard'
        WHEN price < 500 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_segment,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews
FROM listings
WHERE price > 0
GROUP BY price_segment
ORDER BY average_price;


-- 5. Top 10 Neighbourhoods by Supply
SELECT
    neighbourhood,
    neighbourhood_group AS borough,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews
FROM listings
GROUP BY neighbourhood, neighbourhood_group
ORDER BY listings DESC
LIMIT 10;


-- 6. Top 10 Neighbourhoods by Customer Engagement
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
LIMIT 10;


-- 7. Large Host Portfolios
SELECT
    host_id,
    host_name,
    COUNT(*) AS listing_count,
    ROUND(AVG(price), 2) AS average_price,
    SUM(number_of_reviews) AS total_reviews
FROM listings
GROUP BY host_id, host_name
HAVING COUNT(*) >= 10
ORDER BY listing_count DESC
LIMIT 10;


-- 8. Availability by Borough
SELECT
    l.neighbourhood_group AS borough,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN c.available = 't' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS availability_rate,
    COUNT(*) AS calendar_records
FROM listings l
JOIN calendar c
    ON l.id = c.listing_id
GROUP BY l.neighbourhood_group
ORDER BY availability_rate DESC;


-- 9. High-Value Customer Engagement Opportunities
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
WHERE price > (
    SELECT AVG(price)
    FROM listings
    WHERE price > 0
)
AND number_of_reviews > (
    SELECT AVG(number_of_reviews)
    FROM listings
)
ORDER BY number_of_reviews DESC
LIMIT 20;


-- 10. Potential Pricing Opportunities
SELECT
    l.neighbourhood_group AS borough,
    l.neighbourhood,
    COUNT(*) AS listings,
    ROUND(AVG(l.price), 2) AS average_price,
    ROUND(AVG(l.number_of_reviews), 2) AS average_reviews
FROM listings l
WHERE l.price > 0
GROUP BY l.neighbourhood_group, l.neighbourhood
HAVING COUNT(*) >= 20
ORDER BY average_reviews DESC;