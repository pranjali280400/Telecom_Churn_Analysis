-- Top 10 reasons for churn
SELECT reason, COUNT(*) AS churn_count
FROM churn_data
WHERE churn = 'Yes'
GROUP BY reason
ORDER BY churn_count DESC
LIMIT 10;

-- Average monthly charges for churned vs. non-churned customers
SELECT churn, AVG(monthly_charges) AS avg_monthly_charges
FROM churn_data
GROUP BY churn;

-- Churn by contract type
SELECT contract_type, COUNT(*) AS churn_count, 
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM churn_data WHERE churn = 'Yes'), 2) AS churn_percentage
FROM churn_data
WHERE churn = 'Yes'
GROUP BY contract_type
ORDER BY churn_percentage DESC;

-- Tenure analysis for churned customers
SELECT tenure_group, COUNT(*) AS churn_count
FROM (
    SELECT CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '12-24 months'
        WHEN tenure <= 36 THEN '24-36 months'
        WHEN tenure <= 48 THEN '36-48 months'
        ELSE '48+ months'
    END AS tenure_group
    FROM churn_data
    WHERE churn = 'Yes'
) AS tenure_data
GROUP BY tenure_group
ORDER BY churn_count DESC;
