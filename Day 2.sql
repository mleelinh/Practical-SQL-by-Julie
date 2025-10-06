-- ex 1: Hackerrank Weather Observation Station 3
SELECT DISTINCT CITY FROM STATION
WHERE ID%2=0

-- ex2: Hackerrank Weather Observation Station 4
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION

-- ex3: Hackerrank The Blunder
SELECT CEILING(AVG(Salary) - AVG(REPLACE(Salary,0,"")))
FROM EMPLOYEES

-- ex4: Datalemur Alibaba Compressed Mean
SELECT 
    ROUND(
        CAST(SUM(item_count * order_occurrences) AS DECIMAL) 
        / (SUM(order_occurrences)), 
    1) AS Mean
FROM items_per_order;

-- ex5: Datalemur Matching Skills
SELECT DISTINCT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill)=3

-- ex6: Datalemur Average Post Hiatus (Part 1)
SELECT user_id, MAX(DATE(post_date)) - MIN(DATE(post_date)) AS days_between
FROM posts
WHERE DATE_PART('year',DATE(post_date))=2021
GROUP BY user_id
HAVING COUNT(post_id)>1;

-- ex7: Datalemur Cards Issued Difference
SELECT card_name, MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
HAVING COUNT(issued_amount)>1
ORDER BY difference DESC;

-- ex8: Datalemur Non Profitable Drugs
SELECT 
  manufacturer,
  COUNT(DISTINCT drug) AS drug_count,
  ABS(SUM(cogs) - SUM(total_sales)) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC;

-- ex9: Leetcode Not Boring Movies
SELECT *
FROM Cinema
WHERE id%2 != 0 AND description IS NOT 'boring'
ORDER BY rating DESC

-- ex10: Leetcode Number of Unique Subjects Taught by Each Teacher
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id
ORDER BY teacher_id

-- ex11: Leetcode Find Followers Count

-- ex12: Leetcode Classes With at Least 5 Students
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5
