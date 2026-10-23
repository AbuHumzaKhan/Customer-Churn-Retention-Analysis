-- PostgreSQL example: stage the raw CSV first into customer_churn_raw.
-- Keep the raw table unchanged for traceability; create a cleaned table separately.
CREATE TABLE IF NOT EXISTS customer_churn_clean AS
WITH standardized AS (
 SELECT NULLIF(BTRIM(customer_id), '') AS customer_id,
        NULLIF(BTRIM(tenure_months::text), '')::integer AS tenure_months,
        NULLIF(BTRIM(contract_type), '') AS contract_type,
        NULLIF(BTRIM(internet_service), '') AS internet_service,
        NULLIF(BTRIM(monthly_charges_inr::text), '')::numeric AS monthly_charges_inr,
        NULLIF(BTRIM(total_charges_inr::text), '')::numeric AS total_charges_inr,
        NULLIF(BTRIM(support_tickets_90d::text), '')::integer AS support_tickets_90d,
        NULLIF(BTRIM(late_payments_12m::text), '')::integer AS late_payments_12m,
        NULLIF(BTRIM(payment_method), '') AS payment_method,
        NULLIF(BTRIM(autopay_enabled), '') AS autopay_enabled,
        NULLIF(BTRIM(senior_citizen), '') AS senior_citizen,
        NULLIF(BTRIM(churned), '') AS churned,
        ROW_NUMBER() OVER (PARTITION BY BTRIM(customer_id) ORDER BY BTRIM(customer_id)) AS row_num
 FROM customer_churn_raw
)
SELECT customer_id, tenure_months, contract_type, internet_service, monthly_charges_inr,
       total_charges_inr,
       COALESCE(support_tickets_90d,
                (SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY support_tickets_90d)
                 FROM standardized s2 WHERE s2.support_tickets_90d IS NOT NULL))::integer AS support_tickets_90d,
       late_payments_12m, payment_method, autopay_enabled, senior_citizen, churned
FROM standardized WHERE row_num=1;

-- Review row counts and nulls after cleaning before promoting the table to production.
