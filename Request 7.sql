#Request 7 - Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month. 
#            This analysis helps to get an idea of low and high-performing months and take strategic decisions.

SELECT MONTH(fsm.date) AS Month, 
       YEAR(fsm.date) AS Year, 
       SUM(fgp.gross_price * fsm.sold_quantity) AS Gross_sales_amount 
FROM fact_sales_monthly fsm 
JOIN dim_customer dc ON fsm.customer_code = dc.customer_code
JOIN fact_gross_price fgp ON fsm.product_code = fgp.product_code
WHERE dc.customer = 'Atliq Exclusive' 
GROUP BY MONTH(fsm.date), YEAR(fsm.date) 
ORDER BY YEAR(fsm.date), MONTH(fsm.date);