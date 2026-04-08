-- ================================================
-- Project: Customer Churn Prediction
-- Author: Keshav Chandra Kumar
-- Tools: SQL, Python, Pandas, Excel, Power BI
-- ================================================

-- 1. Total customers kitne hain
SELECT COUNT(*) AS total_customers
FROM customer_churn;

-- 2. Kitne customers churn kiye aur kitne nahi
SELECT Churn,
       COUNT(*) AS total,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM customer_churn
GROUP BY Churn;

-- 3. Contract type ke hisab se churn rate
SELECT Contract,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY Contract
ORDER BY churn_rate DESC;

-- 4. Monthly charges ke hisab se churn
SELECT Churn,
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
       ROUND(AVG(TotalCharges), 2) AS avg_total_charges
FROM customer_churn
GROUP BY Churn;

-- 5. Tenure group ke hisab se churn (0-12, 13-24, 25-48, 49-72 months)
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49-72 months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY tenure_group
ORDER BY churn_rate DESC;

-- 6. Internet service type ke hisab se churn
SELECT InternetService,
       COUNT(*) AS total,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY InternetService
ORDER BY churn_rate DESC;

-- 7. Payment method ke hisab se churn
SELECT PaymentMethod,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

-- 8. Senior citizens mein churn rate
SELECT SeniorCitizen,
       COUNT(*) AS total,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY SeniorCitizen;

-- 9. Top 10 high risk customers (high charges + short tenure + churn = Yes)
SELECT customerID,
       MonthlyCharges,
       tenure,
       Contract,
       Churn
FROM customer_churn
WHERE Churn = 'Yes'
ORDER BY MonthlyCharges DESC
LIMIT 10;

-- 10. Gender ke hisab se churn
SELECT gender,
       COUNT(*) AS total,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY gender;
