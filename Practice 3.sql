-- ex1: hackerrank-more-than-75-marks.
SELECT Name
FROM STUDENTS
WHERE Marks > 75
ORDER BY SUBSTRING(Name FROM LENGTH(Name)-2 FOR 3), ID ASC

-- ex2: leetcode-fix-names-in-a-table.
SELECT user_id, 
       CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name FROM 2))) AS name
FROM Users
ORDER BY user_id;

-- ex3: datalemur-total-drugs-sales.
SELECT manufacturer,
CONCAT('$', ROUND(SUM(total_sales)/1000000), ' million') AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer

-- ex4: avg-review-ratings.
SELECT EXTRACT(MONTH FROM submit_date) AS mth,
product_id AS product, ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY EXTRACT(MONTH FROM submit_date), product_id
ORDER BY EXTRACT(MONTH FROM submit_date), product_id

-- ex5: teams-power-users.
SELECT sender_id, COUNT(message_id) AS message_count
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = 8 AND EXTRACT(YEAR FROM sent_date) = 2022
GROUP BY sender_id
ORDER BY COUNT(message_id) DESC
LIMIT 2

-- ex6: invalid-tweets.
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15

-- ex7: user-activity-for-the-past-30-days.
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN DATE '2019-06-28' AND DATE '2019-07-27'
GROUP BY activity_date
ORDER BY activity_date;

-- ex8: number-of-hires-during-specific-time-period.
SELECT COUNT(DISTINCT id)
FROM employees
WHERE joining_date BETWEEN DATE'2022-01-01' AND DATE'2022-07-31'

-- ex9: positions-of-letter-a.
SELECT POSITION('a' IN first_name) AS position_of_a
FROM worker
WHERE first_name = 'Amitah'

-- ex10: macedonian-vintages.
