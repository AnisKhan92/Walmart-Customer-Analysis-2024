# Exploratory Data Analysis Process

SELECT * 
FROM walmart_dataset_cleaned;

# Average, Minimum, Maximum, and Standard Deviation of purchase amounts

SELECT 
    ROUND(AVG(Purchase_Amount), 2) AS avg_purchase, 
    ROUND(MIN(Purchase_Amount), 2) AS min_purchase, 
    ROUND(MAX(Purchase_Amount), 2) AS max_purchase, 
    ROUND(STDDEV(Purchase_Amount), 2) AS std_purchase 
FROM walmart_dataset_cleaned;

# 1. Total Purchase Amount by City Category

SELECT 
    City_Category, 
    ROUND(SUM(Purchase_Amount), 2) AS total_purchase_amount
FROM walmart_dataset_cleaned
GROUP BY City_Category
ORDER BY total_purchase_amount DESC;

# 2. Average Purchase Amount by Product Category

SELECT 
    Product_Category, 
    ROUND(AVG(Purchase_Amount), 2) AS avg_purchase_amount
FROM walmart_dataset_cleaned
GROUP BY Product_Category
ORDER BY avg_purchase_amount DESC;

# 3. Distribution of Purchase Amounts by Ranges

SELECT 
    CASE 
        WHEN Purchase_Amount < 20 THEN '$0 - $20'
        WHEN Purchase_Amount BETWEEN 20 AND 50 THEN '$20 - $50'
        WHEN Purchase_Amount BETWEEN 50 AND 100 THEN '$50 - $100'
        WHEN Purchase_Amount BETWEEN 100 AND 200 THEN '$100 - $200'
        ELSE '$200+'
    END AS Purchase_Range,
    COUNT(*) AS Number_of_Purchases
FROM walmart_dataset_cleaned
GROUP BY Purchase_Range
ORDER BY Number_of_Purchases DESC;

# 4. Total and Average Purchase Amount for Each Occupation

SELECT 
    Occupation, 
    ROUND(SUM(Purchase_Amount), 2) AS total_purchase_amount,
    ROUND(AVG(Purchase_Amount), 2) AS avg_purchase_amount
FROM walmart_dataset_cleaned
GROUP BY Occupation
ORDER BY total_purchase_amount DESC;