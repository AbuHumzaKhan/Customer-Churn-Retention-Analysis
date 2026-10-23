let
    Source = Csv.Document(File.Contents("C:\\PATH\\TO\\customer_churn_clean.csv"), [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    TypedColumns = Table.TransformColumnTypes(PromotedHeaders, {
        {"customer_id", type text}, {"tenure_months", Int64.Type},
        {"contract_type", type text}, {"internet_service", type text},
        {"monthly_charges_inr", Currency.Type}, {"total_charges_inr", Currency.Type},
        {"support_tickets_90d", Int64.Type}, {"late_payments_12m", Int64.Type},
        {"payment_method", type text}, {"autopay_enabled", type text},
        {"senior_citizen", type text}, {"churned", type text}
    })
in
    TypedColumns
