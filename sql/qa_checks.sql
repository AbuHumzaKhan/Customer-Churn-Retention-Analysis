-- Run after loading customer_churn.
-- Duplicate IDs (should return no rows because customer_id is primary key)
SELECT customer_id, COUNT(*) FROM customer_churn GROUP BY customer_id HAVING COUNT(*)>1;
-- Missing key fields
SELECT COUNT(*) FILTER (WHERE customer_id IS NULL OR customer_id='') AS missing_customer_id,
       COUNT(*) FILTER (WHERE churned IS NULL) AS missing_churn_label,
       COUNT(*) FILTER (WHERE monthly_charges_inr IS NULL) AS missing_monthly_charges
FROM customer_churn;
-- Invalid categorical values
SELECT DISTINCT churned FROM customer_churn WHERE churned NOT IN ('Yes','No');
-- Numeric ranges
SELECT COUNT(*) AS invalid_numeric_rows FROM customer_churn
WHERE tenure_months<0 OR monthly_charges_inr<0 OR total_charges_inr<0
   OR support_tickets_90d<0 OR late_payments_12m<0;
