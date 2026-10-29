-- ============================================================
-- TELECOM CUSTOMER CHURN ANALYSIS
-- SQL dialect: MySQL 8.0+
-- Dataset: IBM Telco Customer Churn (7,043 customer records)
-- Prerequisite: Import the dataset into telco_churn_analysis.telco_churn
-- ============================================================

CREATE DATABASE IF NOT EXISTS telco_churn_analysis;
USE telco_churn_analysis;

-- ============================================================
-- SECTION 1: DATA UNDERSTANDING AND QUALITY CHECKS
-- ============================================================

-- Query 1: Check the number of records and unique customers
SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customerID) AS unique_customers
FROM telco_churn;

-- Query 2: Preview a sample of the dataset
SELECT *
FROM telco_churn
LIMIT 10;

-- Query 3: Check for duplicate customer IDs
SELECT
    customerID,
    COUNT(*) AS record_count
FROM telco_churn
GROUP BY customerID
HAVING COUNT(*) > 1;

-- Query 4: Check selected fields for missing or blank values
SELECT
    SUM(CASE WHEN customerID IS NULL OR TRIM(customerID) = '' THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN gender IS NULL OR TRIM(gender) = '' THEN 1 ELSE 0 END) AS missing_gender,
    SUM(CASE WHEN Contract IS NULL OR TRIM(Contract) = '' THEN 1 ELSE 0 END) AS missing_contract,
    SUM(CASE WHEN Churn IS NULL OR TRIM(Churn) = '' THEN 1 ELSE 0 END) AS missing_churn,
    SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_total_charges
FROM telco_churn;

-- Query 5: Review the table's column names and data types
DESCRIBE telco_churn;

-- Query 6: Check zero-tenure customers and their total charges
SELECT
    COUNT(*) AS zero_tenure_customers,
    SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_total_charges
FROM telco_churn
WHERE tenure = 0;

-- ============================================================
-- SECTION 2: OVERALL CHURN AND CUSTOMER VALUE
-- ============================================================

-- Query 7: Calculate the overall churn rate
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS retained_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn;

-- Query 8: Compare tenure and charges for churned and retained customers
SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(AVG(tenure), 2) AS avg_tenure_months,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2) AS avg_total_charges
FROM telco_churn
GROUP BY Churn;

-- Query 9: Summarize monthly charges associated with churned and retained customers
SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(SUM(MonthlyCharges), 2) AS total_monthly_charges,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_churn
GROUP BY Churn;

-- Query 10: Create the final overall summary for the project
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS retained_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS monthly_charges_of_churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'No' THEN MonthlyCharges ELSE 0 END), 2) AS monthly_charges_of_retained_customers
FROM telco_churn;

-- ============================================================
-- SECTION 3: CHURN BY INDIVIDUAL CUSTOMER CHARACTERISTICS
-- ============================================================

-- Query 11: Analyze churn by contract type
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY Contract
ORDER BY churn_rate_percentage DESC;

-- Query 12: Analyze churn by customer tenure group
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY tenure_group
ORDER BY MIN(tenure);

-- Query 13: Analyze churn by payment method
SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY PaymentMethod
ORDER BY churn_rate_percentage DESC;

-- Query 14: Analyze churn by internet service
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY InternetService
ORDER BY churn_rate_percentage DESC;

-- Query 15: Analyze churn by technical support availability
SELECT
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY TechSupport
ORDER BY churn_rate_percentage DESC;

-- Query 16: Analyze churn by online security availability
SELECT
    OnlineSecurity,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY OnlineSecurity
ORDER BY churn_rate_percentage DESC;

-- Query 17: Analyze churn by online backup availability
SELECT
    OnlineBackup,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY OnlineBackup
ORDER BY churn_rate_percentage DESC;

-- Query 18: Analyze churn by monthly charge group
SELECT
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low Charges'
        WHEN MonthlyCharges < 70 THEN 'Medium Charges'
        ELSE 'High Charges'
    END AS charges_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY charges_group
ORDER BY MIN(MonthlyCharges);

-- Query 19: Analyze churn by senior citizen status
SELECT
    CASE WHEN SeniorCitizen = 1 THEN 'Senior Citizen' ELSE 'Non-Senior Citizen' END AS customer_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY SeniorCitizen
ORDER BY churn_rate_percentage DESC;

-- Query 20: Analyze churn by gender
SELECT
    gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY gender
ORDER BY churn_rate_percentage DESC;

-- ============================================================
-- SECTION 4: COMBINED SEGMENT ANALYSIS
-- ============================================================

-- Query 21: Analyze churn by contract type and internet service
SELECT
    Contract,
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY Contract, InternetService
HAVING COUNT(*) >= 50
ORDER BY churn_rate_percentage DESC;

-- Query 22: Rank contract and internet-service segments by churn rate
WITH segment_churn AS (
    SELECT
        Contract,
        InternetService,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS churn_rate_percentage
    FROM telco_churn
    GROUP BY Contract, InternetService
    HAVING COUNT(*) >= 50
)
SELECT
    Contract,
    InternetService,
    total_customers,
    churned_customers,
    ROUND(churn_rate_percentage, 2) AS churn_rate_percentage,
    DENSE_RANK() OVER (ORDER BY churn_rate_percentage DESC) AS churn_rank
FROM segment_churn
ORDER BY churn_rank;

-- Query 23: Identify churned customers with the highest monthly charges
SELECT
    customerID,
    tenure,
    Contract,
    InternetService,
    MonthlyCharges,
    TotalCharges
FROM telco_churn
WHERE Churn = 'Yes'
ORDER BY MonthlyCharges DESC
LIMIT 20;

-- Query 24: Analyze churn by contract type and monthly charge group
SELECT
    Contract,
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low Charges'
        WHEN MonthlyCharges < 70 THEN 'Medium Charges'
        ELSE 'High Charges'
    END AS charges_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY Contract, charges_group
HAVING COUNT(*) >= 50
ORDER BY churn_rate_percentage DESC;

-- Query 25: Analyze churn by contract type and tenure group
SELECT
    Contract,
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY Contract, tenure_group
HAVING COUNT(*) >= 50
ORDER BY MIN(tenure), churn_rate_percentage DESC;

-- Query 26: Analyze churn by contract type and technical support
SELECT
    Contract,
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY Contract, TechSupport
HAVING COUNT(*) >= 50
ORDER BY churn_rate_percentage DESC;

-- Query 27: Analyze churn by contract type and online security
SELECT
    Contract,
    OnlineSecurity,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY Contract, OnlineSecurity
HAVING COUNT(*) >= 50
ORDER BY churn_rate_percentage DESC;

-- Query 28: Analyze churn by contract type and payment method
SELECT
    Contract,
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY Contract, PaymentMethod
HAVING COUNT(*) >= 50
ORDER BY churn_rate_percentage DESC;

-- ============================================================
-- END OF ANALYSIS
-- Notes:
-- 1. Re-run the queries in MySQL Workbench against the corrected table.
-- 2. Refresh reported findings from the current outputs before publishing.
-- 3. Churn-rate differences show associations, not proof of causation.
-- 4. Monthly charges for churned customers are descriptive, not a forecast
--    of revenue that will necessarily be lost.
-- ============================================================
