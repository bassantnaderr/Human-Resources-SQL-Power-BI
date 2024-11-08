# Human-Resources-Project
This project involves cleaning and analyzing HR employee data using SQL. It includes standardizing date formats, adding age, and conducting various analyses such as gender, race, and age distribution, turnover rates, job title breakdown, and location-based insights. The goal is to derive meaningful workforce metrics.
# Project Overview

This project focuses on cleaning and analyzing a Human Resources (HR) dataset using SQL. The dataset includes employee details, employment dates, and termination data. The goal is to standardize the data, conduct various analyses, and extract key insights into employee demographics, turnover, and other HR metrics.

# SQL Workflow Summary

# Dataset Structure

The dataset include the following columns:

- `emp_id`: Unique identifier for employees.
- `birthdate`, `hire_date`, `termdate`: Relevant dates in `DATE` format.
- `gender`, `race`, `location`, `jobtitle`, `department`: Employee demographic and job details.
- `location_state`: The state or region of the employee's location.
# Tools Used

- **SQL**
-  **Power BI**

## 1. Data Cleaning

- **Column Renaming**: Fixing encoding issues by renaming a column in the `hr` table from `ï»؟id` to `emp_id`.
- **Date Format Standardization**: Converting `birthdate` and `hire_date` to a consistent `yyyy-mm-dd` format, and removing timestamps from the `termdate` column.
- **Data Type Adjustments**: Ensuring `birthdate`, `hire_date`, and `termdate` columns are of the `DATE` type for consistency.
- **Adding Age Column**: An `age` column is calculated from the `birthdate` using the `TIMESTAMPDIFF` function.
- **Age Filtering**: Filtering out employees under 18 years of age in subsequent analyses.

## 2. Data Analysis

The dataset is analyzed using several queries to derive insights:

### Demographics:
- **What is the gender breakdown of employees in the company?**
- **What is the race breakdown of employees in the company?**

### Age Distribution:
- **What is the age distribution of employees in the company?**
- **What is the age and gender distribution of employees in the company?**

### Turnover Rates:
- **How many employees work at headquarters versus remote locations?**
- **What is the average length of employment for employees who have been terminated?**
- **Which department has the highest turnover rate?**

### Job Titles & Departments:
- **How does the gender distribution vary across departments and job titles?**
- **What is the distribution of job titles across the company?**

### Location Insights:
- **What is the distribution of employees across locations by city and state?**

### Employee Trends:
- **How has the company's employee count changed over time based on hire and termination dates?**

### Tenure Analysis:
- **What is the tenure distribution for each department?**
  
# Power BI Visualizations

In addition to SQL analysis, data from the HR dataset was visualized using Power BI. The visualizations include:

- **Employee Demographics**
- **Age and Gender Distribution**
- **Length of Employment**
- **Location Insights**
- **Employee Change Over Time**
- **Job Title and Department Analysis**
- **Race Distribution**

  
# Key Insights Generated

- **Gender and Race Breakdown**: The highest gender representation is male, and the highest race group is White.
- **Age Distribution**: The age group with the highest representation is 35-44 years old.
- **Turnover Rates**: The highest turnover rates are seen in the Auditing department, while the Marketing department has the least turnover.
- **Employee Net Change**: The company's workforce has experienced an increase in employee count over time.
- **Location Trends**: Ohio has the highest concentration of employees, with a greater percentage working in headquarters compared to remote locations.
- **Tenure Distribution**: The average tenure of employees is approximately 8 years.





