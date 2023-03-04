#Request 3 - Provide a report with all the unique product counts for each segment and sort them in descending order of product counts

SELECT DISTINCT segment, COUNT(product_code) AS product_count
FROM dim_product
GROUP BY segment
ORDER BY product_count DESC;