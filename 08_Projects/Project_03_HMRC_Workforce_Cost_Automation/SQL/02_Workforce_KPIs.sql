-- ============================================================
-- PROJECT 03: HMRC WORKFORCE COST AUTOMATION
-- WORKFORCE KPI ANALYSIS
-- ============================================================

-- 1. Monthly workforce overview
SELECT
    year,
    month,
    ROUND(total_workforce, 0) AS total_workforce,
    ROUND(total_fte, 0) AS total_fte,
    ROUND(fte_to_headcount_ratio * 100, 2) AS fte_utilisation_pct
FROM monthly_workforce_kpis
ORDER BY year, month;


-- 2. Average workforce across the period
SELECT
    ROUND(AVG(total_workforce), 0) AS average_workforce,
    ROUND(AVG(total_fte), 0) AS average_fte
FROM monthly_workforce_kpis;


-- 3. Peak workforce month
SELECT
    year,
    month,
    total_workforce,
    total_fte
FROM monthly_workforce_kpis
ORDER BY total_workforce DESC
LIMIT 1;


-- 4. Lowest workforce month
SELECT
    year,
    month,
    total_workforce,
    total_fte
FROM monthly_workforce_kpis
ORDER BY total_workforce ASC
LIMIT 1;


-- 5. Highest cost-per-FTE month
SELECT
    year,
    month,
    ROUND(total_staffing_cost, 2) AS total_staffing_cost,
    ROUND(cost_per_fte, 2) AS cost_per_fte
FROM monthly_workforce_kpis
ORDER BY cost_per_fte DESC
LIMIT 5;