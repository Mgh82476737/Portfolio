# Limitations & Caveats — NHS RTT Project

**Important assumptions and constraints you should know**

---

## Data-Level Limitations

### 1. Patient-Months, Not Unique Patients

**The Issue:**
The NHS RTT dataset reports waiting list status **monthly**. Each month is a snapshot. A single patient waiting 3 months appears in the data 3 times (once per month).

**What This Means:**
- Total reported pathways (123M) ≠ Unique number of patients
- Same person counted multiple times
- Longitudinal analysis (e.g., "what happened to patient X?") is impossible with this data

**Example:**
- Patient A waits from April → June (3 months on list)
- Counted as 3 rows in the dataset (one per month)
- Cannot determine when they started or finished

**Implication for Analysis:**
- Month-to-month system trends are valid ✓
- Cohort tracking ("patients starting in April") is invalid ✗
- "3M patients" means "3M patient-months," not 3M unique individuals

**Mitigation:**
- Project narrative focuses on **monthly system performance**, not individual patient journeys
- Recommendations treat 123M as a flow metric (volume per month), not a stock metric (people on list)

---

### 2. No Outcome Data

**The Issue:**
The dataset measures **waiting time** only. It does not measure:
- Whether treatment was effective
- Patient health outcomes (did they recover?)
- Treatment quality (infection rates, readmission, etc.)
- Patient satisfaction

**What This Means:**
We know *how long* patients wait. We don't know *whether waiting longer hurts them*.

**Example:**
- Independent Sector: 68.9% wait < 18 weeks
- NHS Trusts: 57.3% wait < 18 weeks
- ❓ But do Independent patients have better health outcomes?
- ❓ Are they more satisfied?
- ❓ Do they have lower readmission rates?

**Critical Gap:**
Waiting time ≠ Health impact. It's possible (unlikely, but possible) that:
- Faster waiting = worse outcomes (if quality sacrificed for speed)
- Slower waiting = better outcomes (if complexity justified the delay)

**Implication for Analysis:**
Recommendations assume "shorter wait = better." If outcomes are opposite, strategy backfires.

**Mitigation:**
- Before scaling Independent volume, audit clinical outcomes (infection rate, readmission, etc.)
- Add outcome tracking to Power BI model (if data becomes available)
- Pair waiting-list recommendations with quality parity requirements

---

### 3. Independent Sector Data Quality

**The Issue:**
NHS Trusts are large, standardized organizations with consistent reporting. Independent Sector providers are:
- Smaller
- More numerous
- Less regulated for data quality
- May under-report or over-report inconsistently

**What This Means:**
- Independent compliance (68.9%) may be overstated or understated
- Specialties with few Independent providers have small sample sizes (high variance)
- Some regions have almost no Independent capacity

**Example:**
- Mental Health: Only 3 Independent providers nationally (vs 50+ NHS)
- Rare specialties: No Independent capacity (Independent share = 0%)
- London: 12% Independent share (well-served)
- North West: 2% Independent share (sparse)

**Data Quality Risks:**
- Small sample sizes → results may not generalize
- Possible selection bias (do Independent providers only take "easier" cases?)
- Reporting inconsistency (different systems, different standards)

**Implication for Analysis:**
The 11.5pp Independent advantage may partly reflect:
1. ✓ Superior efficiency (genuine)
2. ✗ Easier case mix (selection bias)
3. ✗ Better data reporting (reporting artifact)

**Mitigation:**
- Before scaling recommendations, conduct case-mix analysis
- Compare specialty/complexity profiles between Independent and NHS
- Audit data quality (spot-check a sample of Independent reports)

---

### 4. No Cost Data

**The Issue:**
The analysis doesn't include cost. Key unknowns:
- What does NHS treatment cost per patient?
- What does Independent treatment cost?
- Are Independent providers more / less expensive?
- Do costs change at scale (volume discounts)?

**What This Means:**
Recommendations assume cost-neutral or cost-saving shifts. But:
- If Independent is 30% more expensive, budget case changes
- If costs scale poorly (higher per-patient cost at 15% vs 5%), ROI worsens
- NHS tariffs are standardized; Independent pricing varies

**Example:**
- Shifting 10pp volume to Independent = 12M more pathways/year
- If Independent is 30% more expensive:
  - Cost increase: £millions
  - Justifies longer waits (if budget constrained)

**Implication for Analysis:**
Business case is incomplete without cost data. "Shift to Independent" may be:
- ✓ Affordable if costs are neutral
- ✗ Unaffordable if costs are higher

**Mitigation:**
- Pair recommendations with NHS finance team
- Obtain Independent tariff data (may vary by specialty)
- Model scenarios: cost-neutral, +20%, +30%

---

## Model-Level Limitations

### 5. Snapshot Analysis (One Year Only)

**The Issue:**
Dataset covers April 2024 – March 2025 (12 months). Cannot observe:
- Trends over time (improving or deteriorating?)
- Seasonal patterns (worse in winter?)
- Cyclical patterns (pre/post-pandemic recovery?)

**What This Means:**
- 58.4% compliance is a point-in-time measure
- ❓ Was it 55% last year? 60%?
- ❓ Is the trend upward or downward?
- ❓ Is the Independent advantage stable or recent?

**Example:**
You see: Independent 68.9% compliance (Apr 2024 – Mar 2025)
You don't know:
- Was it 65% two years ago? 72%?
- Is the gap widening or narrowing?
- Is this a temporary post-pandemic phenomenon?

**Implication for Analysis:**
Recommendations assume 58.4% and 68.9% are representative. But:
- If actual trend is downward (58.4% is worst-case), problem worse than stated
- If actual trend is upward (58.4% is improving), problem may be self-correcting
- If 68.9% is temporary, Independent advantage may not persist

**Mitigation:**
- Extend analysis to 3 years (Apr 2022 – Mar 2025) when available
- Track compliance monthly; flag any significant deviations
- Re-run analysis annually; update recommendations

---

### 6. Star Schema Assumes Static Dimensions

**The Issue:**
The data model treats Provider, Specialty, and Region as **static** (unchanging). In reality:
- Providers merge / split (NHS trust reorg)
- Specialties are reclassified (medical codes change)
- Regions are redefined (ICB rollout in 2022)

**What This Means:**
If a provider merged during Apr 2024 – Mar 2025:
- Data may be split across old and new codes
- Comparisons month-to-month become invalid
- Trends are distorted

**Example:**
Provider "East Regional Trust" merges with "Midlands NHS Trust" in September 2024
- Apr–Aug data: Under "East Regional"
- Sep–Mar data: Under "Midlands NHS"
- Cannot compare volumes pre/post-merger
- "East Regional" appears to shrink 40% in September

**Implication for Analysis:**
Trend analysis assumes provider names are stable. If they're not:
- Month-to-month changes may reflect mergers, not real performance changes
- Year-on-year comparisons are invalid
- "Provider A improved 3pp" may actually reflect inherited better-performing staff

**Mitigation:**
Before extending to multi-year analysis, implement **Type 2 Slowly Changing Dimensions** (effective dates for provider reclassifications).

---

### 7. What-If Parameter Assumes Linearity

**The Issue:**
The What-If scenario assumes:

> If Independent share increases by X%, system compliance improves by Y% **linearly**

Reality is messier:

**What This Means:**
- If you shift volume to Independent, you're assuming Independent capacity can absorb it
- But Independent providers have limits (capacity constraints)
- Specialties with no Independent capacity cannot be shifted (compliance unchanged)
- Mix of shifted cases affects outcomes (shifting "easy" cases helps more than "hard" cases)

**Example:**
What-If model predicts:
- Shift to 10% Independent share → 60.1% system compliance
- Shift to 15% Independent share → 61.6% system compliance (+1.5pp per 5pp shift)

Reality might be:
- Shift to 10% → 60.0% (good)
- Shift to 15% → 60.9% (worse than linear — capacity constraints kick in)
- Shift to 20% → 61.0% (flat — some specialties maxed out)

**Implication for Analysis:**
Scenario outcomes are optimistic. Actual improvements may be:
- Lower than projected (capacity constraints)
- Unevenly distributed (some specialties improve, others don't)
- Temporary (catching up on backlog, then saturation)

**Mitigation:**
- Before scaling, model capacity constraints (ask Independent providers: "how much more can you take?")
- Test scenarios with subset of specialties (pilot T&O increase, measure outcome)
- Monitor: If 10% increase yields 1.5pp improvement, expect diminishing returns at higher volumes

---

## Interpretation Limitations

### 8. Causality Not Proven

**The Issue:**
This analysis is **correlational**. We observe:

> Independent providers are faster (68.9% vs 57.3%)

We assume:

> **Therefore**, if we shift volume to Independent, the system gets faster

This logic has a critical flaw: **Other factors might explain the gap.**

**What This Means:**
The 11.5pp difference could be caused by:

1. ✓ **Genuine efficiency** (Independent sector is better run)
2. ✗ **Case mix** (Independent only treats "easy" cases; NHS gets hard ones)
3. ✗ **Geography** (Independent concentrated in fast-performing regions)
4. ✗ **Referral patterns** (Independent gets younger, healthier patients)
5. ✗ **Motivation** (Independent has profit incentive; NHS doesn't)

**Example:**
Hypothesis: "Independent is faster because it's better run"
Alternative: "Independent is faster because it only takes routine cases"

If alternative is true: Shifting complex cases to Independent won't help (they can't handle them).

**Implication for Analysis:**
Recommendation assumes: "More Independent = Faster System"
But this is untested. The reality might be:
- ✓ True (shift helps)
- ✗ False (no improvement because case-mix was the cause)
- ✗ Partially true (modest improvement, but not 3.2pp)

**Mitigation:**
**Before implementing recommendations:**
1. Conduct case-mix analysis (are Independent cases simpler?)
2. Run a pilot (shift 5% in one region, measure actual outcome)
3. Track outcomes (infection, readmission, satisfaction) in parallel

---

### 9. Generalisability

**The Issue:**
This analysis covers Apr 2024 – Mar 2025. Recommendations may not apply to:
- Different time periods (if trends change)
- Different provider mixes (if new providers enter)
- Different referral patterns (if policy changes)
- Different patient populations (if demographics shift)

**What This Means:**
Findings are specific to this dataset. In the future:
- New providers may enter (change competitive dynamics)
- NHS may shift policy (restrict Independent capacity)
- Patients may shift (aging population, different referral patterns)
- Crises may occur (pandemic, industrial action)

**Example:**
"Independent is 11.5pp faster" — true in Apr 2024 – Mar 2025
But next year:
- New large NHS Trust opens with excellent management → gap shrinks
- Independent waiting list grows (capacity full) → gap shrinks or reverses
- Policy changes: NHS prioritizes urgent cases → routine waiting times rise for both

**Implication for Analysis:**
Recommendations are time-bound. They're valid for decisions made in **May 2026 onwards**, but:
- Review quarterly (are trends stable?)
- Update annually (new data may change conclusions)
- Re-pilot before scaling (verify assumptions hold)

**Mitigation:**
- Dashboard should be updated monthly (new data each month)
- Recommendations reviewed quarterly (is gap still 11.5pp?)
- Pilot programmes (before major policy shift)

---

## Summary Table: What We Know vs Don't Know

| Question | Can Answer? | Source |
|----------|-------------|--------|
| How long do patients wait? | ✓ Yes | RTT data |
| What % wait < 18 weeks? | ✓ Yes | RTT data |
| Do Independent wait less? | ✓ Yes | RTT data |
| Why is Independent faster? | ✗ No | Not in data |
| Will shifting to Independent help? | ⚠️ Probably | Assumption, untested |
| How much faster will system get? | ⚠️ Optimistic | Linear model, untested |
| Will patients be healthier? | ✗ No | No outcome data |
| Will it be affordable? | ✗ No | No cost data |
| Is this a permanent advantage? | ✗ Unknown | One year of data |

---

## Recommendations for Using This Project

### If Building Business Case
- [ ] Add cost data (NHS tariff, Independent pricing)
- [ ] Add outcome data (infection rate, readmission, satisfaction)
- [ ] Conduct case-mix analysis
- [ ] Run pilot programme (small-scale test)
- [ ] Define success metrics (compliance target, cost per patient, patient satisfaction)

### If Extending Analysis
- [ ] Extend to 3+ years of data
- [ ] Implement Type 2 dimensions (handle reorgs, reclassifications)
- [ ] Add forecasting (trend lines, seasonality)
- [ ] Segment by patient complexity (easy vs hard cases)
- [ ] Track outcomes in parallel

### If Publishing or Presenting
- [ ] Clearly state: "This is a waiting-time analysis, not a quality analysis"
- [ ] Highlight: "Independent advantage may reflect case mix, not efficiency"
- [ ] Acknowledge: "Recommendations are hypotheses, not predictions"
- [ ] Propose: "Pilot programme to validate assumptions"

---

## Contact & Questions

For questions about limitations, assumptions, or methodology:
- Review `DOCUMENTATION.md` (comprehensive explanation of every step)
- Check the `Exclusion_Log.md` (what data was filtered and why)
- See data model in Power BI (inspect queries, relationships, formulas)

---

**Version:** 1.0  
**Last Updated:** May 2026  
**Author:** Morteza Ghazanfari
