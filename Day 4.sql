-- ex1: DataLemur Laptop Mobile Viewership
SELECT 
SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN device_type IN ('tablet','phone') THEN 1 ELSE 0 END) AS mobile_views
FROM viewership;

-- ex2: Leetcode Triangle Judgement
SELECT x,y,z,
CASE WHEN (x+y>z) AND (x+z>y) AND (y+z>x) THEN 'Yes' ELSE 'No' END triangle
FROM Triangle

-- ex3: DataLemur Uncategorized Calls Message
SELECT 
ROUND(CAST(SUM(CASE WHEN call_category IS NULL OR call_category = 'n/a' THEN 1 ELSE 0 END) AS DECIMAL)/COUNT(*)*100
, 1)
FROM callers

-- ex4: Leetcode Find Customer Referee
SELECT name
FROM Customer
WHERE referee_id IS DISTINCT FROM 2

-- ex5: Stratascratch The Number of Survivors
SELECT 
SUM(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
SUM(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
SUM(CASE WHEN pclass = 3 THEN 1 ELSE 0 END ) AS third_class
FROM titanic
