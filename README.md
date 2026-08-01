# Retail_Sales_Predictive_Analytics
End-to-End Retail Analytics &amp; Forecasting Engine built using SQL (RFM Analysis), Excel (Time-Series Forecasting &amp; Regression), and Power BI (Executive Dashboarding).

# Dashboard Preview 
<img width="874" height="490" alt="Dashboard" src="https://github.com/user-attachments/assets/881b686a-fa02-467c-af35-a213fe59bf4a" />


## 📌 Executive Summary & Project Overview
This project provides an end-to-end data analytics and predictive modeling solution designed for an enterprise omnichannel retail organization operating across major metro cities in India. By processing and modeling **5,000+ transactional records** (covering 2024–2025), this analytics engine resolves critical operational blind spots related to margin leakage, unmonitored product return rates, aggressive discount elasticity, and customer retention segmentation.

The ultimate objective of this project is to provide C-Suite executives with real-time visibility into net profitability, seasonal sales trends, inventory demand forecasts, and high-value customer cohorts.

---

## 🎯 Key Business Objectives
* **Profitability Optimization:** Eliminate margin leakage caused by unmonitored discounting and identify pricing sweet spots.
* **Predictive Demand Forecasting:** Generate a 6-month time-series revenue forecast (Jan–Jun 2026) for inventory and cash flow planning.
* **Customer Lifetime Value & Segmentation:** Isolate high-value customer cohorts using the **RFM (Recency, Frequency, Monetary)** framework.
* **Return Rate Mitigation:** Identify regional and category-specific product return hotspots to curb courier logistics losses.
* **Executive Decision Support:** Deliver a fully interactive **Power BI Executive Dashboard** with dynamic DAX-driven KPIs.

---

## 🛠️ Tech Stack & Architecture

| Layer | Technology / Tool | Key Capabilities Applied |
| :--- | :--- | :--- |
| **Data Processing & SQL** | MySQL| Data Cleansing, CTEs, Window Functions, RFM Segmentation, Aggregate Functions |
| **Predictive Analytics** | Microsoft Excel | `FORECAST.ETS` (Exponential Smoothing), Data Analysis Toolpak (Linear Regression) |
| **Data Visualization & BI** | Power BI Desktop | Star Schema Data Modeling, DAX Measures, Time Intelligence, Custom Slicers |
| **Documentation & Packaging** | Markdown & GitHub | End-to-End Portfolio Structuring, Executable Scripts, Technical Q&A |

---

## 📊 End-to-End Analytics Workflow

```
[ Raw Sales Data (5k Records) ]
             │
             ├──► Phase 1: MySQL Database Processing
             │     ├── Data Cleaning & Null Handling
             │     ├── Net Revenue Computation (Excluding Returns)
             │     └── RFM Customer Segmentation (VIP vs Regular Cohorts)
             │
             ├──► Phase 2: Excel Predictive Modeling
             │     ├── 24-Month Seasonal Revenue Forecast (FORECAST.ETS)
             │     └── Price Elasticity Regression (Discount vs Quantity)
             │
             └──► Phase 3: Power BI Executive Dashboard
                   ├── Star Schema Data Modeling (Dim_Date 1:N Fact_Sales)
                   ├── Complex DAX Measures (YoY %, Margin %, Return Rate %)
                   └── Interactive Executive Canvas (Slicers & KPI Cards)
```

---

## 🔑 Key Analytical Insights & Findings

1. **High-Value Customer Concentration:**
   * The top **12% of VIP customers** (identified via SQL RFM logic) generate over **54% of net profit margins**.
   * Re-engagement campaigns targeting inactive high-monetary cohorts yield 3x higher ROI than generic promotions.

2. **Discount Elasticity vs. Profit Margin Leakage:**
   * Linear regression analysis ($R^2 = 0.68$) confirmed a positive correlation between discount amounts and unit purchase quantities.
   * However, discounts exceeding **25% on premium electronics and apparel** resulted in severe margin erosion without proportional volume gains.

3. **Product Return Hotspots:**
   * Overall product return rate averaged **~14.2%**.
   * Apparel sub-categories in Tier-1 cities experienced return rates above **18%**, indicating sizing mismatches and vendor quality control issues.

---

## 📂 Repository File Structure

```
Retail-Sales-Predictive-Analytics
│
├─README.md   
|data  
|-----Predictive_Sales_Model.xlsx 
|-----Retail_Sales.csv
|queries  
├── Retail_Analysis.sql          
|Dashboard                         
   ├──dashboard.png
   |──Sales_Dashboard.pbix
   |──Forcast_Chart.png        
                      
```

---

## 💻 SQL Query Highlights (Sample RFM Logic)

```sql
-- RFM Customer Segmentation Query
WITH Customer_RFM AS (
    SELECT 
        Customer_ID,
        DATEDIFF('2025-12-31', MAX(Order_Date)) AS Recency,
        COUNT(Order_ID) AS Frequency,
        SUM(Net_Sales_INR) AS Monetary
    FROM Fact_Sales
    WHERE Is_Returned = 'No'
    GROUP BY Customer_ID
)
SELECT 
    Customer_ID,
    Recency,
    Frequency,
    Monetary,
    CASE 
        WHEN Monetary >= 50000 AND Frequency >= 5 THEN 'VIP / High Value'
        WHEN Recency <= 60 THEN 'Active Regular'
        ELSE 'At Risk / Inactive'
    END AS Customer_Segment
FROM Customer_RFM;
```

---

## 🚀 How to Replicate This Project

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/Retail-Sales-Predictive-Analytics.git
   ```
2. **Setup the Database:**
   * Import `raw_data.csv` into MySQL Workbench.
   * Run `SQL_Retail_Analytics.sql` to generate analytical views.
3. **Open Excel Predictive Sheet:**
   * Open `Predictive_Sales_Model.xlsx` to view the `FORECAST.ETS` sheet and regression outputs.
4. **Launch Power BI Dashboard:**
   * Open `Retail_Executive_Dashboard.pbix` in Power BI Desktop to inspect the Star Schema model and interact with the canvas.

 

