-- ex1: DataLemur Duplicate Job Listings
WITH cte_job_count AS(
SELECT company_id, title, description, COUNT(DISTINCT job_id) AS job_count
FROM job_listings
GROUP BY company_id, title, description)

SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM cte_job_count
WHERE job_count > 1

  
-- ex2: DataLemur Highest Grossing Items
SELECT * FROM
(SELECT category, product, SUM(spend) AS total_spend
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date)=2022 AND category = 'appliance'
GROUP BY category, product
ORDER BY total_spend DESC
LIMIT 2) AS t1
UNION 
SELECT * FROM
(SELECT category, product, SUM(spend) AS total_spend
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022 AND category = 'electronics'
GROUP BY category, product
ORDER BY total_spend DESC
LIMIT 2) AS t2
ORDER BY category, total_spend DESC


-- ex3: DataLemur Frequent Callers
WITH cte_call_count AS(SELECT policy_holder_id, COUNT(case_id) AS call_count
FROM callers
GROUP BY policy_holder_id)
SELECT COUNT(policy_holder_id) AS policy_holder_count FROM cte_call_count
WHERE call_count >=3


-- ex4: DataLemur Page With No Likes
SELECT page_id FROM pages
WHERE page_id NOT IN (
SELECT DISTINCT(page_id) FROM page_likes
WHERE page_id IS NOT NULL
)

-- ex5: DataLemur User Retention
WITH cte_june AS(
SELECT DISTINCT user_id 
FROM user_actions
WHERE EXTRACT(MONTH FROM event_date) = 6
),
cte_july AS(
SELECT DISTINCT user_id 
FROM user_actions
WHERE EXTRACT(MONTH FROM event_date) = 7
)
SELECT EXTRACT(MONTH FROM event_date) AS month, COUNT(DISTINCT cte_july.user_id) AS monthly_active_users 
FROM cte_june INNER JOIN cte_july ON cte_june.user_id = cte_july.user_id
INNER JOIN user_actions ON user_actions.user_id = cte_july.user_id
WHERE EXTRACT(MONTH FROM event_date) = 7
GROUP BY EXTRACT(MONTH FROM event_date)

-- ex6: Leetcode Monthly Transactions
SELECT TO_CHAR(trans_date, 'YYYY-MM') AS month, country, COUNT(id) AS trans_count,
SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country

-- ex7: Leetcode Product Sales Analysis III
SELECT Sales.product_id, first_year, quantity,price 
FROM (SELECT product_id, MIN(year) AS first_year
FROM Sales
GROUP BY product_id
ORDER BY product_id) t1
LEFT JOIN Sales ON Sales.product_id = t1.product_id AND Sales.year = t1.first_year

-- ex8: Leetcode Customers Who Bought All Products
SELECT DISTINCT customer_id FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM Product)
ORDER BY customer_id

-- ex9: Leetcode Employees Whose Manager Left the Company
SELECT DISTINCT employee_id
FROM employees
WHERE salary < 30000 AND manager_id NOT IN  (SELECT DISTINCT employee_id FROM Employees)

-- ex10: Leetcode Primary Department for Each Employee
WITH cte_w_primary AS (
SELECT employee_id, department_id FROM Employee
WHERE primary_flag = 'Y'
ORDER BY employee_id
),
cte_wo_primary AS (
SELECT employee_id, department_id FROM Employee
WHERE employee_id NOT IN (SELECT DISTINCT employee_id FROM cte_w_primary))
SELECT * FROM cte_w_primary UNION SELECT * FROM cte_wo_primary
ORDER BY employee_id

-- ex11: Leetcode Movie Rating
SELECT * FROM (SELECT Users.name AS results FROM Users 
INNER JOIN MovieRating ON Users.user_id = MovieRating.user_id
WHERE rating = (SELECT MAX(rating)
FROM MovieRating)) -- name rating max
UNION 
SELECT * FROM (SELECT Movies.title AS results FROM Movies 
INNER JOIN MovieRating ON Movies.movie_id = MovieRating.movie_id
WHERE rating = (SELECT MAX(rating)
FROM MovieRating)) -- title film being rated

-- ex12: Leetcode Who Has the Most Friends
WITH cte_all_id AS (SELECT * FROM
(
    SELECT requester_id AS id
    FROM RequestAccepted
)
UNION ALL
SELECT * FROM
(
    SELECT accepter_id AS id
    FROM RequestAccepted
))
SELECT id, COUNT(id) AS num FROM cte_all_id
GROUP BY id
ORDER BY COUNT(id) DESC
LIMIT 1
