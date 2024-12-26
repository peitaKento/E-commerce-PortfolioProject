use sales; 

SELECT 
    *
FROM
    ecommerce;

-- Descriptive Analysis 
-- How many unique customers?
SELECT 
    COUNT(DISTINCT customer_id) AS number_of_customer
FROM
    ecommerce; 

-- How many categories are there?
SELECT 
    category, COUNT(category) AS number_of_category
FROM
    ecommerce
GROUP BY category; 

-- What is the average age of the customers?
SELECT 
    ROUND(AVG(age), 2) as average_age
FROM
    ecommerce; 

-- What is the age distribution?
SELECT 
    CASE
        WHEN age BETWEEN 0 AND 18 THEN 'under 18'
        WHEN age BETWEEN 19 AND 29 THEN '19-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age > 69 THEN '70+'
        ELSE 'unkown'
    END AS age_group,
    gender,
    COUNT(DISTINCT customer_id) AS customer_count
FROM
    ecommerce
GROUP BY age_group , gender
ORDER BY age_group , gender;

-- How many males and females?
select gender, COUNT(DISTINCT customer_id) AS unique_customer
from ecommerce
group by gender; 

-- What is the total price by gender?
select gender, SUM(price*quantity) as total_price 
from ecommerce
group by gender;



-- performance sales & growth analysis
-- What is the average purchase amount per customer by age
SELECT 
    CASE
        WHEN age BETWEEN 0 AND 18 THEN 'under 18'
        WHEN age BETWEEN 19 AND 29 THEN '19-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age > 69 THEN '70+'
        ELSE 'unkown'
    END AS age_group,
    ROUND(AVG(price * quantity), 2) AS average_purchase_amount
FROM
    ecommerce
GROUP BY age_group;

-- What is the sales revenue by product (year)?
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    category,
    SUM(price * quantity) AS total_sales_revenue
FROM
    ecommerce
GROUP BY year , category
ORDER BY year , category; 



-- Customer behavior analysis
-- What is the total monthly sales growth? 
SELECT
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    SUM(price * quantity) AS total_sales_revenue
FROM
    ecommerce
WHERE
    date BETWEEN '2020-01-01' AND '2023-12-31'
GROUP BY
    year, month
ORDER BY
    year, month;

-- What category are most frequently purchased?
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    category,
    COUNT(category) AS total_category
FROM
    ecommerce
WHERE
    date BETWEEN '2020-01-01' AND '2023-12-31'
GROUP BY year , month , category
ORDER BY
    year, month, category;
-- What is the purchase pattern by age group?
SELECT 
    age_group, category, COUNT(*) AS purchase_count
FROM
    (SELECT 
        CASE
                WHEN age BETWEEN 0 AND 18 THEN 'under 18'
                WHEN age BETWEEN 19 AND 29 THEN '19-29'
                WHEN age BETWEEN 30 AND 39 THEN '30-39'
                WHEN age BETWEEN 40 AND 49 THEN '40-49'
                WHEN age BETWEEN 50 AND 59 THEN '50-59'
                WHEN age BETWEEN 60 AND 69 THEN '60-69'
                WHEN age > 69 THEN '70+'
                ELSE 'unknown'
            END AS age_group,
            category
    FROM
        ecommerce) AS age_distribution
GROUP BY age_group , category
ORDER BY age_group , purchase_count DESC;

-- What is the purchase pattern by gender-based?
SELECT 
    gender, purchase_year, category, COUNT(*) AS purchase_count
FROM
    (SELECT 
        gender, category, EXTRACT(YEAR FROM date) AS purchase_year
    FROM
        ecommerce) AS subquery
GROUP BY gender , purchase_year , category
ORDER BY gender , purchase_year , purchase_count DESC;

