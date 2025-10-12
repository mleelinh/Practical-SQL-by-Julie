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
