# Insurance Data Analysis Project

## Overview

This project involves the analysis of an insurance dataset using MySQL. The dataset contains attributes such as age, sex, BMI (Body Mass Index), number of children, smoking status, region, and insurance charges. The goal of the project is to perform a comprehensive exploration of the data to identify trends, patterns, and relationships that can be useful for insurance companies and health policymakers.

### Dataset Attributes:
- `age`: The age of the individual.
- `sex`: The gender of the individual.
- `bmi`: Body Mass Index, which is a measure of body fat based on height and weight.
- `children`: The number of children covered by the insurance plan.
- `smoker`: Whether the individual is a smoker (1 for yes, 0 for no).
- `region`: The individual's residential region in the US.
- `charges`: The medical insurance charges billed to the individual.

## SQL Queries and Insights

### 1. Retrieving Data:
- **View all records**: This query retrieves all rows in the dataset for a comprehensive view of the data structure.
- **Total row and column count**: Queries to find the total number of rows and columns help understand the dataset size.

### 2. Data Cleaning:
- **Check for missing values**: Ensures that no essential data is missing across key attributes.
- **Outlier detection in BMI**: Identifies any extreme values in the BMI column, which may skew the results.
- **Invalid entries in the smoker column**: Checks if there are invalid values in the `smoker` column, which should only contain 0 or 1.

### 3. Grouped Analysis of Smokers:
- **Smokers by sex, age, region, and number of children**: These queries help explore how smoking behavior varies across different demographic groups, providing valuable insights for targeted health campaigns.

### 4. BMI and Insurance Charges:
- **Average BMI by age**: This helps analyze BMI trends across age groups, shedding light on the potential health risk of different age groups.
- **Average charges by BMI and region**: Analyzes how BMI affects insurance charges, which could help insurers design more accurate pricing models.
- **BMI categorization**: Classifies individuals into BMI categories (Underweight, Normal, Overweight, Obese) and analyzes the distribution across genders.

### 5. Insurance Charges Distribution:
- **Charges by BMI Category**: This query shows how insurance charges vary across different BMI categories, providing insight into the cost implications of health conditions like obesity.
- **Charges by sex**: This query calculates average charges by gender, highlighting potential pricing differences based on sex.

### 6. Age and Smoking Insights:
- **Age and sex combination with the highest number of smokers**: Helps identify the demographic most affected by smoking, which can be critical for public health campaigns and premium adjustments.

## Benefits of the Analysis

This analysis is beneficial to both insurance companies and healthcare policymakers for several reasons:

1. **Targeted Health Initiatives**: Insights into smoking behavior across demographic groups can be used to design health intervention programs aimed at reducing smoking rates in high-risk populations.
   
2. **Pricing Model Optimization**: Understanding the relationships between BMI, age, smoking status, and charges allows for more accurate premium pricing, helping insurance companies align their pricing with the risk factors associated with each individual.

3. **Customer Segmentation**: Analyzing charges based on sex, age, and region provides useful segmentation strategies for marketing insurance products to specific groups.

4. **Health Policy Design**: Insights from the analysis, such as high-risk age groups for smoking and regions with higher average BMI, can help policymakers allocate resources effectively for public health programs.

## Conclusion

This project provides a comprehensive view of the key factors affecting insurance charges, such as age, sex, BMI, and smoking status. The insights gained can help insurance companies optimize their pricing strategies and enable policymakers to develop more effective health programs aimed at improving public well-being.

---

## SQL Queries

The SQL queries used in this project are available in the project folder. These queries analyze different aspects of the data, from identifying missing values to performing grouped analysis on smokers, BMI, and insurance charges.

---

## Requirements
- MySQL or any other relational database management system.
- The `insurance` dataset loaded into a MySQL database.

---

## Usage
1. Load the `insurance` dataset into your MySQL database.
2. Run the provided SQL queries to explore and analyze the dataset.
3. Use the insights for data-driven decision-making in insurance pricing and health policy.

---

### Author
- **Youssef Alchall**
