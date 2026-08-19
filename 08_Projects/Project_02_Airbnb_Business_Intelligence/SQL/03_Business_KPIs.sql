-- ============================================================
-- PROJECT 02: NYC AIRBNB BUSINESS INTELLIGENCE
-- BUSINESS KPI ANALYSIS
-- ============================================================

-- ============================================================
-- 1. TOTAL LISTINGS
-- ============================================================

SELECT
    COUNT(*) AS total_listings
FROM listings;


-- ============================================================
-- 2. TOTAL UNIQUE HOSTS
-- ============================================================

SELECT
    COUNT(DISTINCT host_id) AS total_hosts
FROM listings;


-- ============================================================
-- 3. TOTAL NEIGHBOURHOODS
-- ============================================================

SELECT
    COUNT(DISTINCT neighbourhood) AS total_neighbourhoods
FROM listings;


-- ============================================================
-- 4. TOTAL BOROUGHS
-- ============================================================

SELECT
    COUNT(DISTINCT neighbourhood_group) AS total_boroughs
FROM listings;


-- ============================================================
-- 5. TOTAL REVIEWS
-- ============================================================

SELECT
    SUM(number_of_reviews) AS total_reviews
FROM listings;


-- ============================================================
-- 6. AVERAGE LISTING PRICE
-- ============================================================

SELECT
    ROUND(AVG(price), 2) AS average_price
FROM listings
WHERE price > 0;


-- ============================================================
-- 7. MEDIAN-LIKE PRICE CHECK
-- SQLite does not have a built-in MEDIAN function.
-- This query returns the middle price position.
-- ============================================================

SELECT
    price AS median_price
FROM listings
WHERE price > 0
ORDER BY price
LIMIT 1
OFFSET (
    SELECT (COUNT(*) - 1) / 2
    FROM listings
    WHERE price > 0
);


-- ============================================================
-- 8. AVERAGE REVIEWS PER LISTING
-- ============================================================

SELECT
    ROUND(AVG(number_of_reviews), 2) AS average_reviews_per_listing
FROM listings;


-- ============================================================
-- 9. AVERAGE MINIMUM NIGHTS
-- ============================================================

SELECT
    ROUND(AVG(minimum_nights), 2) AS average_minimum_nights
FROM listings
WHERE minimum_nights > 0;


-- ============================================================
-- 10. LISTINGS BY BOROUGH
-- ============================================================

SELECT
    neighbourhood_group AS borough,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews
FROM listings
GROUP BY neighbourhood_group
ORDER BY total_listings DESC;


-- ============================================================
-- 11. LISTINGS BY ROOM TYPE
-- ============================================================

SELECT
    room_type,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews
FROM listings
GROUP BY room_type
ORDER BY total_listings DESC;


-- ============================================================
-- 12. PRICE RANGE
-- ============================================================

SELECT
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price,
    ROUND(AVG(price), 2) AS average_price
FROM listings
WHERE price > 0;


-- ============================================================
-- 13. ACTIVE / RECENTLY REVIEWED LISTINGS
-- ============================================================

SELECT
    COUNT(*) AS listings_with_reviews
FROM listings
WHERE number_of_reviews > 0;


-- ============================================================
-- 14. REVIEW COVERAGE
-- ============================================================

SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN number_of_reviews > 0 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS review_coverage_percentage
FROM listings;


-- ============================================================
-- 15. TOP 10 BOROUGHS BY AVERAGE PRICE
-- ============================================================

SELECT
    neighbourhood_group AS borough,
    ROUND(AVG(price), 2) AS average_price
FROM listings
WHERE price > 0
GROUP BY neighbourhood_group
ORDER BY average_price DESC
LIMIT 10;


-- ============================================================
-- 16. TOP 10 NEIGHBOURHOODS BY LISTING COUNT
-- ============================================================

SELECT
    neighbourhood,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS average_price
FROM listings
GROUP BY neighbourhood
ORDER BY total_listings DESC
LIMIT 10;


-- ============================================================
-- 17. TOP 10 NEIGHBOURHOODS BY AVERAGE PRICE
-- Minimum listing threshold avoids tiny-sample distortions.
-- ============================================================

SELECT
    neighbourhood,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS average_price
FROM listings
WHERE price > 0
GROUP BY neighbourhood
HAVING COUNT(*) >= 20
ORDER BY average_price DESC
LIMIT 10;


-- ============================================================
-- 18. EXECUTIVE KPI SUMMARY
-- ============================================================

SELECT
    (SELECT COUNT(*) FROM listings) AS total_listings,

    (SELECT COUNT(DISTINCT host_id)
     FROM listings) AS total_hosts,

    (SELECT COUNT(DISTINCT neighbourhood)
     FROM listings) AS total_neighbourhoods,

    (SELECT COUNT(DISTINCT neighbourhood_group)
     FROM listings) AS total_boroughs,

    (SELECT SUM(number_of_reviews)
     FROM listings) AS total_reviews,

    (SELECT ROUND(AVG(price), 2)
     FROM listings
     WHERE price > 0) AS average_price,

    (SELECT ROUND(AVG(number_of_reviews), 2)
     FROM listings) AS average_reviews_per_listing,

    (SELECT ROUND(AVG(minimum_nights), 2)
     FROM listings
     WHERE minimum_nights > 0) AS average_minimum_nights;
     