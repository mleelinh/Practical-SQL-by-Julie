-- ex1: Hackerrank More Than 75 Marks
SELECT Name
FROM STUDENTS
WHERE Marks > 75
ORDER BY RIGHT(Name, 3), ID

-- ex2: Leetcode Fix Names in a Table
SELECT user_id,
UPPER(LEFT(name, 1))||LOWER(RIGHT(name, LENGTH(name)-1)) AS name
FROM Users
ORDER BY user_id

-- ex3: DataLemur Total Drugs Sales
SELECT manufacturer, 
'$' || ROUND(SUM(total_sales)/1000000) || ' million' AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC

-- ex4: DataLemur Average Review Ratings
SELECT EXTRACT(MONTH FROM submit_date) AS mth,
product_id AS product,
ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY EXTRACT(MONTH FROM submit_date), product_id
ORDER BY mth, product

-- ex5: DataLemur Teams Power Users
SELECT sender_id, COUNT(message_id) AS message_count 
FROM messages
WHERE EXTRACT(MONTH FROM sent_date)='8' AND EXTRACT(YEAR FROM sent_date)='2022'
GROUP BY sender_id
ORDER BY COUNT(message_id) DESC
LIMIT 2

-- ex6: Leetcode Invalid Tweets
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content)>15

-- ex7: Leetcode User Activity for the Past 30 Days
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN DATE '2019-06-28' AND DATE '2019-07-27'
GROUP BY activity_date
ORDER BY activity_date;

-- ex8: Stratescratch Number of Hires During Specific Time Period
SELECT COUNT(DISTINCT id)
FROM employees
WHERE joining_date BETWEEN DATE'2022-01-01' AND DATE'2022-07-31'

-- ex9: Stratascratch Positions Of Letter 'a'
SELECT POSITION('a' IN first_name)
FROM worker
WHERE first_name = 'Amitah'

-- ex10: Stratascratch Macedonian Vintages
SELECT country, SUBSTRING(title FROM 1 FOR LENGTH(winery)+5)
FROM winemag_p2
WHERE country = 'Macedonia'
