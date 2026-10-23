# Power BI Report Build Guide

## Import
Load `data/customer_churn_clean.csv` using Text/CSV. Set customer_id and categorical fields to Text, tenure/ticket/payment counts to Whole Number, and charge fields to Decimal Number or Fixed Decimal Number. Set `churned` to Text.

## Pages
1. **Executive Overview:** total customers, churn rate, retention rate, monthly charges, monthly charges associated with churn; churn by contract and a segment slicer.
2. **Contract & Payment:** churn rates by contract type, payment method and autopay.
3. **Experience & Tenure:** churn by tenure band, support-ticket band and late-payment count.
4. **Customer Review:** table of churned customer records sorted by monthly charges, with appropriate privacy controls in real deployments.

## Slicers
Contract type, internet service, payment method, autopay and senior-citizen flag. Use consistent filters across pages.

## Design and validation
Use clear percent formats for rates and INR labels for charges. Churn rate must be calculated as churned customers divided by all customers in the selected segment. Validate totals against the SQL output and Excel workbook. Label revenue as charges associated with churn, not forecast loss.

This repository provides DAX measures and build instructions, not a native .pbix file. Assemble and save the report in Power BI Desktop.
