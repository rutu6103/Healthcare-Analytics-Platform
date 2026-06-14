-- 1. Total Deaths
SELECT SUM(deaths) AS total_deaths
FROM healthcare_data;

--2. Total records
SELECT COUNT(*) AS total_records
FROM healthcare_data;

-- 3. Average age-adjusted death rate
SELECT ROUND(AVG(age_adjusted_death_rate), 2) AS avg_aadr
FROM healthcare_data;

-- 4. Top 10 causes by total deaths
SELECT cause_name, SUM(deaths) AS total_deaths
FROM healthcare_data
GROUP BY cause_name
ORDER BY total_deaths DESC
LIMIT 10;

-- 5 Top 10 states by total death
SELECT state, SUM(deaths) AS total_deaths
FROM healthcare_data
GROUP BY state
ORDER BY total_deaths DESC
LIMIT 10;

-- 6. Yearly death trend
SELECT year, SUM(deaths) AS total_deaths
FROM healthcare_data
GROUP BY year
ORDER BY year;

-- 7. Cause-wise yearly trend
SELECT year, cause_name, SUM(deaths) AS total_deaths
FROM healthcare_data
GROUP BY year, cause_name
GROUP BY year, total_deaths DESC;

-- 8. High death-rate records by state
SELECT state, COUNT(*) AS high_rate_count
FROM healthcare_data
WHERE deaths_per_100k_flag = "High"
GROUP BY state
ORDER BY high_rate_count DESC;

-- 9. Average death rate by cause
SELECT cause_name, ROUND(AVG(age_adjusted_death_rate), 2) AS avg_rate
FROM healthcare_data
GROUP BY cause_name
ORDER BY avg_rate DESC;

-- 10. State and cause combination with highest deaths
SELECT state, cause_name, SUM(deaths) AS total_deaths
FROM healthcare_data
GROUP BY state, cause_name
ORDER BY total_deaths DESC
LIMIT 20;
