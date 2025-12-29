-- ======================================================
-- Liquidity Risk & Cash Buffer Analysis
-- SQL Data Preparation Pipeline
-- ======================================================

-- Database
USE finance_decision_analytics;

-- ------------------------------------------------------
-- Tables used in this project
-- ------------------------------------------------------
-- fact_transactions
-- daily_cashflow
-- daily_cash_balance

-- ------------------------------------------------------
-- Schema: daily_cashflow
-- ------------------------------------------------------
-- txn_date            DATE
-- cash_in             DECIMAL(34,2)
-- cash_out            DECIMAL(34,2)
-- net_flow            DECIMAL(34,2)

-- ------------------------------------------------------
-- Schema: daily_cash_balance
-- ------------------------------------------------------
-- txn_date            DATE
-- cash_in             DECIMAL(34,2)
-- cash_out            DECIMAL(34,2)
-- net_flow            DECIMAL(34,2)
-- cumulative_balance  DECIMAL(56,2)

-- ------------------------------------------------------
-- Step 1: Build daily_cashflow
-- Aggregate transactional cash movements to daily level
-- ------------------------------------------------------

-- Example logic:
-- SELECT
--     txn_date,
--     SUM(cash_in)  AS cash_in,
--     SUM(cash_out) AS cash_out,
--     SUM(cash_in - cash_out) AS net_flow
-- FROM fact_transactions
-- GROUP BY txn_date;

-- ------------------------------------------------------
-- Step 2: Build daily_cash_balance
-- Calculate cumulative cash balance using window function
-- ------------------------------------------------------

-- Example logic:
-- SELECT
--     txn_date,
--     cash_in,
--     cash_out,
--     net_flow,
--     SUM(net_flow) OVER (
--         ORDER BY txn_date
--         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--     ) AS cumulative_balance
-- FROM daily_cashflow;

-- ------------------------------------------------------
-- Step 3: Validation checks
-- ------------------------------------------------------

-- Row count
-- SELECT COUNT(*) FROM daily_cash_balance;

-- Date range
-- SELECT MIN(txn_date), MAX(txn_date)
-- FROM daily_cash_balance;

-- Duplicate date check
-- SELECT txn_date, COUNT(*)
-- FROM daily_cash_balance
-- GROUP BY txn_date
-- HAVING COUNT(*) > 1;

-- ------------------------------------------------------
-- Notes
-- ------------------------------------------------------
-- This file documents the analytical SQL pipeline only.
-- No raw data, credentials, or sensitive information
-- are included in this repository.

