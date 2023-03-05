#10 - Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021?

WITH cte1 AS (
	SELECT
		p.division,
		p.product_code,
		p.product,
		SUM(s.sold_quantity) AS total_sold_quantity
	FROM
		dim_product p
	JOIN fact_sales_monthly s
	ON s.product_code = p.product_code
	WHERE
		s.fiscal_year = 2021
	GROUP BY
		p.division,
		p.product_code,
		p.product
),
cte2 AS (
	SELECT
		division,
		product_code,
		product,
		total_sold_quantity,
	RANK() OVER (PARTITION BY division ORDER BY total_sold_quantity DESC) AS rank_order
	FROM cte1
)

SELECT 
	division,
	product_code,
	product,
	total_sold_quantity,
	rank_order
FROM cte2
WHERE rank_order <= 3;