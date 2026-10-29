# Telecom Customer Churn Analysis using SQL

## 1. Project Overview

This project analyzes customer churn in a telecommunications company using SQL and MySQL Workbench. The goal is to understand how many customers leave the company and identify the factors associated with customer churn.

The analysis uses customer information such as contract type, tenure, internet service, payment method and monthly charges to identify patterns that may help the company improve customer retention.

## 2. Problem Statement

Customer churn occurs when customers stop using a company's services. A high churn rate can affect revenue and business growth.

The purpose of this project is to analyze customer data, identify customer groups with higher churn rates and provide data-driven recommendations to help improve customer retention.

## 3. Tools Used

- **MySQL:** To query and analyze customer data.
- **MySQL Workbench:** To write and execute SQL queries.
- **SQL:** To clean, filter, group and summarize data.

## 4. Dataset

The project uses the IBM Telco Customer Churn dataset.

- Total customer records: 7,043
- Churned customers: 1,869
- Retained customers: 5,174
- Overall churn rate: 26.54%

## 5. Analysis Performed

The project explores customer churn through the following analyses:

- Overall customer churn rate
- Churn by contract type
- Churn by customer tenure
- Churn by payment method
- Churn by internet service
- Churn by technical support and online security
- Churn by monthly charges
- Churn by senior citizen status and gender
- Combined analysis of contract type with other customer characteristics
- Comparison of monthly charges for churned and retained customers
- Data quality checks and duplicate record checks

## 6. Key Findings

The analysis is designed to identify patterns such as:

- Whether customers on month-to-month contracts have higher churn rates.
- Whether customers with shorter tenure are more likely to leave.
- Whether payment methods are associated with different churn rates.
- Whether internet service type and additional services are associated with churn.
- Whether monthly charges differ between churned and retained customers.

The final findings should be interpreted using the results from the completed SQL queries.

## 7. Business Recommendations

Based on the patterns identified in the analysis, the company could consider:

- Improving retention efforts for customer groups with higher churn rates.
- Encouraging suitable longer-term contracts through relevant offers.
- Reviewing the customer experience for users with shorter tenure.
- Investigating whether customers without technical support or online security need better service guidance.
- Reviewing payment-related customer experiences and service pricing.

These recommendations should be evaluated further before implementing business changes.

## 8. SQL Concepts Used

- SELECT and WHERE
- Aggregate functions such as COUNT, SUM and AVG
- GROUP BY and ORDER BY
- CASE statements
- JOIN operations
- Common Table Expressions (CTEs)
- Window functions such as DENSE_RANK
- Data quality checks and NULL handling

## 9. Project Outcome

This project demonstrates how SQL can be used to analyze customer data, calculate churn metrics and identify patterns that may support business decisions.

It also provides practical experience in data validation, aggregation, segmentation and translating query results into business insights.