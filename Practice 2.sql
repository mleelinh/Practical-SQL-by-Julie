-- ex1: hackerrank-weather-observation-station-3.
SELECT DISTINCT CITY
FROM STATION
WHERE ID%2 = 0

-- ex2: hackerrank-weather-observation-station-4.
SELECT COUNT(*) - COUNT(DISTINCT CITY)
FROM STATION

-- ex3: hackerrank-the-blunder.
  
-- ex4: datalemur-alibaba-compressed-mean.
  
-- ex5: datalemur-matching-skills.
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id

-- ex6: datalemur-verage-post-hiatus-1.
-- ex7: datalemur-cards-issued-difference.
SELECT card_name,
MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC

-- ex8: datalemur-non-profitable-drugs.
SELECT manufacturer, COUNT(drug) AS drug_count,
SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY SUM(cogs - total_sales) DESC

-- ex9: leetcode-not-boring-movies.
SELECT *
FROM Cinema
WHERE id%2 != 0 AND description != 'boring'
ORDER BY rating DESC

-- ex10: leetcode-number-of-unique-subject.
SELECT teacher_id,
COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id

-- ex11: leetcode-find-followers-count.
SELECT user_id,
COUNT(DISTINCT follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id

-- ex12:leetcode-classes-more-than-5-students.
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5
