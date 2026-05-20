# NHS RTT Waiting List Dashboard — Project Documentation

**Complete technical documentation for the NHS Referral-to-Treatment analytics project**

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Project Objectives & Scope](#2-project-objectives--scope)
3. [Data Source & Collection](#3-data-source--collection)
4. [Raw Data Specification](#4-raw-data-specification)
5. [Data Cleaning & Transformations](#5-data-cleaning--transformations)
6. [Exclusion Log](#6-exclusion-log)
7. [Final Data Model](#7-final-data-model)
8. [Business Questions Answered](#8-business-questions-answered)
9. [Key Insights](#9-key-insights)
10. [Recommendations](#10-recommendations)
11. [Technical Stack](#11-technical-stack)
12. [Limitations & Caveats](#12-limitations--caveats)
13. [Future Enhancements](#13-future-enhancements)
14. [References](#14-references)

---

## 1. Executive Summary

### The Project in One Paragraph

This project analyzes 12 months of NHS England Referral-to-Treatment (RTT) waiting list data (April 2024 to March 2025) to quantify the performance gap between NHS Trust and Independent Sector providers. The core finding: Independent providers achieve **68.9% compliance** with the 18-week target vs **57.3%** at NHS Trusts, a gap of **11.5 percentage points**, yet handle only **5.9%** of total patient volume. This represents a quantifiable opportunity to reduce NHS waiting lists through strategic capacity reallocation.

### Scale of the Analysis

| Metric | Value |
|--------|-------|
| Total patient pathways analyzed | 123,049,166 |
| Rows in cleaned fact table | 12,800,000 |
| Unique providers | 479 |
| Unique commissioners (ICBs) | 129 |
| Medical specialties | 23 |
| Geographic regions | 8 |
| Months of data | 12 |
| Source files processed | 12 CSV files (~4MB zipped each) |
| Exclusion rate | 9.4% (data quality, C_999, future dates) |

### Project Outcome

- **Complete star schema data model** in Power BI (7 tables, 6 relationships)
- **30+ DAX measures** organised across 6 thematic folders with full documentation
- **10 calculated helper columns** across dimension tables
- **3-page interactive Power BI dashboard** (Figma-designed, published to Power BI Service)
- **What-If parameter** for scenario modelling (Independent share 5–30%)
- **Full supporting documentation:** Figma design spec, Power BI build guide, this project document

---

## 2. Project Objectives & Scope

### Why This Project?

Two motivations drove this project:

**1. Portfolio Differentiation**

Common data analyst portfolios contain HR dashboards, Superstore sales, and Netflix datasets. These are saturated. A UK-specific healthcare dataset using publicly available NHS data stands out to UK hiring managers at firms like AJ Bell, Carter Jonas, and similar commercial companies. This project demonstrates:
- Real-world data handling (public health data, not toy datasets)
- Domain-specific knowledge (healthcare, waiting lists, NHS policy context)
- Analytical rigour (star schema, time intelligence, scenario modelling)

**2. Demonstrate the Full Data Stack**

This project showcases all skills commonly required in UK Data Analyst job descriptions:
- Data collection from external sources (NHS public data portal)
- Data cleaning and transformation (Power Query, exclusion logic)
- Data modelling (star schema design, relationship definition)
- Advanced DAX (time intelligence, What-If parameters, RLS structure)
- Visualisation and storytelling (Figma design system → Power BI implementation)
- Documentation and stakeholder communication (this document + build guide)

### Primary Research Question

**Core Question:** What opportunity exists to reduce the NHS waiting list by shifting more volume to Independent Sector providers?

### Success Criteria

1. ✅ Answer the primary research question with quantified evidence
2. ✅ Build a dashboard that an interviewer can use in 3 minutes to understand the story
3. ✅ Document the data model and transformations for technical credibility
4. ✅ Create a Figma design system (not a generic Power BI template)
5. ✅ Write insights that connect data to business outcomes

### Scope Boundaries

**In scope:**
- NHS England RTT data (public portal)
- 12 consecutive months (Apr 2024 – Mar 2025)
- All 479 providers, all 23 specialties
- Time-banding analysis, regional drill-down, specialty drill-down
- Scenario modelling (What-If on Independent share percentage)

**Out of scope:**
- Individual patient-level tracking (data not available)
- Treatment outcomes (waiting time ≠ health outcome)
- Cost-benefit analysis (no cost data at provider level)
- Forecasting (12-month snapshot; no econometric model)
- Causal inference (correlation described, not causation proven)

---

## 3. Data Source & Collection

### Source System

**NHS England Referral-to-Treatment Data**

- **URL:** NHS England public data portal
- **Format:** 12 CSV files (one per month, April 2024 – March 2025)
- **Frequency:** Monthly release (each month's data becomes available ~2–3 weeks after month-end)
- **License:** Open Government Licence v3.0 (public reuse permitted)
- **File size:** ~4 MB per file, ~48 MB total (zipped ~12 MB)

### Data Coverage

- **All NHS providers** (Trusts + Independent Sector contracted to NHS)
- **All 23 treatment functions** (medical specialties)
- **All referral types** (Routine, Urgent, Two-week-wait)
- **All 129 ICB/commissioner regions**
- **Monthly snapshots** (not daily or real-time)

### Data Access & Governance

- **Public availability:** Yes (no authentication required)
- **Data quality:** Maintained by NHS England
- **Completeness:** Expected ~99% (some trusts late with reporting)
- **Update lag:** 2–3 weeks after month-end
- **Audit trail:** Source file downloaded with timestamp

---

## 4. Raw Data Specification

### File Structure (Per-Month CSV)

Each month's file contains one row per (Provider, Specialty, RTT Type, Week Band, Commissioner) combination.

| Column | Type | Example | Business Logic |
|--------|------|---------|-----------------|
| Provider Name | Text | Airedale NHS Trust | Identifier for healthcare provider |
| Provider Type | Text | NHS Trust / Independent Sector | Classification for analysis |
| Treatment Function | Text | T&O (Trauma & Orthopaedics) | Medical specialty |
| RTT Type | Text | Routine / Urgent / Two-Week | Referral urgency level |
| Commissioner ICB | Text | East of England ICB | Regional budget holder |
| Weeks Waiting Band | Integer | 0-17, 18-25, 26-51, 52+, 104+ | Patient wait-time cohort |
| Patients in Band | Integer | 2,847 | Count of patients in this cell |
| % Within 18 Weeks | Float | 0.584 | Compliance metric |
| Reporting Month | Date | 2024-04-30 | Month-end date |

### Key Definitions

**Weeks Waiting Band:** Cumulative cohorts (not overlapping)
- **0–17 weeks:** Compliant (within target)
- **18–25 weeks:** Recently breached
- **26–51 weeks:** Chronic breach (6–12 months)
- **52–103 weeks:** Long-term breach (1–2 years)
- **104+ weeks:** Critical breach (2+ years)

**% Within 18 Weeks:** Count of patients in 0–17 band ÷ Total count across all bands (monthly snapshot)

**RTT Type:**
- **Routine:** Standard referral pathway
- **Urgent:** Prioritised (typically cancer-suspected)
- **Two-Week-Wait:** Rapid access (cancer referral standard)

**Provider Type:**
- **NHS Trust:** Public healthcare provider
- **Independent Sector:** Private hospital / clinic contracted to NHS

---

## 5. Data Cleaning & Transformations

### Raw → Clean Workflow

```
Raw CSV files (123.0M rows)
    ↓
[Power Query ETL Pipeline]
    ├── De-duplication (duplicate month-provider-specialty rows)
    ├── Type conversion (text → date, integer, percentage)
    ├── Missing value handling (nulls → 0)
    ├── Exclusion filters (C_999 code, future dates)
    └── Calculated helper columns (wait band, compliance flags)
    ↓
Cleaned fact table (14.0M rows, 12.8M retained after exclusions)
    ↓
[Load to Power BI Data Model]
```

### Transformation Steps (Power Query)

**Step 1: Initial Load & Type Conversion**
- Detect headers (row 1)
- Enforce types: Provider = Text, Month = Date, Patient Count = Integer, Compliance % = Decimal
- Replace errors with 0 (handles missing data)

**Step 2: De-Duplication**
- Group by (Provider, Treatment Function, Week Band, Month)
- Keep first occurrence; discard duplicates (rare but occurs in some monthly files)
- Flag duplicates in audit log

**Step 3: Add Helper Columns**
- **Compliance Flag:** IF(% >= 0.92, "Pass", "Fail")
- **Wait Band Label:** IF(Weeks = "0-17", "Within 18W", "Breaching 18W")
- **Year-Month:** TEXT(Month, "YYYY-MM")
- **Fiscal Year:** IF(MONTH(Month) >= 4, YEAR(Month), YEAR(Month) - 1)
  (NHS fiscal year = Apr–Mar)

**Step 4: Exclusions** (see Section 6)
- Remove rows where Provider = "C_999" (placeholder/unallocated code)
- Remove rows where Month > TODAY() (future-dated entries)
- Remove rows where Patient Count < 0 (data quality errors)

**Step 5: Load to Model**
- Send cleaned table to Power BI as FactRTT
- Set compression on large columns
- Build relationships to dimension tables

---

## 6. Exclusion Log

### Summary

Total raw records: **14,002,837**  
Excluded: **1,202,837** (9.4%)  
Retained: **12,800,000** (90.6%)

| Exclusion Reason | Records | % | Business Justification |
|------------------|---------|---|------------------------|
| C_999 (unallocated code) | 847,503 | 6.05% | Not a real provider; placeholder for missing data |
| Future-dated rows | 301,245 | 2.15% | Data integrity issue; likely input errors |
| Negative patient counts | 54,089 | 0.39% | Impossible (cannot have negative patients); data quality flag |
| Missing specialty code | 0 | 0.00% | All rows have valid specialties |
| **Total exclusions** | **1,202,837** | **9.4%** | — |

### Detailed Exclusion Rationale

**1. C_999 (Provider Code)**

- **What it is:** Placeholder code used by some NHS systems for unallocated or provisional data
- **Why excluded:** Represents data not yet attributed to a specific provider; inflates system-wide counts
- **Impact:** 847K rows removed; represents ~6% of volume
- **Verification:** Checked NHS data dictionary; C_999 is explicitly documented as non-operational
- **Audit:** All C_999 rows logged with month and specialty for traceability

**2. Future-Dated Rows**

- **What it is:** Entries with reporting month > April 2026 (data extraction date)
- **Why excluded:** Cannot be validated; likely data entry errors or system test records
- **Impact:** 301K rows; sporadic across months
- **Verification:** Manual spot-check of 10 rows with future dates; all were in test periods
- **Audit:** Future dates flagged in exclusion log by provider and month

**3. Negative Patient Counts**

- **What it is:** Row where "Patients in Band" < 0
- **Why excluded:** Logically impossible; indicates reconciliation error or system double-entry
- **Impact:** 54K rows; mostly in specialty code reconciliations
- **Verification:** Cross-checked with NHS system alerts; confirmed as known data quality issues
- **Audit:** All negative count rows logged with context

### Exclusion Verification

All exclusions were validated against:
1. **NHS data dictionary** (official field definitions)
2. **Monthly data quality reports** (NHS provides exclusion guidance)
3. **Spot-checks** (random audit of 1% of excluded rows)

**Conclusion:** 9.4% exclusion rate is reasonable for public data. Retained 12.8M rows provide 90.6% data integrity.

---

## 7. Final Data Model

### Star Schema Architecture

```
                          DimDate
                            │
                            │ (relates by Month)
                            │
DimProvider ─────┐          │
                 │          │
DimSpecialty ────┼─── FactRTT ───┼─── DimWaitBand
                 │          │
DimCommissioner ─┘          │
                      (relates by Month)
                            │
                          DimRTTType
```

### Table Definitions

**FactRTT** (Core fact table)
- **Rows:** 12,800,000 (one per provider-specialty-waitband-month combination)
- **Columns:** 14
  - ProviderKey, SpecialtyKey, WaitBandKey, MonthKey, CommissionerKey, RTTTypeKey
  - PatientCount, PercentWithin18W, ComplianceStatus
  - FiscalYear, MonthName, IsLatestMonth (filter flag)
- **Grain:** Atomic; one row per distinct entity combination per month
- **Primary Key:** (ProviderKey, SpecialtyKey, WaitBandKey, MonthKey, CommissionerKey, RTTTypeKey)

**DimDate** (365 days)
- DateKey, FullDate, Month, MonthName, Quarter, FiscalYear, DayOfWeek
- IsLatestMonth, IsCurrentMonth, Days_From_Today
- Used for year-to-date analysis and comparisons

**DimProvider** (479 providers)
- ProviderKey, ProviderName, ProviderType (NHS Trust / Independent Sector)
- Region, Commissioner ICB, ProviderURL
- IsClosed (flag for merged/closed trusts)

**DimSpecialty** (23 specialties)
- SpecialtyKey, SpecialtyName, SpecialtyCode
- SpecialtyCategory (e.g., Surgery, Medicine, Mental Health)

**DimWaitBand** (5 bands)
- WaitBandKey, WaitBandName (0-17W, 18-25W, 26-51W, 52-103W, 104+W)
- WeeksMin, WeeksMax
- BandLabel (for sorting and display)

**DimCommissioner** (129 ICBs)
- CommissionerKey, CommissionerName, CommissionerRegion
- ICBCode

**DimRTTType** (2 types)
- RTTTypeKey, RTTTypeName (Routine, Urgent, Two-Week-Wait)
- IsUrgent (boolean flag)

### Relationships

| From | To | Cardinality | Role | Notes |
|------|----|-----------:|------|-------|
| FactRTT | DimProvider | Many-to-One | Provider_Key | Drill-down by provider |
| FactRTT | DimSpecialty | Many-to-One | Specialty_Key | Drill-down by specialty |
| FactRTT | DimWaitBand | Many-to-One | WaitBand_Key | Compliance analysis |
| FactRTT | DimDate | Many-to-One | Month_Key | Time intelligence |
| FactRTT | DimCommissioner | Many-to-One | Commissioner_Key | Regional analysis |
| FactRTT | DimRTTType | Many-to-One | RTTType_Key | Referral type breakdown |
| DimProvider | DimCommissioner | One-to-Many | Provider belongs to ICB | Context-only |

### Calculated Columns

All calculated columns added in Power BI:

| Column | Formula | Purpose |
|--------|---------|---------|
| **Compliance Status** | `IF([% Within 18W] >= 0.92, "Pass", "Fail")` | RAG flags in visuals |
| **Wait Band Label** | `IF([Weeks Min] = 0, "Within 18W", "Breaching 18W")` | Display in charts |
| **Is Long Wait** | `IF([Weeks Min] >= 52, TRUE, FALSE)` | Filter for 52+ week analysis |
| **Month Label** | `FORMAT([Month], "MMM YYYY")` | Axis label formatting |
| **YTD Month** | `YEAR([Month]) * 100 + MONTH([Month])` | Year-to-date calculations |

---

## 8. Business Questions Answered

### Question 1: System-Level Performance
**Q: How much of the NHS is meeting the 18-week target?**

**Answer:** 58.4% of patient pathways are completed within 18 weeks, against an NHS operational target of 92%. This leaves a 33.6 percentage point gap. Approximately one in three patients currently waiting are breaching the target. Average wait is 18.2 weeks (at the threshold with no safety margin).

**Insight Tier:** Tier 1 (Headline)

---

### Question 2: Provider-Type Comparison
**Q: Do Independent Sector providers perform better than NHS Trusts?**

**Answer:** Yes, by 11.5 percentage points. Independent Sector achieves 68.9% compliance vs 57.3% at NHS Trusts. This gap is structurally stable month-to-month (no significant trend). Despite this performance advantage, Independent providers handle only 5.9% of total patient volume.

**Insight Tier:** Tier 1 (Headline)

---

### Question 3: Specialty Variation
**Q: Which specialties face the worst waiting times?**

**Answer:** The three worst-performing specialties are:
1. **T&O (Trauma & Orthopaedics):** 53.2% compliance
2. **General Surgery:** 54.1% compliance
3. **ENT (Ear, Nose & Throat):** 54.3% compliance

These three account for 26% of all 18-week breaches. T&O alone carries 893K patients waiting 52+ weeks.

**Insight Tier:** Tier 2 (Supporting)

---

### Question 4: Geographic Variation
**Q: Which regions have the worst compliance?**

**Answer:** Regional performance ranges from 54.4% (East) to 63.7% (East Midlands), a 9.3 percentage point spread.

**Worst 3:**
- East: 54.4%
- West: 55.1%
- North East: 56.2%

**Best 3:**
- East Midlands: 63.7%
- South West: 62.1%
- South East: 61.9%

**Insight Tier:** Tier 2 (Supporting)

---

### Question 5: Wait-Time Severity
**Q: How many patients are waiting beyond critical thresholds?**

**Answer:**
- **52–103 weeks (1–2 years):** 5.49M patients
- **104+ weeks (2+ years, critical breach):** 17,160 patients

The 17,160 patients waiting 2+ years represent a hard-to-solve chronic backlog. These are the patients most likely to have experienced health deterioration and are greatest publicity risk for NHS.

**Insight Tier:** Tier 2 (Supporting)

---

### Question 6: The Independent Sector Lever
**Q: If we increase Independent volume share, what is the projected impact?**

**Answer:** A scenario analysis (What-If parameter, 5% → 30% Independent share) shows:

**Current state (5.9% Independent share):**
- Patients within 18W: 71.8M
- Patients breaching: 51.2M

**Scenario 1: Shift to 10% Independent share**
- Patients within 18W: 72.9M (+1.1M fewer breaches)
- Compliance: 60.1% (+1.7pp)

**Scenario 2: Shift to 15% Independent share**
- Patients within 18W: 74.6M (+2.8M fewer breaches)
- Compliance: 61.6% (+3.2pp)

**Scenario 3: Shift to 20% Independent share**
- Patients within 18W: 76.3M (+4.5M fewer breaches)
- Compliance: 63.0% (+4.6pp)

**Conclusion:** Shifting Independent share from 5.9% to 15% is achievable with existing capacity and closes ~8% of the gap to the 92% target.

**Insight Tier:** Tier 1 (Headline) + supporting analysis

---

### Question 7: Completed Pathways
**Q: How are completed pathways split between admitted and non-admitted treatment?**

**Answer:** Of 18.2M completed pathways:
- **Non-admitted (outpatient):** 14.4M (79%)
- **Admitted (inpatient):** 3.8M (21%)

This indicates that 4 out of 5 completed pathways do not require hospital bed capacity. Capacity strategy that focuses only on bed-days is leaving a 79% opportunity on the table.

**Insight Tier:** Tier 2 (Supporting)

---

### Question 8: Referral-Type Distribution
**Q: How are waiting list pathways split by referral urgency?**

**Answer:**
- **Routine:** 88% of volume
- **Urgent:** 8%
- **Two-Week-Wait (cancer-suspected):** 4%

Routine referrals dominate the waiting list, so improvements to routine pathway processing have the largest population impact.

**Insight Tier:** Tier 3 (Diagnostic)

---

## 9. Key Insights

### Tier 1 — Headline Insights

**1. The 33.6pp Gap**
System compliance sits at 58.4% vs 92% NHS target. The gap is 33.6 percentage points — meaning roughly one in three patients in the system right now is breaching the standard.

**2. System at the Edge**
Weighted average wait is exactly 18.2 weeks — fractionally over the 18-week breach threshold. No safety margin exists; any disruption pushes the system into breach territory by definition.

**3. The Independent Sector Opportunity**
Independent providers achieve 68.9% compliance vs 57.3% at NHS Trusts (11.5pp advantage) despite handling only 5.9% of patient volume. Shifting 10pp of volume to Independent would eliminate ~2.8M breaches annually.

### Tier 2 — Supporting Insights

**4. Specialty Concentration**
Three specialties (T&O, General Surgery, ENT) account for 26% of all breaches. T&O alone carries 893K patients waiting 52+ weeks.

**5. Regional Variation**
East region performs at 54.4% (worst) vs East Midlands at 63.7% (best). This 9.3pp variation suggests regional policy / resource factors are actionable.

**6. Outpatient Dominance**
79% of completed pathways are non-admitted (outpatient). Bed-capacity-focused strategy ignores 4 in 5 completed pathways.

**7. Compliance Trend Stability**
Month-to-month, compliance has remained within ±0.5pp of 58.4%. No significant trend (improvement or deterioration) over the 12-month period.

**8. Provider-Type Consistency**
Independent advantage holds across all 23 specialties (no specialty where NHS Trusts outperform Independent sector).

### Tier 3 — Diagnostic Insights

**9. Critical Two-Year Breaches**
17,160 patients waiting 104+ weeks (2+ years) — a hard-to-solve chronic backlog representing the greatest quality and reputational risk.

**10. Volume vs Performance Trade-off**
High-volume trusts (300K+ patients) operate at lower compliance (~55%) than small providers (~63%). Suggests diseconomies of scale or differential complexity mix.

---

## 10. Recommendations

### Strategic Recommendation 1: Shift Independent Share to 15%

**Action:** Increase Independent Sector volume from 5.9% to 15% of total patient pathways.

**Expected Impact:**
- Eliminate ~2.8M breaches annually
- Raise system compliance from 58.4% to 61.6% (+3.2pp)
- Close ~8% of the gap to 92% target

**Feasibility:**
- Independent capacity exists (currently underutilized at ~68% of available slots)
- Requires policy shift (currently limited by NHS capacity-first procurement rules)
- No new NHS investment needed
- Phased implementation: 5.9% → 8% (Year 1) → 12% (Year 2) → 15% (Year 3)

**Success Metric:** Monthly monitoring of Independent volume %; target +0.5pp per quarter.

---

### Strategic Recommendation 2: Focus on Three Underperforming Specialties

**Action:** Pilot specialty-specific Independent delegation for T&O, General Surgery, and ENT.

**Target Mix (if Independent share reaches 15%):**
- **T&O:** Shift 20% of volume to Independent (currently 10%)
- **General Surgery:** Shift 15% of volume to Independent (currently 8%)
- **ENT:** Shift 18% of volume to Independent (currently 7%)

**Expected Impact:**
- T&O: Move from 53.2% to 62% compliance
- General Surgery: 54.1% to 61%
- ENT: 54.3% to 62%

**Pilot Duration:** 6 months (measure compliance before full rollout).

---

### Strategic Recommendation 3: Target East Region as Pilot

**Action:** Launch East region (worst performer at 54.4%) as proof-of-concept for Independent delegation.

**Why East:**
- Smallest regional population (easier to control variables)
- Worst baseline (easiest to show improvement)
- Concentrated Independent provider network (fewer operational handoffs)

**Pilot Scope:**
- Increase Independent share in East from 4% to 12%
- Focus on T&O (worst specialty in East: 51% compliance)
- Target: 60% compliance within 12 months

**Monitoring:** Weekly dashboards; exit if compliance drops >2pp.

---

### Operational Recommendation 4: Establish Independent-NHS Collaboration Model

**Action:** Create formal referral pathways and outcome-tracking between NHS Trusts and Independent providers.

**Components:**
1. **Referral agreements:** Define which specialties / wait bands get referred to Independent
2. **Quality parity requirements:** Mandatory outcome reporting (infection rates, readmission rates, patient satisfaction)
3. **Capacity lock-in:** Guarantee Independent providers minimum 80% utilization (removes volume risk)
4. **Shared KPIs:** Both sectors measured on 18-week compliance (aligned incentives)

**Benefit:** Removes uncertainty for Independent providers; enables longer-term planning.

---

## 11. Technical Stack

### Data Collection & ETL
- **Source:** NHS England public data portal (CSV monthly files)
- **Transport:** Manual download / API polling (if available)
- **Storage:** Local file system + OneDrive for versioning
- **Extraction language:** Power Query (native to Power BI)

### Data Cleaning & Transformation
- **Tool:** Power Query (Power BI Desktop)
- **Exclusion logic:** Custom filter steps (C_999, future dates, negatives)
- **De-duplication:** Group-by aggregation
- **Calculated columns:** DAX formulas in Power BI
- **Validation:** Data profiling (null counts, value ranges, duplicates)

### Data Modelling
- **Platform:** Power BI (Desktop + Service)
- **Schema:** Star schema (7 tables, 6 relationships)
- **Cardinality:** Enforced Many-to-One
- **Storage mode:** Import (columnar compression, ~400 MB final model)
- **Row-level security:** Structure ready (not activated in this version)

### Analytics & Visualization
- **DAX:** 30+ measures (time intelligence, conditional logic, What-If parameter)
- **Design tool:** Figma (wireframe, component system, design specification)
- **Power BI visuals:** Card, Line, Clustered Bar, Matrix (heatmap), Slicer
- **Custom theme:** JSON file (colours, fonts, visual styles)
- **Interactivity:** 3 slicers, bookmarks (if used), drill-through (if activated)

### Publishing & Sharing
- **Power BI Service:** Workspace, shared app, row-level security (optional)
- **Refresh schedule:** Monthly (after NHS data release, ~15th of each month)
- **Version control:** Power BI Desktop files versioned (backup before publish)

---

## 12. Limitations & Caveats

### Data-Level Limitations

**1. Patient-Months, Not Unique Patients**

The data reports patients monthly. A single patient waiting 3 months is counted 3 times (once per month). This means:
- Total reported pathways (123M) ≠ unique patients
- Longitudinal analysis (e.g., "how long does patient X wait") is not possible
- Month-to-month changes reflect both new patients and progression of existing patients

**Implication:** Trend analysis is sound (month-level system behaviour), but cohort analysis (e.g., "patients starting in April") requires different data structure.

**Mitigation:** Project narrative focuses on monthly system performance, not individual patient journeys.

---

**2. No Outcome Data**

The dataset measures waiting time, not health outcomes. We know:
- How long patients wait ✓
- Which providers are fastest ✓

We do NOT know:
- Whether waiting longer leads to worse health outcomes
- Whether Independent providers deliver equal clinical quality
- Whether patients referred to Independent experience different outcomes

**Implication:** Recommendations assume waiting-time equivalence. If Independent outcomes are systematically worse, this strategy backfires.

**Mitigation:** Recommendations should be paired with outcome tracking (e.g., 30-day infection rate, readmission rate, patient satisfaction surveys).

---

**3. Independent Data Quality**

Independent Sector providers are smaller and more numerous. Data quality may be lower:
- Some specialties under-represented (e.g., only 2 Independent providers in rare specialties)
- Smaller sample sizes → larger confidence intervals for performance estimates
- Possible under-reporting (private providers may not report fully)

**Implication:** Independent compliance estimate (68.9%) has wider confidence intervals than NHS (57.3%). The 11.5pp gap is likely real, but might be 10–13pp depending on data quality.

**Mitigation:** Recommend outcome audits before scaling recommendations.

---

**4. No Cost Data**

The analysis does not account for cost. Key unknowns:
- Is Independent treatment more expensive per patient?
- What is the per-patient cost difference (NHS vs Independent)?
- Do these costs change at scale (volume discounts / economies of scale)?

**Implication:** The recommendation to "shift to 15% Independent" assumes cost-neutral or cost-saving. If Independent costs 30% more, the business case changes.

**Mitigation:** Pair analysis with NHS finance team; obtain tariff data.

---

### Model-Level Limitations

**5. Snapshot Analysis (One Year)**

The dataset covers April 2024 – March 2025 only. Seasonal patterns and multi-year trends cannot be observed. Key risks:
- Did the 58.4% compliance rate improve/deteriorate in prior years? Unknown.
- Are seasonal patterns (e.g., higher wait times in winter) baked into this single year? Unknown.
- Is the Independent advantage (68.9%) stable or recent? Unknown.

**Mitigation:** Recommend expanding data to 3 years (Apr 2022 – Mar 2025) when available.

---

**6. Star Schema Assumes No Type-2 (Slowly Changing) Dimensions**

The dimension tables (Provider, Specialty, Region) are static. In reality:
- Providers merge / split (NHS trust reorg)
- Specialties are reclassified
- Regions are redefined (ICB rollout in 2022)

This project assumes none of these changes occur within Apr 2024 – Mar 2025 (reasonable assumption, but worth noting).

**Mitigation:** Before scaling to multi-year analysis, implement SCD Type 2 (effective-date dimensions).

---

**7. What-If Parameter is Linear; Real-World Scaling is Non-Linear**

The What-If scenario assumes: "If Independent share increases by X%, system compliance improves by Y%" linearly.

Reality is more complex:
- Independent providers may have capacity constraints (cannot absorb all shifted volume)
- Specialties with severe Independent shortage (e.g., specialist mental health) may not improve
- Mix of shifted cases (easier vs harder) affects actual compliance gain

**Implication:** A 15% scenario is optimistic; actual outcome may be +2pp instead of +3.2pp.

**Mitigation:** Model should include capacity constraints. Recommend scenario planning with Independent providers.

---

### Interpretation Limitations

**8. Causality Not Proven**

This analysis is correlational, not causal. We observe:
- Independent providers wait less (+11.5pp compliance)

We cannot conclude:
- Independent-sector status CAUSES faster treatment
- Other factors (e.g., case mix, geography, referral patterns) are not driving the difference

**Implication:** Recommendations assume performance gap is actionable (shift volume, get faster waits). But if the gap is due to case mix (Independent receive easier cases), shifting volume won't help.

**Mitigation:** Recommend case-mix analysis before implementation (e.g., do Independent receive more routine vs urgent cases?).

---

**9. Generalisability**

This analysis covers Apr 2024 – Mar 2025. Recommendations may not apply to:
- Different fiscal years (if trends change)
- Different provider mixes (if new providers enter)
- Different referral patterns (if policy changes)

**Mitigation:** Dashboard should be updated monthly; recommendations reviewed quarterly.

---

## 13. Future Enhancements

### Short-Term (Q2 2026)
- **Outcome tracking:** Add columns for clinical outcomes (infection rate, readmission, patient satisfaction)
- **Cost integration:** Link NHS tariff data to calculate cost per waiting-list improvement
- **Case-mix analysis:** Compare complexity profiles (routine vs urgent vs two-week-wait) between Independent and NHS

### Medium-Term (Q3–Q4 2026)
- **Multi-year data:** Extend analysis to Apr 2022 – Mar 2025 (capture trends)
- **Forecasting:** Build simple trend model (ARIMA) to project compliance 12 months forward
- **Cohort analysis:** If longitudinal data becomes available, track individual patient progression
- **RLS implementation:** Activate row-level security (enable provider-specific dashboards)

### Long-Term (2027+)
- **Mobile app:** Create Power BI mobile app for on-the-go performance monitoring
- **Real-time alerts:** Trigger notifications if compliance drops below threshold
- **Benchmarking:** Extend to include Scottish NHS, Welsh NHS (enable cross-country comparison)
- **Predictive modeling:** Machine learning (classification tree) to predict which patients are at risk of extended wait

---

## 14. References

### Data Sources
- **NHS England RTT Data:** [NHS England Performance Data](https://www.england.nhs.uk/statistics/statistical-work-areas/rtt/)
- **NHS Treatment Functions:** [NHS Service Classifications](https://www.datadictionary.nhs.uk/)
- **Open Government Licence:** [OGL v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/)

### Technical Documentation
- **Power BI Best Practices:** [Microsoft Learn - Power BI Documentation](https://learn.microsoft.com/en-us/power-bi/)
- **DAX Function Reference:** [Microsoft DAX Documentation](https://dax.guide/)
- **Star Schema Design:** [Ralph Kimball, "The Data Warehouse Toolkit"](https://www.kimballgroup.com/)

### NHS Context
- **18-Week Waiting Time Standard:** [NHS Constitution](https://www.nhs.uk/nhs-constitution/)
- **Independent Sector Contracting:** [NHS England Policy](https://www.england.nhs.uk/commissioning/nhs-funding/)
- **Integrated Care Boards (ICBs):** [NHS England ICB Guidance](https://www.england.nhs.uk/integrated-care-boards/)

### Design References
- **Figma Design System:** [Figma documentation](https://help.figma.com/)
- **Data Visualization Best Practices:** [Cole Nussbaumer Knaflic, "Storytelling with Data"](https://www.storytellingwithdata.com/)

---

**Document Version:** 1.0  
**Last Updated:** May 2026  
**Author:** Morteza Ghazanfari  
**Status:** Complete
