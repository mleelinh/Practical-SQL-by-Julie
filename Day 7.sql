-- ex1: DataLemur Y-on-Y Growth Rate
WITH cte_curr_year_spend AS 
(SELECT EXTRACT(YEAR FROM transaction_date) as year, product_id,
spend AS curr_year_spend
FROM user_transactions)
SELECT year, product_id, curr_year_spend,
LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year) AS prev_year_spend,
ROUND((curr_year_spend - LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year)
)/LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year)*100,2) AS yoy_rate
FROM cte_curr_year_spend;

-- ex2: DataLemur Card Launch Success
SELECT DISTINCT card_name, 
FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY issue_year,issue_month) AS issued_amount
FROM monthly_cards_issued
ORDER BY issued_amount DESC;

-- ex3: DataLemur Third Transaction
SELECT user_id, spend, transaction_date FROM
(SELECT 
    user_id,
    spend,
    transaction_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS rank
FROM transactions) AS trans_num
WHERE rank = 3;

-- ex4: DataLemur Histogram Users Purchases
WITH cte_trans_rank AS
(SELECT 
transaction_date, 
user_id, 
product_id, 
RANK() OVER (PARTITION BY user_id ORDER BY transaction_date DESC) AS transaction_rank 
FROM user_transactions
ORDER BY transaction_date DESC)
SELECT transaction_date, user_id, COUNT(product_id) AS purchase_count
FROM cte_trans_rank
WHERE transaction_rank = 1
GROUP BY transaction_date, user_id
ORDER BY transaction_date;

-- ex5: DataLemur Rolling Average Tweets
SELECT user_id, tweet_date,
ROUND(AVG(tweet_count) OVER(PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2)
AS rolling_avg_3d
FROM tweets
ORDER BY user_id, tweet_date;

-- ex6: DataLemur Repeated Payments
WITH cte_payment AS (SELECT 
  merchant_id, 
  credit_card_id, 
  amount,
  transaction_timestamp,
  EXTRACT(EPOCH FROM transaction_timestamp - 
    LAG(transaction_timestamp) OVER(
      PARTITION BY merchant_id, credit_card_id, amount 
      ORDER BY transaction_timestamp)
  )/60 AS minute_difference 
FROM transactions)
SELECT COUNT(merchant_id) AS payment_count
FROM cte_payment
WHERE minute_difference <=10

-- ex7: DataLemur Highest Grossing Items
WITH cte_rank_spend AS
(SELECT category, product, SUM(spend) AS total_spend,
RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC)
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product
ORDER BY category)

SELECT category, product, total_spend
FROM cte_rank_spend 
WHERE rank <=2

-- ex8: DataLemur Top Fans Rank
WITH cte_rank_count AS
(SELECT artist_name, COUNT(global_song_rank.song_id) AS rank_count
FROM artists
JOIN songs ON artists.artist_id = songs.artist_id
JOIN global_song_rank ON songs.song_id = global_song_rank.song_id
WHERE rank <=10
GROUP BY artist_name)
SELECT artist_name, 
DENSE_RANK() OVER(ORDER BY rank_count DESC) AS artist_rank
FROM cte_rank_count
WHERE rank_count <=5 -- unchecked
