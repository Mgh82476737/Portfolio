# Pricing Analytics and Discount Strategy

## Overview  
This project analyses the impact of discounting on profitability using real-world retail transaction data.  
Rather than focusing on dashboards or academic modelling, the objective is to support **pricing decisions** by identifying where discounting drives value and where it silently destroys profit.

The analysis focuses on understanding how discount behaviour affects margins, identifying structurally loss-making products, and evaluating whether simple pricing rules could meaningfully reduce financial risk.

---

## Business Problem  
Many organisations apply discounts to drive volume without fully understanding their impact on profitability.  
While revenue may increase, uncontrolled discounting often leads to hidden losses, especially when applied inconsistently across products or order sizes.

The key business questions addressed are:

- How does discount level affect profitability?  
- Which products consistently generate losses?  
- Can simple pricing rules reduce downside risk without complex modelling?

---

## Dataset Overview  
The dataset contains historical order-level retail transactions, including:

- Sales revenue  
- Profit  
- Discount rate  
- Quantity  
- Product identifiers  
- Order and shipment dates  

The data reflects real operational conditions rather than a clean academic dataset. Missing values, inconsistent records, and structural imperfections were intentionally preserved to reflect real-world decision environments.

---

## Data Quality Assessment  
A structured data quality review identified several issues:

- Approximately 5 percent of records contained missing sales values  
- Date fields required standardisation and validation  
- Duplicate records were present due to missing order-line identifiers  
- Negative profit values existed and were treated as meaningful business signals  

Rather than aggressively removing data, quality issues were documented and addressed through analytical decisions aligned with business logic.

---

## Feature Engineering  
To support pricing and profitability analysis, the following features were created:

- Reconstructed list price (sales before discount)  
- Profit margin for normalised comparison  
- Unit price  
- Discount and loss flags  
- Delivery delay indicators with reliability tagging  

These features enabled consistent comparison across products and order types.

---

## Discount vs Profit Analysis  
Discount levels were grouped into interpretable ranges to examine their relationship with profitability.

Key observations:

- Orders without discounts delivered the most stable profit margins  
- Even small discounts showed early signs of margin erosion  
- Discounts above approximately 20 percent represented a clear structural break  
- High-discount orders were strongly associated with loss-making outcomes  

This analysis demonstrated that aggressive discounting systematically increases financial risk.

---

## Loss-Making Product Analysis  
Loss-making orders were analysed to identify structural patterns rather than isolated incidents.

Findings included:

- A small subset of products accounted for a disproportionate share of total losses  
- Some extreme losses were driven by large, discounted orders rather than recurring issues  
- Normalising profit through margin analysis helped distinguish structural loss-makers from outliers  

This approach ensured that decisions were not driven by noise or one-off events.

---

## Pricing Rule Simulation  
To move from insight to decision support, a simple pricing rule was simulated.

**Scenario:**  
- Discounts above 20 percent are capped  
- Sales volume and cost structure remain unchanged  
- The goal is directional risk assessment rather than precise forecasting  

Using reconstructed pricing and inferred costs, profitability was recalculated under this constraint.

---

## Scenario Results  
The simulation showed that:

- A significant share of losses was driven by excessive discounting  
- Applying a simple discount cap materially improved overall profitability  
- A relatively small number of high-discount orders accounted for most downside risk  

This indicates that basic pricing governance can deliver meaningful impact without complex modelling.

---

## Key Insights  

- Discounting beyond 20 percent materially increases loss risk  
- A small number of transactions often drive the majority of losses  
- Normalised metrics are essential for identifying structurally unprofitable products  
- Simple pricing rules can generate outsized business value  

---

## Limitations  

- The analysis assumes stable demand and cost structures  
- Customer behavioural responses were not modelled  
- Results provide directional insight rather than predictive forecasts  

These limitations are acknowledged to ensure realistic interpretation.

---

## Conclusion  

This project demonstrates how applied pricing analytics can transform imperfect operational data into decision-ready insights.

Rather than focusing on dashboards or complex models, the analysis prioritises clarity, accountability, and practical business impact.

The results support the introduction of lightweight pricing governance as a low-effort, high-impact control mechanism capable of improving profitability without increasing operational complexity.
