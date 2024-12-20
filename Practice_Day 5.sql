-- ex1: hackerrank-weather-observation-station-3.
SELECT DISTINCT CITY
FROM STATION
WHERE ID%2 = 0

-- ex2: hackerrank-weather-observation-station-4.
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) AS diff_num
FROM STATION
-- ex3: hackerrank-the-blunder.

-- ex4: datalemur-alibaba-compressed-mean.

-- ex5: datalemur-matching-skills.
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) AS diff_num
FROM STATION

-- ex6: datalemur-verage-post-hiatus-1.
  
-- ex7: datalemur-cards-issued-difference.
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) AS diff_num
FROM STATION

-- ex8: datalemur-non-profitable-drugs.
SELECT manufacturer, COUNT(drug) AS drug_count, SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC

-- ex9: leetcode-not-boring-movies.
SELECT *
FROM Cinema
WHERE id%2 = 1 AND NOT description = 'boring'
ORDER BY rating DESC

-- ex10: leetcode-number-of-unique-subject.
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id

-- ex11: leetcode-find-followers-count.
SELECT user_id, COUNT(DISTINCT follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id

-- ex12:leetcode-classes-more-than-5-students.
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(*) >= 5
