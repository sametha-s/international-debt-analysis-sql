CREATE TABLE international_debt (
	country_name TEXT,
	country_code TEXT,
	indicator_name TEXT,
	indicator_code TEXT,
	debt NUMERIC
);

SELECT *
FROM international_debt
LIMIT 10;

SELECT COUNT(*) AS total_rows
FROM international_debt;

SELECT
	COUNT(*) AS number_of_rows,
	COUNT(DISTINCT country_name) AS number_of_countries -- count each different value only once
FROM international_debt; -- number of rows: 2357 ; number of countries: 124

-- List the countries
SELECT DISTINCT country_name -- SELECT the unique country names from the table
FROM international_debt
ORDER BY country_name; -- sort the countries alphabetically


-- Find available debt categories
SELECT DISTINCT
	indicator_code,
	indicator_name
FROM international_debt
ORDER BY indicator_code;

-- Check for missing values
SELECT
	COUNT(*) AS total_rows, -- total rows: 2357
	COUNT(*) - COUNT(country_name) AS missing_country_names, -- 0 NA
	COUNT(*) - COUNT(indicator_code) AS missing_indicator_codes, -- 0 NA
	COUNT(*) - COUNT(debt) AS missing_debt_values -- 0 NA
FROM international_debt;

-- Calculate the sum of the recorded values
SELECT
	SUM(debt) AS sum_of_recorded_values
FROM international_debt; -- sum of debt column: 3079734487675.800018180

-- Group Values by Country
SELECT
	country_name,
	SUM(debt) AS sum_of_recorded_values -- Add the values within each group
FROM international_debt
GROUP BY country_name -- Put each country's rows into a group
ORDER BY sum_of_recorded_values DESC -- largest results first
LIMIT 10; -- show first ten results

-- Compare countries within one indicator
SELECT 
	country_name,
	debt
FROM international_debt
WHERE indicator_code = 'DT.AMT.BLAT.CD'
	AND debt IS NOT NULL
ORDER BY debt DESC
LIMIT 10;

