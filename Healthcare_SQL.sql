-- Overview of the Data
-- Retrieve all records from the insurance table
SELECT * 
FROM insurance;

-- Count the number of Rows
-- Get the total number of rows in the insurance table
SELECT COUNT(*) AS Row_num 
FROM insurance;

-- Count the number of columns
-- Get the total number of columns in the insurance table
SELECT COUNT(*) AS Columns_num
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'insurance';

-- Check for missing values in each column
-- Retrieve rows where any column value is NULL
SELECT *
FROM insurance
WHERE age IS NULL OR
      sex IS NULL OR
      children IS NULL OR
      smoker IS NULL OR
      region IS NULL OR
      charges IS NULL;

-- Identify potential outliers in the BMI column
-- Find the minimum and maximum values in the bmi column
SELECT MIN(bmi) AS Potential_Outlier1, 
       MAX(bmi) AS Potential_Outlier2 
FROM insurance;

-- Check for invalid entries in the smoker column
-- Count entries in the smoker column that are neither 0 nor 1
SELECT COUNT(smoker) AS Intruder 
FROM insurance 
WHERE smoker <> 0 AND smoker <> 1;

-- Count smokers by sex
-- Count the number of smokers (smoker = 1) grouped by sex
SELECT sex, COUNT(*) AS Sex_smoker 
FROM insurance 
WHERE smoker = 1 
GROUP BY sex 
ORDER BY sex DESC;

-- Count smokers by age
-- Count the number of smokers (smoker = 1) grouped by age
SELECT age, COUNT(*) AS Age_smoker 
FROM insurance 
WHERE smoker = 1 
GROUP BY age 
ORDER BY Age_smoker DESC;

-- Count smokers by region
-- Count the number of smokers (smoker = 1) grouped by region
SELECT region, COUNT(*) AS Region_smoker 
FROM insurance 
WHERE smoker = 1 
GROUP BY region 
ORDER BY Region_smoker DESC;

-- Count smokers by number of children
-- Count the number of smokers (smoker = 1) grouped by number of children
SELECT children, COUNT(*) AS Having_Child_smoker 
FROM insurance 
WHERE smoker = 1 
GROUP BY children 
ORDER BY Having_Child_smoker DESC;

-- Count smokers by age and sex
-- Count the number of smokers (smoker = 1) grouped by age and sex
SELECT age, sex, COUNT(*) AS Sex_Age_smoker 
FROM insurance 
WHERE smoker = 1 
GROUP BY age, sex 
ORDER BY Sex_Age_smoker DESC;

-- Count smokers by age, region, and sex
-- Count the number of smokers (smoker = 1) grouped by age, region, and sex
SELECT age, region, sex, COUNT(*) AS Sex_Region_Age_smoker 
FROM insurance 
WHERE smoker = 1 
GROUP BY age, region, sex 
ORDER BY Sex_Region_Age_smoker DESC;

-- Count smokers by children and sex
-- Count the number of smokers (smoker = 1) grouped by number of children and sex
SELECT children, sex, COUNT(*) AS Having_Child_smoker 
FROM insurance 
WHERE smoker = 1 
GROUP BY children, sex 
ORDER BY Having_Child_smoker DESC;

-- Count smokers by age, children, and sex
-- Count the number of smokers (smoker = 1) grouped by age, number of children, and sex
SELECT age, children, sex, COUNT(*) AS Having_Child_smoker 
FROM insurance 
WHERE smoker = 1 
GROUP BY children, sex, age 
ORDER BY Having_Child_smoker DESC;

-- Calculate average BMI by age
-- Calculate the average BMI grouped by age
SELECT age, AVG(bmi) AS Average_BMI 
FROM insurance 
GROUP BY age;

-- Calculate average BMI by region and smoker status
-- Calculate the average BMI grouped by region and smoker status
WITH AVG_BMI AS (
    SELECT region, smoker, AVG(bmi) AS avg_bmi 
    FROM insurance 
    GROUP BY region, smoker
)
SELECT region, smoker, avg_bmi AS Average_BMI 
FROM AVG_BMI 
ORDER BY region, smoker;

-- Average charges by BMI
-- Calculate the average charges grouped by BMI
SELECT bmi, AVG(charges) AS Average_Charges 
FROM insurance 
GROUP BY bmi 
ORDER BY bmi;

-- Average charges by number of children
-- Calculate the average charges grouped by number of children
SELECT children, AVG(charges) AS Charges_based_children 
FROM insurance 
GROUP BY children 
ORDER BY Charges_based_children DESC;

-- Average charges by region and smoker status
-- Calculate the average charges grouped by region and smoker status
SELECT region, smoker, AVG(charges) AS Charges_Reg_Smok 
FROM insurance 
GROUP BY smoker, region 
ORDER BY Charges_Reg_Smok DESC;

-- Categorize BMI and count by sex
-- Categorize BMI into Underweight, Normal, Overweight, and Obese, then count the occurrences grouped by sex
WITH BMI_Categorized AS (
    SELECT sex,
           CASE
               WHEN bmi < 18.5 THEN 'Underweight'
               WHEN bmi BETWEEN 18.5 AND 24.999 THEN 'Normal'
               WHEN bmi BETWEEN 25 AND 29.999 THEN 'Overweight'
               WHEN bmi >= 30 THEN 'Obese'
           END AS BMI_Category
    FROM insurance
)
SELECT sex, BMI_Category, COUNT(*) AS Number_Based_SEX_BMI 
FROM BMI_Categorized 
GROUP BY BMI_Category, sex;

-- Categorize BMI and count by category
-- Categorize BMI into Underweight, Normal, Overweight, and Obese, then count the occurrences grouped by category
WITH BMI_Categorized AS (
    SELECT 
           CASE
               WHEN bmi < 18.5 THEN 'Underweight'
               WHEN bmi BETWEEN 18.5 AND 24.999 THEN 'Normal'
               WHEN bmi BETWEEN 25 AND 29.999 THEN 'Overweight'
               WHEN bmi >= 30 THEN 'Obese'
           END AS BMI_Category
    FROM insurance
)
SELECT BMI_Category, COUNT(*) AS Count 
FROM BMI_Categorized 
GROUP BY BMI_Category 
ORDER BY Count DESC;

-- Distribution of Charges by BMI Category
-- Categorize BMI and calculate average, minimum, and maximum charges grouped by BMI category
WITH BMI_Categorized AS (
    SELECT 
        CASE
            WHEN bmi < 18.5 THEN 'Underweight'
            WHEN bmi BETWEEN 18.5 AND 24.999 THEN 'Normal'
            WHEN bmi BETWEEN 25 AND 29.999 THEN 'Overweight'
            WHEN bmi >= 30 THEN 'Obese'
        END AS BMI_Category,
        charges
    FROM insurance
)
SELECT BMI_Category, AVG(charges) AS Average_Charges, MIN(charges) AS Min_Charges, MAX(charges) AS Max_Charges
FROM BMI_Categorized
GROUP BY BMI_Category
ORDER BY Average_Charges DESC;

-- Calculate average BMI for smokers and non-smokers by age
-- Calculate average BMI for smokers and non-smokers grouped by age
SELECT age, 
       AVG(CASE WHEN smoker = 1 THEN bmi END) AS Average_BMI_Smokers,
       AVG(CASE WHEN smoker = 0 THEN bmi END) AS Average_BMI_NonSmokers
FROM insurance
GROUP BY age
ORDER BY age;

-- Find the age with the highest number of smokers
-- Identify the age with the highest number of smokers using ranking
WITH RankedSmokers AS (
    SELECT age, COUNT(*) AS Age_smoker,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM insurance
    WHERE smoker = 1
    GROUP BY age
)
SELECT age, Age_smoker AS AGE_WITH_HIGHEST_SMOKERS
FROM RankedSmokers
WHERE rank = 1;

-- Find the age and sex combination with the highest number of smokers
-- Identify the age and sex combination with the highest number of smokers using ranking
WITH SexAgeSmokers AS (
    SELECT age, sex, COUNT(*) AS Sex_Age_smoker,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM insurance
    WHERE smoker = 1
    GROUP BY age, sex
)
SELECT age, sex, Sex_Age_smoker AS AGE_AND_SEX_WITH_HIGHEST_SMOKERS
FROM SexAgeSmokers
WHERE rank = 1;

-- Insurance Charges by Age Group
-- Categorize ages into groups and calculate the average charges for each group
WITH Age_Groups AS (
    SELECT 
        CASE
            WHEN age BETWEEN 18 AND 29 THEN '18-29'
            WHEN age BETWEEN 30 AND 39 THEN '30-39'
            WHEN age BETWEEN 40 AND 49 THEN '40-49'
            WHEN age BETWEEN 50 AND 59 THEN '50-59'
            WHEN age >= 60 THEN '60+'
        END AS Age_Group,
        charges
    FROM insurance
)
SELECT Age_Group, AVG(charges) AS Average_Charges
FROM Age_Groups
GROUP BY Age_Group
ORDER BY Age_Group;

-- Smoker Status by Region
-- Calculate the total number of people, total smokers, total non-smokers, and percentage of smokers grouped by region
SELECT region, 
       COUNT(*) AS Total_People, 
       SUM(CAST(smoker AS int)) AS Total_Smokers, 
       SUM(CASE WHEN smoker = 0 THEN 1 ELSE 0 END) AS Total_Non_Smokers,
       ROUND((SUM(CAST(smoker AS float)) / COUNT(*)) * 100, 1) AS Percentage_Smokers
FROM insurance
GROUP BY region
ORDER BY region;

-- Charges distribution by sex
-- Calculate the average charges grouped by sex
SELECT sex, AVG(charges) AS Charges_per_sex
FROM insurance
GROUP BY sex
ORDER BY AVG(charges) DESC;
