-- Date Exploration

-- Find the date of the first and last order.
-- How many years of sales are available.

SELECT
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;

-- Find the youngest and oldest customer

SELECT
	MIN(birthdate) AS oldest_customer,
	DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
	MAX(birthdate) AS yougest_customer,
	DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;

-- Finding the oldest customer by name

SELECT TOP 1
    first_name,
    last_name,
    birthdate,
    DATEDIFF(year, birthdate, GETDATE()) AS oldest_age
FROM gold.dim_customers
WHERE birthdate IS NOT NULL
ORDER BY birthdate ASC;

-- Finding the youngest customer by name

SELECT TOP 1
    first_name,
    last_name,
    birthdate,
    DATEDIFF(year, birthdate, GETDATE()) AS youngest_age
FROM gold.dim_customers
WHERE birthdate IS NOT NULL
ORDER BY birthdate DESC;
