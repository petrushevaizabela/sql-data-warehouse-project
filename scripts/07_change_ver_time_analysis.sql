-- Change-Over-Time Analysis

-- Analyze Sales Performance Over Time
-- By Year

SELECT
	YEAR(order_date) AS orderyear,
	SUM(sales_amount) AS sales_amount,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)

-- By Month

SELECT
	YEAR(order_date) AS order_year,
	MONTH(order_date) AS order_month,
	SUM(sales_amount) AS sales_amount,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)

-- To keep year and month at the same time
SELECT
	DATETRUNC(month, order_date) AS order_date,
	SUM(sales_amount) AS sales_amount,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date)

-- Sales by year usign WINDOW FUNCTION (window function is more used for cumulative analysis)
SELECT
*
FROM(	
	SELECT
		YEAR(order_date) AS order_year,
		SUM(sales_amount) OVER (PARTITION BY YEAR(order_date)) AS sales_amount
	FROM gold.fact_sales
)t 
WHERE order_year IS NOT NULL
GROUP BY order_year, sales_amount
ORDER BY order_year

-- Also
SELECT DISTINCT
	YEAR(order_date) AS order_year,
	SUM(sales_amount) OVER (PARTITION BY YEAR(order_date)) AS sales_amount
FROM gold.fact_sales
WHERE order_date IS NOT NULL
ORDER BY order_year
