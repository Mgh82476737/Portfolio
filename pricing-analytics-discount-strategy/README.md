# Pricing Analytics and Discount Strategy

## Overview
This project analyses the impact of discounting on profitability using real-world retail sales data.
The focus is not on dashboarding or academic exploration, but on decision-oriented pricing analytics.

The analysis investigates how discount levels affect profit, identifies loss-making products,
and simulates a simple pricing governance rule to quantify potential downside risk reduction.

---

## Business Problem
Aggressive and inconsistent discounting can increase sales volume while silently destroying profitability.
In the absence of clear discount governance, organisations may prioritise revenue growth
without understanding where and why losses are occurring.

The objective of this project is to:
- Understand the relationship between discount levels and profit
- Identify products that consistently drive losses
- Evaluate whether basic pricing rules could materially improve profitability

---

## Dataset Overview
The dataset contains historical order-level retail transactions, including:
- Sales revenue
- Profit
- Discount rate
- Quantity
- Product identifiers
- Order and shipment dates

The data reflects real-world imperfections, including missing values and inconsistent records,
making it suitable for applied analytics rather than idealised modelling.

---

## Data Quality Assessment
An initial data quality assessment identified several key issues:

- Approximately 5 percent of records contain missing sales values
- Date fields required type correction and validation
- Duplicate records existed due to missing order line identifiers
- Negative profit values were present and treated as valid business signals rather than errors

Instead of aggressively dropping data, all quality issues were explicitly documented
and handled with analysis-specific decisions.

---

## Feature Engineering
To support pricing and profitability analysis, several analytical features were created:

- Sales before discount (reconstructed list price)
- Profit margin (normalised profitability)
- Unit price
- Discount flags
- Loss flags
- Delivery delay metrics with reliability indicators

These features enabled both absolute and normalised analysis of pricing behaviour.

---

## Discount vs Profit Analysis
Discount rates were grouped into interpretable buckets to analyse their relationship with profitability.

Key observations:
- Orders without discounts showed the highest and most stable profit margins
- Low discounts showed early signs of margin erosion
- Discounts above approximately 20 percent marked a clear structural break
- High-discount orders exhibited sharply increasing loss rates

This analysis established a clear link between aggressive discounting and loss-making behaviour.

---

## Loss-Making Product Analysis
Loss-making orders were isolated to identify products contributing disproportionately to total losses.

Initial results showed that a small number of products dominated total losses,
sometimes driven by only one or two very large orders.
Further inspection revealed two critical factors:

1. A subset of loss records was affected by missing sales values and excluded from pricing analysis
2. Large, high-ticket orders with aggressive discounts could dominate raw loss figures

To address this, loss analysis was normalised using profit margin,
allowing structurally loss-making products to be distinguished
from products affected by isolated outlier orders.

---

## Pricing Rule Simulation
To move from insight to decision support, a pricing rule scenario was simulated.

Scenario:
- Discounts above 20 percent are capped at 20 percent
- Sales volume and cost structure remain unchanged
- The objective is directional risk estimation, not precise forecasting

Using reconstructed list prices and inferred costs, profit was recalculated
under the capped discount scenario.

---

## Scenario Results
The simulation showed that a significant share of losses
was driven by excessive discounting rather than unavoidable cost structure.

Key outcomes:
- Overall profitability improved materially under the discount cap scenario
- A large proportion of evaluated orders experienced improved profit outcomes
- High-discount orders represented a major source of downside risk

This result highlights the potential value of basic discount governance controls.

---

## Key Insights
- Discounting above 20 percent systematically increases loss risk
- A small number of high-value orders can dominate total losses
- Normalised metrics are essential for identifying structurally unprofitable products
- Simple pricing rules can have outsized impact on profitability

---

## Limitations
- The analysis assumes constant sales volume and cost structure
- Customer behaviour changes were not modelled
- Results represent directional insight rather than future prediction

These limitations are explicitly acknowledged to avoid over-interpretation.

---

## Conclusion
This project demonstrates how applied pricing analytics
can convert messy operational data into decision-ready insights.

Rather than focusing on dashboards or model complexity,
the analysis prioritises clarity, interpretability, and practical decision support.

The results support the introduction of basic discount governance
as a low-complexity, high-impact pricing control mechanism.
