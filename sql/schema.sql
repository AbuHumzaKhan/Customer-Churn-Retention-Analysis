-- PostgreSQL table for the curated customer-level dataset.
CREATE TABLE IF NOT EXISTS customer_churn (
 customer_id TEXT PRIMARY KEY,
 tenure_months INTEGER,
 contract_type TEXT,
 internet_service TEXT,
 monthly_charges_inr NUMERIC(12,2),
 total_charges_inr NUMERIC(14,2),
 support_tickets_90d INTEGER,
 late_payments_12m INTEGER,
 payment_method TEXT,
 autopay_enabled TEXT,
 senior_citizen TEXT,
 churned TEXT CHECK (churned IN ('Yes','No'))
);
