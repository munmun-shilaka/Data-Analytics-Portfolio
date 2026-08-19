# NYC Airbnb Business Intelligence & Market Strategy

An end-to-end data analytics and business intelligence project analysing the New York City Airbnb market using Python, SQL, SQLite, and dashboard-ready datasets.

The project focuses on pricing strategy, host performance, customer engagement, neighbourhood performance, availability, and market opportunities.

---

## 📌 Project Overview

The objective of this project is to transform raw NYC Airbnb data into actionable business insights that can support:

- Pricing decisions
- Host segmentation
- Neighbourhood strategy
- Customer engagement analysis
- Market opportunity identification
- Business decision-making

The analysis combines Python-based exploratory analysis, structured SQL business analysis, and dashboard-ready outputs.

---

## 🎯 Business Problem

Airbnb operates across highly diverse neighbourhoods, accommodation types, and host segments.

Business teams need to understand:

- Where is Airbnb supply concentrated?
- Which boroughs command premium prices?
- Which room types dominate the market?
- Which hosts manage large property portfolios?
- Where is customer engagement strongest?
- How does pricing relate to review activity?
- Which neighbourhoods represent potential pricing opportunities?
- How does listing availability vary across NYC?

---

## 📊 Dataset

The project uses publicly available New York City Airbnb data covering:

- Listings
- Reviews
- Neighbourhoods
- Calendar availability

### Dataset Scale

| Metric | Value |
|---|---:|
| Total Listings | 30,555 |
| Unique Hosts | 16,474 |
| Neighbourhoods | 223 |
| Boroughs | 5 |
| Total Reviews | 990,170 |
| Calendar Records | 11M+ |
| Average Listing Price | $278.33 |

### Dashboard Dataset

The dashboard-ready listing dataset contains **21,797 listings** after excluding records with zero or invalid prices for pricing-focused analysis.

---

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data cleaning, EDA, feature engineering |
| Pandas | Data manipulation |
| NumPy | Numerical analysis |
| Matplotlib | Data visualization |
| SQLite | Database management |
| SQL | Business analysis and KPI development |
| Power BI | Dashboard development planned |
| Git & GitHub | Version control and portfolio management |

---

# 🔍 Analysis Workflow

```text
Raw Airbnb Data
       ↓
Data Quality Assessment
       ↓
Data Cleaning
       ↓
Exploratory Data Analysis
       ↓
Feature Engineering
       ↓
SQLite Database
       ↓
Business SQL Analysis
       ↓
Executive Insights
       ↓
Dashboard-Ready Dataset
       ↓
Power BI Dashboard

📁 Project Structure

Project_02_Airbnb_Business_Intelligence/
│
├── Dataset/
│   ├── listings.csv
│   ├── reviews.csv
│   ├── neighbourhoods.csv
│   └── calendar.csv
│
├── Documentation/
│   ├── Business_Report.md
│   ├── Data_Dictionary.md
│   ├── Executive_Summary.md
│   └── Project_Summary.md
│
├── Notebook/
│   └── Airbnb_Business_Intelligence.ipynb
│
├── Output/
│   ├── airbnb_dashboard_data.csv
│   ├── borough_kpis.csv
│   └── room_type_kpis.csv
│
├── SQL/
│   ├── 01_Database_Setup.sql
│   ├── 02_Data_Exploration.sql
│   ├── 03_Business_KPIs.sql
│   ├── 04_Revenue_Analysis.sql
│   ├── 05_Host_Analysis.sql
│   ├── 06_Pricing_Strategy.sql
│   ├── 07_Customer_Insights.sql
│   └── 08_Executive_Report.sql
│
├── Airbnb_NYC.db
├── README.md
└── requirements.txt

📈 Key Business Findings

1. Borough Performance

| Borough       | Listings | Average Price |
| ------------- | -------: | ------------: |
| Manhattan     |    9,771 |       $379.62 |
| Brooklyn      |    7,263 |       $213.55 |
| Queens        |    3,638 |       $175.16 |
| Bronx         |      829 |       $152.85 |
| Staten Island |      296 |       $143.15 |

Insight

Manhattan is the strongest premium market, with both the largest listing concentration and the highest average price.

Brooklyn has the second-largest supply base while maintaining a considerably lower average price than Manhattan.

2. Room Type Performance

| Room Type       | Listings | Average Price |
| --------------- | -------: | ------------: |
| Entire home/apt |   11,537 |       $331.43 |
| Private room    |    9,588 |       $194.52 |
| Hotel room      |      480 |       $721.58 |
| Shared room     |      192 |       $164.39 |

Insight

Entire homes and apartments represent the largest accommodation segment.

Hotel rooms command the highest average price, but the segment is relatively small compared with entire homes and private rooms.

3. Pricing Segmentation

| Price Segment | Listings | Average Price |
| ------------- | -------: | ------------: |
| Budget        |    5,548 |        $67.84 |
| Standard      |    6,700 |       $146.93 |
| Premium       |    7,146 |       $305.06 |
| Luxury        |    2,403 |     $1,051.14 |

Insight

Premium listings represent the largest price segment.

Luxury listings form a smaller but significantly higher-value segment, indicating a specialised premium market.

4. Customer Engagement

The dataset contains:

990,170 total reviews
32.41 average reviews per listing
21,939 listings with reviews
8,616 listings without recorded reviews
Insight

Customer engagement is concentrated among a subset of listings, creating an opportunity to identify the characteristics associated with stronger market traction.

5. Host Performance

The dataset contains 16,474 unique hosts.

The analysis identifies both individual hosts and large professional portfolios.

The largest host portfolio contains hundreds of listings, highlighting the importance of professional property managers within the NYC marketplace.

Business Implication

Host strategy can be segmented into:

Individual hosts
Small portfolio operators
Professional hosts
Large property managers

Different host segments may require different pricing tools, support models, and account-management strategies.

6. Availability Analysis

Calendar data contains more than 11 million records across the available observation period.

Overall observed availability is approximately 51.18%.

Business Implication

Availability can be used as an indicator of supply conditions and market concentration across NYC neighbourhoods.

💼 Business Recommendations
1. Use Localised Pricing

Pricing should be benchmarked at the neighbourhood and borough level rather than applying a single NYC-wide pricing strategy.

2. Strengthen Premium Market Strategy

Manhattan and other premium neighbourhoods should be evaluated for high-value pricing opportunities and premium accommodation positioning.

3. Segment Host Support

Airbnb can differentiate its services for individual hosts, professional operators, and large property managers.

4. Identify Pricing Opportunities

Listings with strong customer engagement but relatively lower pricing can be investigated as potential opportunities for price optimisation.

5. Monitor Supply and Availability

Availability patterns should be monitored alongside price to understand where supply may be concentrated or constrained.

6. Use Customer Engagement as a Signal

Review activity can be used as an engagement indicator when comparing listings, neighbourhoods, and room types.

🧮 SQL Analysis

The project contains eight structured SQL modules:

01_Database_Setup.sql

Database structure and validation.

02_Data_Exploration.sql

Data profiling, quality checks, and exploratory queries.

03_Business_KPIs.sql

Executive KPIs and marketplace metrics.

04_Revenue_Analysis.sql

Pricing, availability, and market opportunity analysis.

05_Host_Analysis.sql

Host portfolio and professional-host analysis.

06_Pricing_Strategy.sql

Pricing segmentation, premium markets, and pricing opportunities.

07_Customer_Insights.sql

Review activity and customer engagement analysis.

08_Executive_Report.sql

Executive-level performance summaries and business insights.

🐍 Python Analysis

The Python notebook covers:

Dataset loading
Data structure inspection
Data-quality assessment
Missing-value analysis
Duplicate checks
Descriptive statistics
Price distribution analysis
Borough analysis
Room-type analysis
Host analysis
Neighbourhood analysis
Customer engagement analysis
Feature engineering
Business insights
📊 Dashboard

A Power BI dashboard is planned as the next visualisation phase.

The dashboard will focus on:

Executive KPIs
Borough performance
Pricing analysis
Room-type performance
Neighbourhood analysis
Host performance
Customer engagement
Availability

The dashboard-ready datasets have already been prepared in the Output folder.

⚠️ Data Limitations

This project uses publicly available Airbnb data.

The dataset does not provide:

Confirmed booking counts
Actual Airbnb revenue
Guest conversion rates
Cancellation data
Actual transaction prices

Therefore:

Review counts should not be interpreted as booking counts.
Availability should not be interpreted as confirmed occupancy.
Listed price should not be interpreted as realised transaction value.
Revenue-related metrics should be treated as pricing or market-opportunity analysis rather than actual Airbnb financial performance.
📚 Documentation

Detailed project documentation is available in the Documentation folder:

Business_Report.md
Data_Dictionary.md
Executive_Summary.md
Project_Summary.md
🚀 Future Improvements

Planned future enhancements include:

Power BI executive dashboard
Interactive neighbourhood map
Advanced pricing model
Demand forecasting
Machine learning-based price prediction
Host recommendation system
Time-series review analysis
Advanced market opportunity scoring

👩‍💻 Author
Munmun Shilaka

Data Analyst | Business Analyst

MSc International Business with Data Analytics

Technical Skills

Python | SQL | Power BI | Tableau | Excel | Business Intelligence | Data Analysis

Portfolio

GitHub


LinkedIn

⭐ Project Summary

This project demonstrates an end-to-end analytics workflow:

Data → Python → SQL → Business Intelligence → Insights → Strategic Recommendations