-- ============================================================
-- PROJECT 03: HMRC WORKFORCE COST AUTOMATION
-- COST ANALYSIS
-- ============================================================

-- 1. Monthly cost overview
SELECT
    year,
    month,
    ROUND(payroll_cost, 2) AS payroll_cost,
    ROUND(total_staffing_cost, 2) AS total_staffing_cost,
    ROUND(cost_per_fte, 2) AS cost_per_fte
FROM monthly_workforce_kpis
ORDER BY year, month;


-- 2. Average payroll and staffing cost
SELECT
    ROUND(AVG(payroll_cost), 2) AS average_payroll_cost,
    ROUND(AVG(total_staffing_cost), 2) AS average_staffing_cost,
    ROUND(AVG(cost_per_fte), 2) AS average_cost_per_fte
FROM monthly_workforce_kpis;


-- 3. Highest staffing-cost month
SELECT
    year,
    month,
    ROUND(total_staffing_cost, 2) AS total_staffing_cost
FROM monthly_workforce_kpis
ORDER BY total_staffing_cost DESC
LIMIT 5;


-- 4. Highest cost-per-FTE months
SELECT
    year,
    month,
    ROUND(cost_per_fte, 2) AS cost_per_fte
FROM monthly_workforce_kpis
ORDER BY cost_per_fte DESC
LIMIT 5;


-- 5. Payroll cost as % of total staffing cost
SELECT
    year,
    month,
    ROUND(
        payroll_cost * 100.0 /
        NULLIF(total_staffing_cost, 0),
        2
    ) AS payroll_cost_percentage
FROM monthly_workforce_kpis
ORDER BY year, month;