-- ex1: DataLemur Y-on-Y Growth Rate
WITH cte_curr_year_spend AS 
(SELECT EXTRACT(YEAR FROM transaction_date) as year, product_id,
spend AS curr_year_spend
FROM user_transactions)
SELECT year, product_id, curr_year_spend,
LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year) AS prev_year_spend,
ROUND((curr_year_spend - LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year)
)/LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year)*100,2) AS yoy_rate
FROM cte_curr_year_spend

-- ex2: DataLemur Card Launch Success
SELECT DISTINCT card_name, 
FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY issue_year,issue_month) AS issued_amount
FROM monthly_cards_issued
ORDER BY issued_amount DESC

-- ex3: DataLemur Third Transaction
