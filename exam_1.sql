
--1. Write a query that allows you to inspect the schema of the naep table. 
 
SELECT column_name, data_type 
FROM information_schema.columns
WHERE table_name = 'naep';

-- 2. Write a query that returns the first 50 records of the naep table.
SELECT *
FROM naep 
LIMIT 50;


--3. Write a query that returns summary statistics for avg_math_4_score by state. Make sure to sort the results
--alphabetically by state name
SELECT state, COUNT(avg_math_4_score),ROUND(AVG(avg_math_4_score),2) AS average_score, MAX(avg_math_4_score) AS max_score, MIN(avg_math_4_score) AS min_score 
FROM naep 
GROUP BY state
ORDER BY state;

--4 Write a query that alters the previous query so that it returns only the summary statistics for 
--avg_math_4_score by state with differences in max and min values that are greater than 30.

SELECT state, COUNT(avg_math_4_score),ROUND(AVG(avg_math_4_score),2) AS average_score, MAX(avg_math_4_score) AS max_score, MIN(avg_math_4_score) AS min_score,(MAX(avg_math_4_score)- MIN(avg_math_4_score)) AS difference 
FROM naep 
GROUP BY state
HAVING (MAX(avg_math_4_score)- MIN(avg_math_4_score)) > 30
ORDER BY state;

--5. Write a query that returns a field called bottom_10_states that lists the states in the bottom 10
--   for avg_math_4_score in the year 2000.

SELECT state,avg_math_4_score
FROM naep
WHERE year = 2000
GROUP BY state,avg_math_4_score
ORDER BY avg_math_4_score ASC
LIMIT 10;

--6. Write a query that calculates the average avg_math_4_score rounded to the nearest 2 decimal 
--places over all states in the year 2000.

SELECT state,ROUND(avg_math_4_score,2)
FROM naep
WHERE year = 2000
GROUP BY state,avg_math_4_score
ORDER BY state;

--7. Write a query that returns a field called below_average_states_y2000 that lists all 
--states with an avg_math_4_score less than the average over all states in the year 2000.

-- calculating the average math score in year 2000 that is = 224.80
SELECT ROUND(AVG(avg_math_4_score),2)
FROM naep
WHERE year = 2000 AND avg_math_4_score IS NOT null;
-- now lets calculate the below average States 

SELECT state as below_average_states_y2000,ROUND(avg_math_4_score,2) as ave_score
FROM naep
WHERE year = 2000
GROUP BY state,avg_math_4_score
HAVING ROUND(avg_math_4_score,2) < 224.8 
ORDER BY state;

--8. Write a query that returns a field called scores_missing_y2000 that lists any states with missing values
--in the avg_math_4_score column of the naep data table for the year 2000.

SELECT state as scores_missing_y2000 
FROM naep
WHERE year = 2000 AND avg_math_4_score IS null;

--Write a query that returns for the year 2000 the state, avg_math_4_score, and total_expenditure from the naep
--table left outer joined with the finance table, using id as the key and ordered by total_expenditure greatest 
--to least. Be sure to round avg_math_4_score to the nearest 2 decimal places, and then filter out 
--NULL avg_math_4_scores in order to see any correlation more clearly.

SELECT ROUND(avg_math_4_score,2) AS avg_math_score, total_expenditure
FROM naep LEFT OUTER JOIN finance
ON naep.id = finance.id
WHERE naep.year = 2000 AND avg_math_4_score IS NOT NULL
ORDER BY total_expenditure DESC;


