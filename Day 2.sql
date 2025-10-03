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
