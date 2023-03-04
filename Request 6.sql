#Request 6 - Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market

WITH cte_customer_discount AS (
  SELECT fpd.customer_code, dc.customer, AVG(fpd.pre_invoice_discount_pct) AS avg_discount_pct
  FROM fact_pre_invoice_deductions fpd
  JOIN dim_customer dc ON fpd.customer_code = dc.customer_code
  WHERE fpd.fiscal_year = 2021 AND dc.market = 'India'
  GROUP BY fpd.customer_code, dc.customer
)
SELECT customer_code, customer, ROUND(avg_discount_pct, 4) AS average_discount_percentage
FROM cte_customer_discount
ORDER BY avg_discount_pct DESC
LIMIT 5;