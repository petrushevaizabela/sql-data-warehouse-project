-- Part-to-whole Analysis

-- Which categories contribute the most overall sales
-- with subquery
SELECT
	category,
	sales_cat,
	SUM(sales_cat) OVER () AS total_sales,
	CONCAT(ROUND(CAST(sales_cat AS FLOAT) / SUM(sales_cat) OVER () * 100, 2), '%') AS contribution
FROM (
	SELECT
		p.category AS category,
		SUM(s.sales_amount) AS sales_cat
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_products p
	ON s.product_key = p.product_key
	GROUP BY p.category
)t
GROUP BY category, sales_cat
ORDER BY sales_cat DESC

-- with CTE
WITH category_sales AS (
	SELECT
		p.category AS category,
		SUM(s.sales_amount) AS sales_cat
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_products p
	ON s.product_key = p.product_key
	GROUP BY p.category
	)

SELECT
	category,
	sales_cat,
	SUM(sales_cat) OVER () AS total_sales,
	CONCAT(ROUND(CAST(sales_cat AS FLOAT) / SUM(sales_cat) OVER () * 100, 2), '%') AS contribution
FROM category_sales
GROUP BY category, sales_cat
ORDER BY sales_cat DESC
