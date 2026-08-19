-- ============================================================
-- PROJECT 02: NYC AIRBNB BUSINESS INTELLIGENCE
-- HOST PERFORMANCE ANALYSIS
-- ============================================================


-- 1. Total unique hosts
SELECT
    COUNT(DISTINCT host_id) AS total_hosts
FROM listings;


-- 2. Top 20 hosts by number of listings
SELECT
    host_id,
    host_name,
    COUNT(*) AS listing_count,
    ROUND(AVG(price), 2) AS average_price,
    SUM(number_of_reviews) AS total_reviews
FROM listings
GROUP BY host_id, host_name
ORDER BY listing_count DESC
LIMIT 20;


-- 3. Hosts with the highest total reviews
SELECT
    host_id,
    host_name,
    COUNT(*) AS listing_count,
    SUM(number_of_reviews) AS total_reviews,
    ROUND(AVG(price), 2) AS average_price
FROM listings
GROUP BY host_id, host_name
ORDER BY total_reviews DESC
LIMIT 20;


-- 4. Hosts with highest average listing price
-- Minimum 5 listings to avoid small-sample distortion.
SELECT
    host_id,
    host_name,
    COUNT(*) AS listing_count,
    ROUND(AVG(price), 2) AS average_price,
    SUM(number_of_reviews) AS total_reviews
FROM listings
WHERE price > 0
GROUP BY host_id, host_name
HAVING COUNT(*) >= 5
ORDER BY average_price DESC
LIMIT 20;


-- 5. Host portfolio segmentation
SELECT
    CASE
        WHEN listing_count = 1 THEN 'Single Listing'
        WHEN listing_count BETWEEN 2 AND 5 THEN 'Small Portfolio'
        WHEN listing_count BETWEEN 6 AND 20 THEN 'Professional Host'
        ELSE 'Large Property Portfolio'
    END AS host_segment,
    COUNT(*) AS hosts
FROM (
    SELECT
        host_id,
        COUNT(*) AS listing_count
    FROM listings
    GROUP BY host_id
)
GROUP BY host_segment
ORDER BY hosts DESC;


-- 6. Average price by host segment
SELECT
    CASE
        WHEN listing_count = 1 THEN 'Single Listing'
        WHEN listing_count BETWEEN 2 AND 5 THEN 'Small Portfolio'
        WHEN listing_count BETWEEN 6 AND 20 THEN 'Professional Host'
        ELSE 'Large Property Portfolio'
    END AS host_segment,
    COUNT(*) AS hosts,
    ROUND(AVG(average_price), 2) AS segment_average_price
FROM (
    SELECT
        host_id,
        COUNT(*) AS listing_count,
        AVG(price) AS average_price
    FROM listings
    WHERE price > 0
    GROUP BY host_id
)
GROUP BY host_segment
ORDER BY segment_average_price DESC;


-- 7. Top hosts by review engagement
SELECT
    host_id,
    host_name,
    COUNT(*) AS listing_count,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews_per_listing,
    SUM(number_of_reviews) AS total_reviews
FROM listings
GROUP BY host_id, host_name
HAVING COUNT(*) >= 3
ORDER BY average_reviews_per_listing DESC
LIMIT 20;


-- 8. Host performance by borough
SELECT
    neighbourhood_group AS borough,
    COUNT(DISTINCT host_id) AS unique_hosts,
    COUNT(*) AS listings,
    ROUND(
        CAST(COUNT(*) AS REAL) /
        COUNT(DISTINCT host_id),
        2
    ) AS listings_per_host,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(AVG(number_of_reviews), 2) AS average_reviews
FROM listings
GROUP BY neighbourhood_group
ORDER BY listings_per_host DESC;


-- 9. Hosts with large portfolios
SELECT
    host_id,
    host_name,
    COUNT(*) AS listing_count,
    ROUND(AVG(price), 2) AS average_price,
    SUM(number_of_reviews) AS total_reviews
FROM listings
GROUP BY host_id, host_name
HAVING COUNT(*) >= 10
ORDER BY listing_count DESC;


-- 10. Executive host summary
SELECT
    COUNT(DISTINCT host_id) AS total_hosts,

    ROUND(
        AVG(listing_count),
        2
    ) AS average_listings_per_host,

    MAX(listing_count) AS largest_host_portfolio

FROM (
    SELECT
        host_id,
        COUNT(*) AS listing_count
    FROM listings
    GROUP BY host_id
);