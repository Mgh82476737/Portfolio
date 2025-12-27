# HPV Risk Modelling on Real-World Healthcare Data

## Project Overview
This project presents an applied, decision-aware classification pipeline for HPV risk modelling
using real-world healthcare and lifestyle data.

The dataset reflects common challenges in healthcare analytics, including:
- Strong class imbalance
- Missing values
- Noisy and heterogeneous features
- Limited sample size

Rather than optimising for maximum predictive performance, the focus of this project is on
building a transparent and interpretable modelling workflow that supports screening-level
risk assessment and analytical decision-making.

---

## Objective
The primary objective is to demonstrate how meaningful insights and usable risk signals
can be extracted from imperfect healthcare data.

The project emphasises:
- Data quality assessment and cleaning
- Exploratory data analysis to understand bias and structure
- Feature preparation and noise reduction
- Handling class imbalance using weighting and threshold tuning
- Interpreting model outputs in a decision context
- Explicit communication of limitations

This is an applied analytics project, not a clinical diagnostic system.

---

## What This Project Is Not
This project does **not** aim to:
- Build a clinically deployable diagnostic model
- Optimise accuracy at the expense of interpretability
- Apply complex or black-box machine learning techniques
- Claim medical validity or causal inference

All results are intended for exploratory risk assessment and screening-level support only.

---

## Dataset Description
The dataset contains anonymised patient-level lifestyle and health-related variables
used to assess HPV infection risk.

Key characteristics:
- Binary target variable indicating HPV infection status
- Significant imbalance between negative and positive cases
- Mixed feature types including demographic, behavioural, and health indicators
- Missing values in selected features

All modelling decisions explicitly acknowledge these limitations.

---

## Modelling Approach
The modelling pipeline follows a structured, transparent process:

1. **Data validation and cleaning**
   - Identification of missing values
   - Minimal, explainable handling strategies

2. **Exploratory data analysis**
   - Target distribution analysis
   - Feature-level behavioural patterns
   - Bias and sparsity inspection

3. **Baseline model**
   - Logistic Regression as an interpretable baseline
   - Class weighting to address imbalance

4. **Decision threshold analysis**
   - Evaluation at multiple probability thresholds
   - Explicit trade-off analysis between recall and false positives

5. **Evaluation metrics**
   - ROC AUC
   - Average Precision
   - Class-specific precision and recall
   - Confusion matrices interpreted in context

---

## Key Results and Interpretation
The baseline model shows limited overall discriminative power, which is expected given
data quality constraints and class imbalance.

However, threshold analysis demonstrates that:
- Recall for HPV-positive cases can be substantially increased
- This comes at the cost of higher false positive rates
- Such behaviour may be acceptable in screening scenarios where missing positives
  is more costly than additional follow-up checks

This highlights the importance of decision thresholds over raw accuracy in applied settings.

---

## Decision Context
This model is best suited for:
- **Screening-level risk flagging**
- **Exploratory population risk analysis**
- **Supporting further clinical or analytical review**

It is **not** intended to replace clinical judgement or diagnostic testing.

---

## Limitations
- Small sample size limits generalisability
- Self-reported lifestyle variables may introduce bias
- Missing data reduces model stability
- Results are context-specific and not clinically validated

These limitations are intentionally documented and not obscured.

---

## Tools and Libraries
- Python
- pandas
- numpy
- scikit-learn
- matplotlib / seaborn

---
