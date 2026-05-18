**Overview**
<img width="1246" height="687" alt="image" src="https://github.com/user-attachments/assets/e09d4aa2-1084-49e2-b194-20a7c43fd329" />

**Key Findings**
<img width="1318" height="713" alt="image" src="https://github.com/user-attachments/assets/f8e74c43-596f-4666-823d-f24459a30f89" />

**Gaps**
<img width="1175" height="627" alt="image" src="https://github.com/user-attachments/assets/46c0a30c-9c4a-446a-82fa-ca3fc949c840" />

**Recommendations**
<img width="1275" height="687" alt="image" src="https://github.com/user-attachments/assets/482bcad0-13bb-472c-bbff-7fb30be9b47e" />

## Customer Purchase Behaviour & Churn Analytics
An end-to-end retention analytics pipeline built using SQL, Python, 
and Power BI to identify churn drivers, segment customers by value, 
and deliver actionable business recommendations.

**Tools:** SQL · Python (Pandas, Matplotlib, Seaborn) · Power BI  
**Dataset:** Olist Brazilian E-commerce Dataset — 
[Download from Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Problem Statement
A D2C brand has no visibility into which customers are churning, 
when they churn, or which lapsed customers are worth re-engaging.

## Project Structure
customer-churn-analytics/
├── sql/                    # Data cleaning and master view queries
├── python/                 # RFM analysis, cohort retention, CLV
├── data/                   # Processed output CSVs
├── powerbi/                # Dashboard screenshots
└── docs/                   # Full project documentation PDF

## Approach

### Phase 1 — SQL: Data Cleaning & Joining
- Loaded 5 Olist tables into SQLite
- Filtered to delivered orders only
- Created a master view joining orders, items, customers, 
  payments, and reviews
- Used LEFT JOIN for reviews to preserve all orders

### Phase 2 — Python: Feature Engineering
- **RFM Scoring:** Recency, Frequency, Monetary scored 1–4 
  using quantile-based bucketing
- **Customer Segmentation:** Champions, Loyal, Promising, 
  At Risk, Churned
- **Cohort Retention Analysis:** Month-over-month retention 
  tracked per acquisition cohort
- **CLV Estimation:** Average Order Value × Purchase Frequency

### Phase 3 — Power BI: Dashboard
Three-page interactive dashboard:- 
- **Page 1:** Executive summary — KPIs, segment distribution, CLV by segment
- **Page 2:** Retention analysis — cohort heatmap
- **Page 3:** Priority action list — scatter plot and CRM-ready customer table

## Dashboard Preview

### Page 1 — Executive Summary
<img width="1097" height="613" alt="image" src="https://github.com/user-attachments/assets/0c7e5af7-e142-4be5-92ea-4da7d06e782f" />

### Page 2 — Retention Analysis
<img width="1078" height="611" alt="image" src="https://github.com/user-attachments/assets/ca5fcab6-c935-4ec2-8e4f-91381f02ad61" />

### Page 3 — Priority Action List
<img width="1085" height="607" alt="image" src="https://github.com/user-attachments/assets/929a2650-8b89-4c66-98c5-68f801c51c73" />


## Key Findings
1. 61% of customers do not return after their first purchase, with the steepest retention drop occurring between Month 0 and Month 1. This highlights post-  purchase engagement as the most critical retention opportunity.
2. Champions account for 17.1% of customers but generate 26.2% of total revenue, making them the highest-value segment for loyalty and retention initiatives.
3. At Risk customers represent only 6.2% of the customer base but remain highly recoverable due to recent engagement, making them the most cost-effective target for win-back campaigns.
4. Churned customers make up 19% of the customer base and account for 15.9% of lost historical revenue, emphasizing the importance of early retention and reactivation strategies before customers become inactive.

## Recommendations
1. Introduce a loyalty programme with rewards and exclusive offers to convert Loyal customers into Champions and increase long-term customer value.
2. Create a VIP retention programme for Champions focused on exclusivity and personalised experiences to reduce the revenue risk of losing high-value customers.
3. Launch a post-purchase email journey within the first 30 days to improve engagement and reduce the sharp early-stage churn rate.
4. Run a limited win-back campaign for churned customers using targeted incentives, while keeping budget focus on preventing future churn.
5. Reassess the churn threshold based on actual repurchase cycles to better identify truly at-risk customers and improve retention targeting.

## Conclusion
In conclusion, the analysis highlights three key retention opportunities: protecting high-value Champions through loyalty initiatives, improving the post-purchase experience to reduce early churn, and nurturing Loyal customers into higher-value segments. These actions focus on maximizing retention and revenue growth without increasing acquisition spend.
