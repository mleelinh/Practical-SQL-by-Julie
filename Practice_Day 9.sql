-- ex1: datalemur-laptop-mobile-viewership.
SELECT SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN NOT device_type = 'laptop' THEN 1 ELSE 0 END) AS mobile_views
FROM viewership;

-- ex2: datalemur-triangle-judgement.
SELECT *, CASE WHEN ((x+y > z) AND (x+z > y) AND (z+y>x)) THEN 'Yes' ELSE 'No' END triangle
FROM Triangle

-- ex3: datalemur-uncategorized-calls-percentage.
SELECT 
ROUND(
  CAST(
    SUM(CASE WHEN call_category IS NULL OR call_category = 'n/a' THEN 1 ELSE 0 END) AS NUMERIC
  ) / COUNT(*) * 100, 1 
)
FROM callers;

-- ex4: datalemur-find-customer-referee.
SELECT name
FROM Customer
WHERE referee_id IS DISTINCT FROM 2

-- ex5: stratascratch the-number-of-survivors.
SELECT DISTINCT(survived),
SUM(
    CASE WHEN pclass = 1 THEN 1 ELSE 0 END
) AS first_class,
SUM(
    CASE WHEN pclass = 2 THEN 1 ELSE 0 END
) AS second_class, 

SUM(
    CASE WHEN pclass = 3 THEN 1 ELSE 0 END
) AS third_class
FROM titanic
GROUP BY survived
ORDER BY survived
