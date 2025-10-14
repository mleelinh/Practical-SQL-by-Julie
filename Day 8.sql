-- ex1: Leetcode Immediate Food Delivery II
SELECT ROUND(SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)/CAST(COUNT(DISTINCT customer_id) AS DECIMAL)*100,2) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (SELECT customer_id, MIN(order_date)
FROM Delivery 
GROUP BY customer_id
ORDER BY customer_id)

-- ex2: Leetcode Game Play Analysis IV
SELECT ROUND(SUM(CASE WHEN day_diff = 1 THEN 1 ELSE 0 END)/CAST(COUNT(DISTINCT(player_id)) AS DECIMAL),2) AS fraction
FROM (SELECT player_id, event_date,
LEAD(event_date) OVER(PARTITION BY player_id) AS next_event_date,  
LEAD(event_date) OVER(PARTITION BY player_id) - event_date AS day_diff
FROM activity
ORDER BY player_id) t;

-- ex3: Leetcode Exchange Seats
SELECT CASE 
WHEN id%2=1 AND id+1 IN (SELECT id FROM Seat) THEN id+1
WHEN id%2=0 THEN id-1
ELSE id
END AS id, student
FROM Seat
ORDER BY id;

-- ex4: Leetcode Restaurant Growth
SELECT * FROM (WITH daily_revenue AS (
SELECT visited_on, SUM(amount) AS amount FROM Customer GROUP BY visited_on ORDER BY visited_on
)
SELECT daily_revenue.visited_on, SUM(amount) OVER(ORDER BY daily_revenue.visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
ROUND(CAST(SUM(amount) OVER(ORDER BY daily_revenue.visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS DECIMAL)/7,2) AS average_amount
FROM daily_revenue) t
WHERE  EXTRACT(DAY FROM visited_on) - EXTRACT(DAY FROM (SELECT MIN(visited_on) FROM Customer)) >=6
ORDER BY visited_on;

-- ex5: Leetcode Investment in 2016
SELECT SUM(tiv_2016) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (SELECT DISTINCT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*)>1)
AND (lat,lon) IN (SELECT lat, lon FROM Insurance GROUP BY lat,lon HAVING COUNT(*)=1)

-- ex6: Leetcode Department Top Three Salaries
WITH IT_salary_rank AS (SELECT DISTINCT salary, ROW_NUMBER() OVER(ORDER BY salary DESC) AS salary_rank
FROM Employee
WHERE departmentID = 1
GROUP BY salary
ORDER BY salary DESC
LIMIT 3),
Sales_salary_rank AS (SELECT DISTINCT salary, ROW_NUMBER() OVER(ORDER BY salary DESC) AS salary_rank
FROM Employee
WHERE departmentID = 2
GROUP BY salary
ORDER BY salary DESC
LIMIT 3)
SELECT Department.name AS Department, Employee.name AS Employee, Employee.salary AS Salary
FROM Employee
INNER JOIN Department ON Employee.departmentId = Department.id
WHERE Employee.salary IN (SELECT salary FROM IT_salary_rank) OR Employee.salary IN(SELECT salary FROM Sales_salary_rank)
ORDER BY Employee.salary DESC, Department.id, Employee.id;

-- ex7: Last Person to Fit in the Bus
WITH cte_person_on_board AS (SELECT turn, CASE WHEN total_weight < 1000 OR total_weight = 1000 AND turn+1 IN (SELECT turn FROM Queue) THEN person_name ELSE NULL END AS person_name
FROM (SELECT turn, person_id, person_name, weight, SUM(weight) OVER(ORDER BY turn) AS total_weight
FROM Queue) t)
SELECT person_name FROM cte_person_on_board
WHERE person_name IS NOT NULL
ORDER BY turn DESC
LIMIT 1

-- ex8: Leetcode Product Price at a Given Date
WITH cte_recent_prices AS (SELECT product_id, new_price, ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY change_date DESC) AS recency
FROM Products
WHERE change_date <= DATE'2019-08-16'
ORDER BY product_id, recency)
SELECT product_id, new_price AS price
FROM cte_recent_prices
WHERE recency = 1

UNION 

SELECT product_id, 10 AS price
FROM Products
WHERE product_id NOT IN (SELECT product_id FROM cte_recent_prices)
ORDER BY product_id
