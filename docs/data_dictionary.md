# Data Dictionary

One row represents one customer. The curated dataset has 800 unique customer IDs after removing eight duplicate IDs from 808 raw rows.

| Field | Definition |
|---|---|
| customer_id | Synthetic unique customer identifier |
| tenure_months | Service tenure in months |
| contract_type | Month-to-month, one-year or two-year contract |
| internet_service | Service category |
| monthly_charges_inr | Synthetic monthly charge in INR |
| total_charges_inr | Synthetic cumulative charges in INR |
| support_tickets_90d | Support tickets during the previous 90 days |
| late_payments_12m | Late-payment count during the previous 12 months |
| payment_method | Recorded synthetic payment category |
| autopay_enabled | Autopay status |
| senior_citizen | Synthetic demographic indicator |
| churned | Yes/No generated churn label |

## Limitations
The data are synthetic. Churn labels are generated from rules using customer attributes, so some segment patterns are built into the sample. There are no genuine cancellation dates or historical intervention outcomes. Revenue associated with churn is the sum of recorded monthly charges for churn-labelled customers, not a financial forecast.
