#Request 4 - Follow-up: Which segment had the most increase in unique products in 2021 vs 2020?

WITH cte_product_counts AS (
  SELECT
    dp.segment,
    COUNT(DISTINCT fsm.product_code) AS product_count,
    fiscal_year AS year
  FROM 
    fact_sales_monthly fsm
    JOIN dim_product dp ON fsm.product_code = dp.product_code
  GROUP BY dp.segment, fiscal_year
)

SELECT 
  a.segment,
  a.product_count AS product_count_2020,
  b.product_count AS product_count_2021,
  (b.product_count - a.product_count) AS difference
FROM 
  cte_product_counts a
  JOIN cte_product_counts b ON a.segment = b.segment
WHERE a.year = 2020 AND b.year = 2021
ORDER BY difference DESC