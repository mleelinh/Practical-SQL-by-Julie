-- Exercise 1
SELECT NAME FROM CITY
WHERE POPULATION > 120000 AND COUNTRYCODE = 'USA';

-- Exercise 2
SELECT NAME FROM CITY
WHERE POPULATION > 120000 AND COUNTRYCODE = 'USA';

-- Exercise 3
SELECT CITY, STATE FROM STATION

-- Exercise 4
SELECT DISTINCT CITY FROM STATION 
WHERE LEFT(CITY,1) IN ('A','E','I','O','U')

-- Exercise 5
SELECT DISTINCT CITY FROM STATION 
WHERE RIGHT(CITY, 1) IN ('A','E','I','O','U')

-- Exercise 6
SELECT DISTINCT CITY FROM STATION
WHERE NOT LEFT(CITY, 1) IN ('A','E','I','O','U')

-- Exercise 7
SELECT name FROM Employee
ORDER BY name

-- Exercise 8
SELECT name FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id;

-- Exercise 9
SELECT product_id FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y'

- Exercise 10
SELECT name FROM Customer
WHERE referee_id IS DISTINCT FROM 2

-- Exercise 11
SELECT name, population, area FROM World
WHERE area >=300000 AND population >= 25000000

-- Exercise 12
SELECT DISTINCT author_id AS id FROM Views 
WHERE viewer_id = author_id
ORDER BY author_id;

-- Exercise 13
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date IS NULL;

-- Exercise 14
SELECT * FROM lyft_drivers
WHERE yearly_salary <=30000 OR yearly_salary >=70000;

-- Exercise 15
SELECT * FROM uber_advertising
WHERE money_spent >=100000 AND year=2019;

