# Data Cleaning Process

SELECT * 
FROM walmart_dataset_cleaned;

# Rename Columns

ALTER TABLE walmart_dataset_cleaned
RENAME COLUMN Age TO age_group,
RENAME COLUMN purchase TO purchase_amount;

# Check for missing values

SELECT 
    SUM(User_ID IS NULL) AS missing_User_ID,
    SUM(Product_ID IS NULL) AS missing_Product_ID,
    SUM(Gender IS NULL) AS missing_Gender,
    SUM(Age_Group IS NULL) AS missing_Age,
    SUM(Occupation IS NULL) AS missing_Occupation,
    SUM(City_Category IS NULL) AS missing_City_Category,
    SUM(Stay_In_Current_City_Years IS NULL) AS missing_Stay_In_Current_City_Years,
    SUM(Marital_Status IS NULL) AS missing_Marital_Status,
    SUM(Product_Category IS NULL) AS missing_Product_Category,
    SUM(Purchase_Amount IS NULL) AS missing_Purchase
FROM walmart_dataset_cleaned;

# Check for empty strings

SELECT 
    SUM(TRIM(Product_ID) = '') AS empty_Product_ID,
    SUM(TRIM(Gender) = '') AS empty_Gender,
    SUM(TRIM(Age_Group) = '') AS empty_Age,
    SUM(TRIM(City_Category) = '') AS empty_City_Category,
    SUM(TRIM(Stay_In_Current_City_Years) = '') AS empty_Stay_In_Current_City_Years
FROM walmart_dataset_cleaned;

# Update Data Type

ALTER TABLE walmart_dataset_cleaned 
ADD COLUMN Corrected_Purchase DECIMAL(10,2);

UPDATE walmart_dataset_cleaned
SET Corrected_Purchase = Purchase_amount / 100.0;

ALTER TABLE walmart_dataset_cleaned 
DROP COLUMN Purchase_Amount;

ALTER TABLE walmart_dataset_cleaned
RENAME COLUMN Corrected_Purchase TO Purchase_Amount;

ALTER TABLE walmart_dataset_cleaned 
MODIFY Marital_Status VARCHAR(10);

UPDATE walmart_dataset_cleaned
SET Marital_Status = CASE 
    WHEN Marital_Status = '0' THEN 'Single'
    WHEN Marital_Status = '1' THEN 'Married'
    ELSE 'Unknown'
END;

# Removing Duplicates

SELECT 
    User_ID, 
    Product_ID, 
    Purchase_Amount,
    COUNT(*) AS Count
FROM walmart_dataset_cleaned
GROUP BY 
    User_ID, 
    Product_ID, 
    Purchase_Amount
HAVING COUNT(*) > 1;