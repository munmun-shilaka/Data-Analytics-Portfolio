-- ============================================================
-- PROJECT 03: HMRC WORKFORCE COST AUTOMATION
-- EXCEPTION REPORT
-- ============================================================

-- 1. All material exceptions
SELECT
    year,
    month,
    ROUND(total_workforce, 0) AS total_workforce,
    ROUND(total_staffing_cost, 2) AS total_staffing_cost,
    ROUND(cost_per_fte, 2) AS cost_per_fte,
    ROUND(workforce_change_pct, 2) AS workforce_change_pct,
    ROUND(staffing_cost_change_pct, 2) AS staffing_cost_change_pct,
    ROUND(cost_per_fte_change_pct, 2) AS cost_per_fte_change_pct
FROM monthly_workforce_kpis
WHERE
       ABS(workforce_change_pct) >= 2
    OR ABS(staffing_cost_change_pct) >= 5
    OR ABS(cost_per_fte_change_pct) >= 3
ORDER BY year, month;


-- 2. Highest-risk exceptions
SELECT
    year,
    month,
    ROUND(workforce_change_pct, 2) AS workforce_change_pct,
    ROUND(staffing_cost_change_pct, 2) AS staffing_cost_change_pct,
    ROUND(cost_per_fte_change_pct, 2) AS cost_per_fte_change_pct
FROM monthly_workforce_kpis
WHERE
       ABS(workforce_change_pct) >= 2
    OR ABS(staffing_cost_change_pct) >= 5
    OR ABS(cost_per_fte_change_pct) >= 3
ORDER BY
    ABS(staffing_cost_change_pct)
    + ABS(workforce_change_pct)
    + ABS(cost_per_fte_change_pct) DESC
LIMIT 10;


-- 3. Exception count
SELECT
    COUNT(*) AS total_exceptions
FROM monthly_workforce_kpis
WHERE
       ABS(workforce_change_pct) >= 2
    OR ABS(staffing_cost_change_pct) >= 5
    OR ABS(cost_per_fte_change_pct) >= 3;