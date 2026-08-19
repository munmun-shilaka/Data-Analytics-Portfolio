-- ============================================================
-- PROJECT 02: NYC AIRBNB BUSINESS INTELLIGENCE
-- DATABASE SETUP & VALIDATION
-- ============================================================

-- 1. Check available tables
SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;


-- 2. Check listings table structure
PRAGMA table_info(listings);


-- 3. Check reviews table structure
PRAGMA table_info(reviews);


-- 4. Check neighbourhoods table structure
PRAGMA table_info(neighbourhoods);


-- 5. Validate row counts
SELECT 'listings' AS table_name, COUNT(*) AS row_count
FROM listings

UNION ALL

SELECT 'reviews', COUNT(*)
FROM reviews

UNION ALL

SELECT 'neighbourhoods', COUNT(*)
FROM neighbourhoods;


-- 6. Preview listings
SELECT *
FROM listings
LIMIT 10;


-- 7. Preview reviews
SELECT *
FROM reviews
LIMIT 10;


-- 8. Preview neighbourhoods
SELECT *
FROM neighbourhoods
LIMIT 10;