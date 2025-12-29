# Liquidity Risk and Cash Buffer Analysis

## Project Overview

This project is a decision focused business analytics study that analyses historical cash flow and balance dynamics to assess liquidity risk, cash buffer resilience, and downside stress conditions.

Rather than forecasting future balances, the objective is to understand **how vulnerable the business has been historically** to cash shortfalls, and to translate raw transactional data into clear, actionable liquidity risk signals for management decision making.

The analysis converts daily cash movements into practical risk categories that can support operational and financial planning.

---

## Business Problem

Many organisations track cash balances but lack a structured way to interpret downside risk:

- How often does the business experience cash stress?
- How severe are historical drawdowns from peak balances?
- Are cash shortfalls isolated events or recurring risk patterns?
- When should management treat liquidity conditions as critical?

This project addresses these questions by transforming raw cash data into a **decision ready liquidity risk framework**.

---

## Data and Scope

- Input data consists of daily cash inflows and outflows.
- Data is aggregated to a daily cash balance level using SQL.
- No raw or sensitive financial data is included in this repository.

The focus is on analytical structure and decision logic rather than data volume.

---

## Methodology

The project follows an end to end analytical workflow:

### 1. Data Preparation (SQL)

- Aggregate transactional cash inflows and outflows.
- Compute daily net cash flow.
- Calculate cumulative cash balance over time.

### 2. Analytical Modelling (Python)

- Identify rolling peak cash balances.
- Measure drawdowns as deviations from historical peaks.
- Calculate percentage drawdowns to standardise risk severity.

### 3. Risk Segmentation

Liquidity risk is classified using historical tail risk behaviour:

- **Safe**: Normal operating conditions.
- **Caution**: Elevated liquidity stress based on historical drawdown distribution.
- **Critical**: Worst tail risk events representing severe cash stress.

Thresholds are derived empirically from observed drawdown percentiles rather than arbitrary limits.

---

## Key Findings

- The majority of operating days fall within the **Safe** liquidity zone.
- A small number of days exhibit **Caution** level stress, signalling early warning conditions.
- Rare but material **Critical** drawdown events highlight periods of significant liquidity pressure.
- Critical events are concentrated around identifiable cash outflow spikes rather than gradual erosion.

This demonstrates that liquidity risk is episodic and driven by specific stress events rather than continuous decline.

---

## Business Value

This framework enables decision makers to:

- Monitor liquidity health using intuitive risk labels.
- Identify early warning signals before critical stress occurs.
- Focus management attention on periods with genuine downside risk.
- Support cash buffer and contingency planning using historical evidence.

The approach is lightweight, interpretable, and suitable for integration into operational dashboards or financial controls.

---

## Tools and Technologies

- **Python** (pandas, numpy) for analytical modelling  
- **SQL** for data aggregation and preparation  
- **Jupyter Notebook** for transparent, reproducible analysis  

