# Supply Chain Risk Analysis

An end-to-end data analytics project analyzing **5,000 global shipments** to identify supply chain disruption patterns, transportation performance, and high-risk operational factors.

## Business Objective

Identify the major factors associated with supply chain disruptions and highlight high-risk shipments, routes, transportation modes, and operating conditions.

## Tools

**Python | Pandas | NumPy | Scikit-learn | MySQL | Power BI**

## Analysis

- Cleaned and prepared supply chain shipment data using Python
- Analyzed disruption patterns across transportation modes, routes, weather conditions, and risk levels
- Used SQL for shipment and disruption analysis
- Analyzed the relationship between geopolitical risk and delivery lead time
- Built a machine learning model to predict supply chain disruption risk
- Developed an interactive Power BI dashboard to monitor logistics performance and risk

## Key Insights

- **5,000** total shipments analyzed
- **3,063** disruptions recorded
- **61%** disruption rate
- **39.85%** of shipments classified as high risk
- **Textiles** was the most disrupted product category
- **Air** had the highest logistics efficiency at **4,721.85 km/day**
- High-risk shipments accounted for **1,475** disruptions
- Weather conditions including **hurricanes, storms, fog, and rain** contributed to supply chain disruptions

## Dashboard

### Supply Chain Overview

![Supply Chain Overview](Images/Supply%20Chain%20Risk%20Analysis_page-0001.jpg)

### Transport & Logistics Performance

![Transport & Logistics Performance](Images/Supply%20Chain%20Risk%20Analysis_page-0002.jpg)

### Risk Analysis

![Risk Analysis](Images/Supply%20Chain%20Risk%20Analysis_page-0003.jpg)

### Logistics Trends

![Logistics Trends](Images/Supply%20Chain%20Risk%20Analysis_page-0004.jpg)

## Machine Learning

A classification model was developed to predict whether a shipment would experience a supply chain disruption.

**Model:** Logistic Regression  
**Target:** Disruption Occurred

## Project Structure

```text
Supply-Chain-Risk-Analysis/
│
├── data/
├── notebooks/
├── sql/
├── powerbi/
├── images/
└── README.md
