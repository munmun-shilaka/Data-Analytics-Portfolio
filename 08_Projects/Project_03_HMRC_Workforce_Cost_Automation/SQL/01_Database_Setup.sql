-- ============================================================
-- PROJECT 03: HMRC WORKFORCE COST AUTOMATION
-- DATABASE SETUP
-- ============================================================

DROP TABLE IF EXISTS monthly_workforce_kpis;
DROP TABLE IF EXISTS workforce_exceptions;

CREATE TABLE monthly_workforce_kpis (
    year INTEGER,
    month TEXT,
    total_workforce REAL,
    total_fte REAL,
    payroll_cost REAL,
    total_staffing_cost REAL,
    cost_per_fte REAL,
    fte_to_headcount_ratio REAL,
    workforce_change_pct REAL,
    fte_change_pct REAL,
    staffing_cost_change_pct REAL,
    cost_per_fte_change_pct REAL
);

CREATE TABLE workforce_exceptions (
    year INTEGER,
    month TEXT,
    total_workforce REAL,
    total_fte REAL,
    total_staffing_cost REAL,
    cost_per_fte REAL,
    workforce_change_pct REAL,
    staffing_cost_change_pct REAL,
    cost_per_fte_change_pct REAL
);

SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;
