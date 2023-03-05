#Request 8 - Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution?

WITH top_channel AS (
	SELECT
		dc.channel,
		ROUND(SUM(fsm.sold_quantity * fgp.gross_price)/1000000, 2) AS gross_sales_mln
	FROM dim_customer dc
	JOIN fact_sales_monthly fsm ON fsm.customer_code = dc.customer_code
	JOIN fact_gross_price fgp ON fgp.product_code = fsm.product_code
	WHERE fsm.fiscal_year = 2021
	GROUP BY dc.channel
	ORDER BY gross_sales_mln DESC
)

SELECT 
	channel,
	gross_sales_mln,
	ROUND(gross_sales_mln * 100 / SUM(gross_sales_mln) OVER(), 2) AS percentage
FROM top_channel;





