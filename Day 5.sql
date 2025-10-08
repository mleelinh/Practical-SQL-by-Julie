-- ex1: Hackerrank Average Population of Each Continent
SELECT COUNTRY.CONTINENT, FLOOR(AVG(CITY.POPULATION))
FROM CITY INNER JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.Code
GROUP BY COUNTRY.Continent;

-- ex2: DataLemur Signup Confirmation Rate
SELECT ROUND(CAST(COUNT(texts.email_id) AS DECIMAL)/COUNT(DISTINCT emails.email_id), 2) AS activation_rate
FROM emails
LEFT JOIN texts 
ON emails.email_id = texts.email_id
AND signup_action = 'Confirmed'

-- ex3: DataLemur Time Spent Snaps
SELECT 
  age.age_bucket, 
  ROUND(CAST(SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END) AS DECIMAL)/ SUM(time_spent)*100, 2) AS send_perc,
  ROUND(CAST(SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END) AS DECIMAL) / SUM(time_spent)*100, 2) AS open_perc
FROM activities
LEFT JOIN age_breakdown AS age 
  ON activities.user_id = age.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age.age_bucket;

-- ex4: DataLemur Supercloud Customer
SELECT customer_id
FROM customer_contracts AS a
INNER JOIN products AS b 
ON a.product_id = b.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category) = (SELECT COUNT(DISTINCT product_category) FROM products)
ORDER BY customer_id

-- ex5: Leetcode The Number of Employees
SELECT mng.employee_id, mng.name, COUNT(emp.employee_id) AS reports_count,
ROUND(AVG(emp.age)) AS average_age
FROM Employees emp JOIN Employees mng
ON emp.reports_to = mng.employee_id
GROUP BY mng.employee_id, mng.name
ORDER BY mng.employee_id

--ex6: List the Products Order in a Period
SELECT product_name, SUM(unit) AS unit
FROM Products t1 INNER JOIN Orders t2 ON t1.product_id = t2.product_id
WHERE EXTRACT(YEAR FROM order_date) = 2020 AND EXTRACT(MONTH FROM order_date)= 2
GROUP BY product_name
HAVING SUM(unit) >=100
