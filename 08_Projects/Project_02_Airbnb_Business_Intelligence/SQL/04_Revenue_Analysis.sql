-- ============================================================
-- PROJECT 02: NYC AIRBNB BUSINESS INTELLIGENCE
-- REVENUE & AVAILABILITY ANALYSIS
-- ============================================================


-- ============================================================
-- 1. CALENDAR COVERAGE
-- ============================================================

SELECT
    MIN(date) AS start_date,
    MAX(date) AS end_date,
    COUNT(DISTINCT date) AS calendar_days
FROM calendar;


-- ============================================================
-- 2. TOTAL CALENDAR RECORDS
-- ============================================================

SELECT
    COUNT(*) AS calendar_records
FROM calendar;


-- ============================================================
-- 3. AVAILABLE VS UNAVAILABLE NIGHTS
-- ============================================================

SELECT
    available,
    COUNT(*) AS nights
FROM calendar
GROUP BY available
ORDER BY available DESC;


-- ============================================================
-- 4. AVAILABILITY RATE
-- ============================================================

SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN available = 't' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS availability_rate_percentage
FROM calendar;


-- ============================================================
-- 5. AVERAGE LISTING PRICE BY BOROUGH
-- ============================================================

SELECT
    neighbourhood_group AS borough,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS average_price
FROM listings
WHERE price > 0
GROUP BY neighbourhood_group
ORDER BY average_price DESC;


-- ============================================================
-- 6. MEDIAN PRICE BY BOROUGH
-- ============================================================

WITH ranked_prices AS (
    SELECT
        neighbourhood_group,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY neighbourhood_group
            ORDER BY price
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY neighbourhood_group
        ) AS total_rows
    FROM listings
    WHERE price > 0
)

SELECT
    neighbourhood_group AS borough,
    ROUND(AVG(price), 2) AS median_price
FROM ranked_prices
WHERE rn IN (
    (total_rows + 1) / 2,
    (total_rows + 2) / 2
)
GROUP BY neighbourhood_group
ORDER BY median_price DESC;


-- ============================================================
-- 7. LISTING SUPPLY BY BOROUGH
-- ============================================================

SELECT
    neighbourhood_group AS borough,
    COUNT(*) AS total_listings,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM listings),
        2
    ) AS listing_share_percentage
FROM listings
GROUP BY neighbourhood_group
ORDER BY total_listings DESC;


-- ============================================================
-- 8. AVAILABLE NIGHTS BY BOROUGH
-- ============================================================

SELECT
    l.neighbourhood_group AS borough,

    SUM(
        CASE
            WHEN c.available = 't' THEN 1
            ELSE 0
        END
    ) AS available_nights,

    COUNT(*) AS total_calendar_nights,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN c.available = 't' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS availability_rate
FROM listings l
JOIN calendar c
    ON l.id = c.listing_id
GROUP BY l.neighbourhood_group
ORDER BY availability_rate DESC;


-- ============================================================
-- 9. AVERAGE PRICE + AVAILABILITY BY BOROUGH
-- ============================================================

WITH availability AS (
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
        ) AS availability_rate
    FROM listings l
    JOIN calendar c
        ON l.id = c.listing_id
    GROUP BY l.neighbourhood_group
)

SELECT
    l.neighbourhood_group AS borough,
    COUNT(DISTINCT l.id) AS listings,
    ROUND(AVG(l.price), 2) AS average_price,
    a.availability_rate
FROM listings l
JOIN availability a
    ON l.neighbourhood_group = a.borough
WHERE l.price > 0
GROUP BY l.neighbourhood_group, a.availability_rate
ORDER BY average_price DESC;


-- ============================================================
-- 10. TOP 10 NEIGHBOURHOODS BY PRICE
-- Minimum 20 listings to reduce small-sample distortion.
-- ============================================================

SELECT
    neighbourhood,
    neighbourhood_group AS borough,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS average_price
FROM listings
WHERE price > 0
GROUP BY neighbourhood, neighbourhood_group
HAVING COUNT(*) >= 20
ORDER BY average_price DESC
LIMIT 10;


-- ============================================================
-- 11. TOP 10 NEIGHBOURHOODS BY LISTING SUPPLY
-- ============================================================

SELECT
    neighbourhood,
    neighbourhood_group AS borough,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS average_price
FROM listings
GROUP BY neighbourhood, neighbourhood_group
ORDER BY total_listings DESC
LIMIT 10;


-- ============================================================
-- 12. PRICE SEGMENT DISTRIBUTION
-- ============================================================

SELECT
    CASE
        WHEN price < 100 THEN 'Budget'
        WHEN price < 200 THEN 'Standard'
        WHEN price < 500 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_segment,

    COUNT(*) AS listings,

    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM listings WHERE price > 0),
        2
    ) AS listing_share_percentage

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


-- ============================================================
-- 13. ESTIMATED ANNUAL PRICE VALUE
-- This is NOT Airbnb revenue.
-- It represents annualised listing-price value assuming
-- a full 365 nights at the listed nightly price.
-- ============================================================

SELECT
    neighbourhood_group AS borough,
    ROUND(
        SUM(price * 365),
        2
    ) AS annualised_price_value
FROM listings
WHERE price > 0
GROUP BY neighbourhood_group
ORDER BY annualised_price_value DESC;


-- ============================================================
-- 14. EXECUTIVE REVENUE / MARKET SUMMARY
-- ============================================================

SELECT
    l.neighbourhood_group AS borough,

    COUNT(*) AS total_listings,

    ROUND(AVG(l.price), 2) AS average_price,

    ROUND(AVG(l.number_of_reviews), 2) AS average_reviews,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN c.available = 't' THEN 1
                ELSE 0
            END
        ) / COUNT(c.listing_id),
        2
    ) AS availability_rate

FROM listings l
LEFT JOIN calendar c
    ON l.id = c.listing_id

WHERE l.price > 0

GROUP BY l.neighbourhood_group

ORDER BY average_price DESC;