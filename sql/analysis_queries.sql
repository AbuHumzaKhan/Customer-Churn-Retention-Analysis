-- Customer Churn & Retention Analytics — PostgreSQL
-- 1. Executive KPIs
SELECT COUNT(*) AS total_customers,
       COUNT(*) FILTER (WHERE churned='Yes') AS churned_customers,
       COUNT(*) FILTER (WHERE churned='No') AS retained_customers,
       ROUND(100.0*COUNT(*) FILTER (WHERE churned='Yes')/NULLIF(COUNT(*),0),2) AS churn_rate_pct,
       ROUND(100.0*COUNT(*) FILTER (WHERE churned='No')/NULLIF(COUNT(*),0),2) AS retention_rate_pct,
       SUM(monthly_charges_inr) AS monthly_charges_inr,
       SUM(monthly_charges_inr) FILTER (WHERE churned='Yes') AS monthly_charges_associated_with_churn_inr
FROM customer_churn;

-- 2. Churn by contract type
SELECT contract_type, COUNT(*) AS customers,
       COUNT(*) FILTER (WHERE churned='Yes') AS churned_customers,
       ROUND(100.0*COUNT(*) FILTER (WHERE churned='Yes')/NULLIF(COUNT(*),0),2) AS churn_rate_pct,
       SUM(monthly_charges_inr) FILTER (WHERE churned='Yes') AS monthly_charges_associated_with_churn_inr
FROM customer_churn GROUP BY contract_type ORDER BY churn_rate_pct DESC;

-- 3. Churn by payment method
SELECT payment_method, COUNT(*) AS customers,
       COUNT(*) FILTER (WHERE churned='Yes') AS churned_customers,
       ROUND(100.0*COUNT(*) FILTER (WHERE churned='Yes')/NULLIF(COUNT(*),0),2) AS churn_rate_pct
FROM customer_churn GROUP BY payment_method ORDER BY churn_rate_pct DESC;

-- 4. Churn by tenure bands
SELECT CASE WHEN tenure_months<6 THEN '0–5 months' WHEN tenure_months<12 THEN '6–11 months'
            WHEN tenure_months<24 THEN '12–23 months' ELSE '24+ months' END AS tenure_band,
       COUNT(*) AS customers, COUNT(*) FILTER (WHERE churned='Yes') AS churned_customers,
       ROUND(100.0*COUNT(*) FILTER (WHERE churned='Yes')/NULLIF(COUNT(*),0),2) AS churn_rate_pct
FROM customer_churn GROUP BY 1 ORDER BY MIN(tenure_months);

-- 5. Churn by support-ticket band
SELECT CASE WHEN support_tickets_90d=0 THEN '0 tickets' WHEN support_tickets_90d<=2 THEN '1–2 tickets'
            ELSE '3+ tickets' END AS ticket_band,
       COUNT(*) AS customers, COUNT(*) FILTER (WHERE churned='Yes') AS churned_customers,
       ROUND(100.0*COUNT(*) FILTER (WHERE churned='Yes')/NULLIF(COUNT(*),0),2) AS churn_rate_pct
FROM customer_churn GROUP BY 1 ORDER BY MIN(support_tickets_90d);

-- 6. Highest monthly charges among churned customers (review, don't assume recoverability)
SELECT customer_id, tenure_months, contract_type, monthly_charges_inr, payment_method,
       support_tickets_90d, late_payments_12m
FROM customer_churn WHERE churned='Yes' ORDER BY monthly_charges_inr DESC LIMIT 50;
