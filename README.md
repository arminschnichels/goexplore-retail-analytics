# GoExplore Retail Analytics

**Google Sheets → BigQuery → Looker Studio | End-to-End Analytics Workflow**

---

## 📊 Project Overview

**Business Context:**
GoExplore is a rapidly growing camping and hiking equipment supplier. As the newly hired data analyst, I was handed a single spreadsheet file and an open-ended brief from the CEO: *"Just get it done."* With no specific requirements, I had to determine which questions mattered, build the infrastructure to answer them, and deliver actionable insights within two weeks.

**Core Question:**
*Where is GoExplore performing well, where are the growth opportunities, and what patterns should inform operational planning?*

**Tools:** Google Sheets, Google BigQuery, Looker Studio, SQL
**Dataset:** 149,257 orders (January 2015 – July 2018)

---

## 🎯 Key Findings

| Metric | Result | Insight |
|--------|--------|---------|
| **Total Revenue** | €1.25 billion | Strong business scale across 3.5 years |
| **Overall Margin %** | 42.2% | Healthy profitability |
| **Revenue Growth** | +117% | Monthly revenue doubled over 3.5 years |
| **Margin % Growth** | +143% | Business became more profitable, not just larger |
| **Top Opportunity** | Outdoor Protection (60.2% margin, €18M revenue) | Highest margin, lowest volume — untapped |
| **Seasonal Peak** | February – June | Q1–Q2 drives disproportionate revenue |

---

## ✅ Strategic Recommendations

1. **Expand Outdoor Protection** — 60.2% margin but only 1% of revenue. A 50% increase adds ~€9M revenue and ~€5M profit with proven profitability and low risk.
2. **Plan around seasonality** — Clear Q1–Q2 peak and July dip. Inventory, staffing, and promotions should align with this pattern.
3. **Maintain traditional order channels** — Mail and sales visits represent only 3% of orders but have 3x higher average order values than web. These serve premium customers.

---

## 🔧 Analytical Approach

### Phase 1: Google Sheets — Exploration

Used VLOOKUP to join four source tables (orders, products, retailers, order methods) into a single analysis-ready dataset of 149,257 rows. Built dashboards covering three business dimensions:

**Retailer Analysis**
Compared retailers across revenue, order frequency, and average order value simultaneously — revealing that the highest-revenue retailer (Grand choix, €67M) is not the same as the highest average order value retailer (Consumer Club, €631/order). Different retailers require different account strategies.

![Retailer Analysis](google-sheets/sheets-retailer-analysis.png)

**Channel Analysis**
Compared all seven order methods by volume, revenue, and average order value. Key finding: web dominates volume (87%) but mail and sales visits have 3x higher average order values. Low-volume channels serve high-value customers.

![Channel Analysis](google-sheets/sheets-channel-analysis.png)

**Product Analysis**
Analyzed the product portfolio across units sold, revenue, and margin at both product type and product line level — revealing that the most profitable category (Outdoor Protection, 60.2% margin) is also the smallest by revenue.

![Product Analysis](google-sheets/sheets-product-analysis.png)

---

### Phase 2: BigQuery — Production Scale

Migrated to Google BigQuery when Google Sheets began showing performance limitations with 149K rows. Wrote a SQL query to replicate the Sheets data model with joins across all four source tables, adding calculated fields for revenue, margin, and margin percentage. Connected BigQuery back to Google Sheets for time-series analysis.

SQL query: [master_data_query.sql](bigquery-sql/master_data_query.sql)

**Revenue and Margin Over Time**
Revenue grew from €20M to €43M per month (+117%). Margin percentage simultaneously improved from 1.4% to 3.3% — confirming the business is not just growing in volume but becoming more efficient and profitable.

![Revenue and Margin Trends](google-sheets/sheets-revenue-margin-trends.png)

**Quantity and Seasonality**
Clear seasonal pattern across all years: peaks in February–June, significant dip in July. Total annual volume grew from 4.3M units (2015) to a projected 7.4M+ (2018 run-rate).

![Quantity Trends](google-sheets/sheets-quantity-trends.png)

---

### Phase 3: Looker Studio — Interactive Dashboards

Built a four-page interactive dashboard connected directly to BigQuery, with date range and country filters. Each page was designed for a different business audience.

**Page 1 – Executive Overview** *(CFO, CEO, Board)*
KPI scorecards, revenue trend, geographic distribution, top 5 retailers.

![Executive Overview](looker-studio/looker-page1-executive-overview.png)

**Page 2 – Product Portfolio** *(Product teams, Merchandising)*
Revenue and margin percentage by product line. Identified Outdoor Protection as the strategic growth opportunity with 60.2% margin despite minimal revenue.

![Product Portfolio](looker-studio/looker-page2-product-portfolio.png)

**Page 3 – Pricing and Volume** *(Pricing strategy, Finance, Procurement)*
Unit cost vs. unit sale price by product line, volume distribution, and unit economics table showing markup percentages — explaining why margin percentages vary so significantly across categories.

![Pricing and Volume](looker-studio/looker-page3-pricing-volume.png)

**Page 4 – Time Trends** *(Operations, Planning, HR)*
Quarterly growth trajectory (+105% over 3.5 years), quarterly revenue table, and monthly seasonality pattern for operational planning.

![Time Series](looker-studio/looker-page4-time-series.png)

---

## 🚧 Technical Challenges Solved

### Challenge 1: Division by Zero in Margin % Calculation

**Problem:** Margin percentage calculation failed with a division by zero error, preventing the metric from being added to the dataset.

**Root Cause:** 524 orders had a unit sale price of zero — representing promotional items or data entry errors.

**Solution:** Added `WHERE ds.unit_sale_price > 0` to exclude these orders from the analysis.

**Impact Assessment:** 524 orders out of 149,257 = 0.35% of data. Revenue impact was €0 since these orders generated no revenue. The exclusion was documented transparently.

**Learning:** Always investigate the cause before excluding data. The zero-price orders were not random noise — they were a specific business category (promotions/samples) that needed a deliberate decision.

---

### Challenge 2: Wrong Aggregation for Margin Percentage

**Problem:** Using `AVG(margin_percentage)` in Looker Studio produced 43.55% — a different result than the correct 42.2%.

**Root Cause:** Averaging individual row percentages treats a €10 order the same as a €10,000 order, producing a mathematically incorrect weighted result.

**Solution:** Created a calculated field using `SUM(margin) / SUM(revenue)` instead of averaging the pre-calculated percentage column. This correctly weights each transaction by its revenue contribution.

**Learning:** Margin percentage must be calculated by aggregating the underlying values, not by averaging percentages.

---

## 💼 Skills Demonstrated

**Technical:**
- Google Sheets: VLOOKUP across 4 tables, calculated fields, pivot tables, chart design at 149K rows
- SQL (BigQuery): Multi-table JOINs, calculated metrics, data quality filtering, WHERE clauses
- Looker Studio: Interactive dashboards, calculated fields, date and dimension filters, multi-page layout
- Data Modeling: Joining relational tables, defining business metrics, handling edge cases

**Analytical:**
- KPI Development: Defined 9 KPIs from an open-ended brief with no specified requirements
- Multi-dimensional Analysis: Evaluated retailers, channels, products, and time trends simultaneously
- Profitability Analysis: Correctly calculated weighted margin percentages across dimensions
- Seasonality Analysis: Identified operational patterns with inventory and staffing implications

**Business:**
- Stakeholder Design: Built different dashboard pages for different business audiences (CFO vs. Operations vs. Product)
- Strategic Thinking: Identified €9M+ growth opportunity in an underutilized product category
- Communication: Translated technical findings into three clear executive recommendations

---

## 📈 Key Learnings

1. **Open-ended briefs require structure** — When given no specific requirements, defining the right questions is as important as answering them. I started broad across four dimensions (customers, channels, products, time) before narrowing to the most actionable insights.
2. **The same data tells different stories at different levels** — Analyzing products at the type level vs. the line level revealed completely different insights. Outdoor Protection only becomes visible as an opportunity when you look at margin percentage, not revenue.
3. **Correct calculations matter more than impressive ones** — The margin percentage aggregation mistake was easy to make and produced a believable wrong answer. Validating calculations across multiple methods catches these errors.
4. **Tool transitions should be deliberate** — Moving from Sheets to BigQuery was not about using more advanced tools. It was a specific response to specific limitations, with a clear reason and a plan to maintain accessibility for non-technical users through Looker Studio.

---

## 📞 Contact

**Armin Schnichels**
arminschnichels@gmail.com | [LinkedIn Profile]

---

## 📜 Project Context

This project was completed as part of a Data Analytics Weiterbildung. The dataset is a fictional retail case study used for training purposes. The analysis, methodology, technical decisions, and recommendations are my own work.

*Last Updated: March 2026*
