# International Debt Analysis Using SQL

## Overview
This SQL project explores a World Bank International Debt dataset. 
I used PostgreSQL and pgAdmin to import the data, check its structure, summarise the records, and compare countries within a selected debt indicator.

## Objectives
- Count the records and distinct countries.
- Identify the available debt indicators.
- Check selected columns for missing values.
- Practice aggregating recorded values by country. 
- Compare the largest and smallest recorded values for one indicator.

## Tools
- PostgreSQL 18
- pgAdmin 4
- SQL

## Dataset
Source: World Bank data provided through the DataCamp "Analyze International Debt Statistics" project.

Dataset download: https://github.com/DataCamp-Data-Science-Projects/Project-Analyze-International-Debt-Statistics

The imported table contains 2,357 records and 124 distinct country names.

A country can appead in multiple rows because the dataset contains multiple debt indicators.

### Columns
| Column | Description |
| --- | --- |
| country_name | Country Name |
| country_code | Country Identifier |
| indicator_name | Description of the debt indicator |
| indicator_code | Indicator Identifier |
| debt | Recorded numeric value for the indicator |

## Analysis

The SQL script includes:
1. Previewing the imported records. 
2. Counting rows and distinct countries.
3. Listing countries and debt indicators.
4. Checking selected columns for NULL values.
5. Calculating the sum of recorded values.
6. Grouping record values by country.
6. Ranking countries within a selected indicator.

## Findings

### Dataset Checks
- Number of records: 2,357
- Number of distinct country names: 124
- NULL country names: 0
- NULL indicator codes: 0
- NULL debt values: 0

### Sum of recorded values
```sql
-- Calculate the sum of the recorded values
SELECT
	SUM(debt) AS sum_of_recorded_values
FROM international_debt;
```
- sum of recorded debt: approx. 3,079,734,487,675.80

### Indicator Codes
```sql
-- Find available debt categories
SELECT DISTINCT
	indicator_code,
	indicator_name
FROM international_debt
ORDER BY indicator_code;
```
- 25 unique indicator identifiers

### Sum of recorded debt grouped by country name
```sql
-- Group Values by Country
SELECT
	country_name,
	SUM(debt) AS sum_of_recorded_values -- Add the values within each group
FROM international_debt
GROUP BY country_name -- Put each country's rows into a group
ORDER BY sum_of_recorded_values DESC -- largest results first
LIMIT 10; -- show first ten results
``` 

| country_name | sum_of_recorded_values |
| --- | --- |
| China | 285,793,494,734.20 |
| Brazil | 280,623,966,140.80 |
| South Asia | 247,608,723,990.60 |
| Least developed countries: UN classification | 212,880,992,791.90 |
| Russian Federation | 191,289,057,259.20 |
| IDA only | 179,048,127,207.30 |
| Turkey | 151,125,758,035.30 |
| India | 133,627,060,958.40 |
| Mexico | 124,596,786,217.30 |
| Indonesia | 113,435,696,693.50 |

### Selected indicator comparison
```sql
-- Compare countries within one indicator
SELECT 
	country_name,
	debt
FROM international_debt
WHERE indicator_code = 'DT.AMT.BLAT.CD'
	AND debt IS NOT NULL
ORDER BY debt DESC
LIMIT 10;
```
- Indicator code: DT.AMT.BLAT.CD
- Indicator name: PPG, bilateral (AMT, current US$)
- Largest Recorded Value: Least developed countries, UN Classification (12,944,703,036.60)
- Smallest Recorded Value: Guinea-Bissau (70371.9)

## Interpretation and Limitations
- Multiple records belong to the same country, so row counts are different from country counts.
- The missing-value checks above test for SQL NULL values.
- The sum across all indicators is presented as an arithmetic exercise, not automatically as a measure of total outstanding debt.
- Indicator definitions and possible overlap must be checked before interpreting combined totals. 
- The five-column table does not include a year column. The observation period should not be checked in the source documentation.
- These findings describe the supplied dataset, not necessarily current debt conditions.

## Project files
```
international_debt_analysis.sql: table definition and analysis queries
results/ : exported query results
README.md: project overview, findings and instructions
```

