CREATE DATABASE Projectss;

-- DATA CLEANNG
-- Change id Coulmn name
ALTER TABLE hr
CHANGE COLUMN ï»؟id emp_id VARCHAR (20) NULL;

DESCRIBE hr;


-- Change Birthdate Format from / TO - 
UPDATE hr
SET birthdate = 
CASE
WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
ELSE NULL
END;

-- Update Birthdate Value from Text to Date Format
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- Change hire_date Format from / TO - 
UPDATE hr
SET hire_date = 
CASE
WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
ELSE NULL
END;

-- Remove Timestamp from Termdate 
UPDATE hr
SET termdate = DATE(STR_TO_DATE(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

-- Update hire_date Value from Text to Date Format
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;



-- Remove Timestamp from Termdate 
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', DATE(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE TRUE;


-- Update termdate Value from Text to Date Format
SET SQL_MODE = 'ALLOW_INVALID_DATES';
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- Adding Age Column
ALTER TABLE hr
ADD COLUMN age INT;

UPDATE HR
SET age = timestampdiff(YEAR, birthdate, curdate());

-- Maximum and Minimum Age
SELECT MAX(AGE), MIN(AGE)
FROM hr;

select count(*)
from hr
where age < 18;

-- DATA ANALYSIS

-- 1. What is the gender breakdown of employees in the company?

SELECT gender, count(*) AS count
from hr
where age >= 18 AND termdate = '0000-00-00'
group by gender;

-- 2. What is the race breakdown of employees in the company?

SELECT race, count(*) AS count
from hr
where age >= 18 AND termdate = '0000-00-00'
group by race
order by count DESC;

-- 3. What is the age distribution of employees in the company?

SELECT MIN(age) AS Youngest, MAX(age) AS Oldest
from hr
where age >= 18 AND termdate = '0000-00-00';


SELECT 
CASE
	WHEN AGE >= 18 AND AGE <= 24 THEN '18-24'
	WHEN AGE >= 25 AND AGE <= 34 THEN '25-34'
    WHEN AGE >= 35 AND AGE <= 44 THEN '35-44'
	WHEN AGE >= 45 AND AGE <= 54 THEN '45-54'
    WHEN AGE >= 55 AND AGE <= 64 THEN '55-64'
    ELSE '65+' 
    END AS age_group, count(*) AS Count
    FROM hr
    where age >= 18 AND termdate = '0000-00-00'
    group by age_group
    order by age_group;
    
-- 4. What is the age and gender distribution of employees in the company?
    SELECT 
CASE
	WHEN AGE >= 18 AND AGE <= 24 THEN '18-24'
	WHEN AGE >= 25 AND AGE <= 34 THEN '25-34'
    WHEN AGE >= 35 AND AGE <= 44 THEN '35-44'
	WHEN AGE >= 45 AND AGE <= 54 THEN '45-54'
    WHEN AGE >= 55 AND AGE <= 64 THEN '55-64'
    ELSE '65+' 
    END AS age_group, gender, count(*) AS Count
    FROM hr
    WHERE age >= 18 AND termdate = '0000-00-00'
    GROUP BY age_group, gender
    ORDER BY age_group, gender;
    
-- 4. How many employees work at headquarters versus remote locations?

SELECT location, count(*) AS Count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?

SELECT ROUND(AVG(datediff(termdate, hire_date))/365,0) AS avg_length_employment
FROM hr
WHERE termdate <= curdate() AND termdate != '0000-00-00' AND age >= 18;

-- 6. How does the gender distribution vary across departments and job titles?

Select department, gender, count(*) as count
from hr
WHERE age >= 18 AND termdate = '0000-00-00'
group by department, gender
order by department;

-- 7. What is the distribution of job titles across the company?

SELECT jobtitle, count(*) AS Count
From hr
WHERE age >= 18 AND termdate = '0000-00-00'
Group by jobtitle
ORDER by jobtitle DESC;

-- 8. Which department has the highest turnover rate?

SELECT department, total_count, terminated_count, terminated_count/total_count AS termination_rate
FROM (
SELECT department, 
count(*) AS total_count,
SUM( CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
from hr
where age >= 18
group by department
) AS sub_query
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by city and state?

SELECT location_state, count(*) AS Count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY Count DESC ;
 
-- 10. How has the company's employee count changed over time based on hire and term_dates?
SELECT 
Year,
hires,
terminations,
hires - terminations AS net_change,
ROUND((hires- terminations)/ hires * 100 ,2) AS net_change_percentage
FROM 
(
SELECT YEAR(hire_date) as `Year`,
count(*) AS hires,
SUM( CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
 FROM hr
 WHERE age >= 18 
 GROUP BY `Year`
) AS sub_query
ORDER BY `Year` ASC;

-- 11. What is the tenure distribution for each department?

SELECT department, round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
FROM hr
WHERE termdate <> '0000-00-00' AND termdate <= curdate() AND age >= 18 
group by department;



