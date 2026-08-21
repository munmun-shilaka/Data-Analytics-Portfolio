-- ============================================================
-- PROJECT 03: HMRC WORKFORCE COST AUTOMATION
-- TREND ANALYSIS
-- ============================================================

-- 1. Workforce movement by month
SELECT
    year,
    month,
    ROUND(total_workforce, 0) AS total_workforce,
    ROUND(workforce_change_pct, 2) AS workforce_change_pct
FROM monthly_workforce_kpis
ORDER BY year, month;


-- 2. FTE movement by month
SELECT
    year,
    month,
    ROUND(total_fte, 0) AS total_fte,
    ROUND(fte_change_pct, 2) AS fte_change_pct
FROM monthly_workforce_kpis
ORDER BY year, month;


-- 3. Staffing-cost movement
SELECT
    year,
    month,
    ROUND(total_staffing_cost, 2) AS total_staffing_cost,
    ROUND(staffing_cost_change_pct, 2) AS staffing_cost_change_pct
FROM monthly_workforce_kpis
ORDER BY year, month;


-- 4. Largest workforce increases
SELECT
    year,
    month,
    ROUND(total_workforce, 0) AS total_workforce,
    ROUND(workforce_change_pct, 2) AS workforce_change_pct
FROM monthly_workforce_kpis
WHERE workforce_change_pct IS NOT NULL
ORDER BY workforce_change_pct DESC
LIMIT 5;


-- 5. Largest workforce decreases
SELECT
    year,
    month,
    ROUND(total_workforce, 0) AS total_workforce,
    ROUND(workforce_change_pct, 2) AS workforce_change_pct
FROM monthly_workforce_kpis
WHERE workforce_change_pct IS NOT NULL
ORDER BY workforce_change_pct ASC
LIMIT 5;


-- 6. Largest staffing-cost increases
SELECT
    year,
    month,
    ROUND(total_staffing_cost, 2) AS total_staffing_cost,
    ROUND(staffing_cost_change_pct, 2) AS staffing_cost_change_pct
FROM monthly_workforce_kpis
WHERE staffing_cost_change_pct IS NOT NULL
ORDER BY staffing_cost_change_pct DESC
LIMIT 5;