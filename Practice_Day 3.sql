-- ex1: hackerank-revising-the-select-query. 
SELECT NAME
FROM CITY
WHERE POPULATION > 120000 AND COUNTRYCODE = "USA"

-- ex2: hackerank-japanese-cities-attributes. 
SELECT *
FROM CITY
WHERE COUNTRYCODE = "JPN"

-- ex3: hackerank-weather-observation-station-1. 
SELECT CITY, STATE
FROM STATION

-- ex4: hackerank-weather-observation-station-6.
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) IN ('A','E','I','O','U')

-- ex5: hackerank-weather-observation-station-7. 
SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY, 1) IN ('A','E','I','O','U')

-- ex6: hackerank-weather-observation-station-9. 
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) NOT IN ('A','E','I','O','U')

-- ex7: hackerank-name-of-employees. 
SELECT NAME
FROM Employee
ORDER BY NAME

-- ex8: hackerank-salary-of-employees.
SELECT NAME
FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id

-- ex9: leetcode-recyclable-and-low-fat-products.
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y'

--ex10: leetcode-find-customer-referee. 
SELECT name
FROM Customer
WHERE referee_id IS NULL OR referee_id != 2
  
--ex11: leetcode-big-countries. 
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000 
  
-- ex12: leetcode-article-views. 
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id
  
-- ex13: datalemur-tesla-unfinished-part. 
SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL

--ex14: datalemur-lyft-driver-wages. 
SELECT * FROM lyft_drivers
WHERE yearly_salary <=30000 OR yearly_salary >= 70000

--ex15: datalemur-find-the-advertising-channel.
SELECT advertising_channel
FROM uber_advertising
WHERE money_spent > 100000 AND year = 2019
