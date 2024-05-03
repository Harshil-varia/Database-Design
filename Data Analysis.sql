-- Section 3:

-- query 1
SELECT state_abbr,
       gdp_growth,
       CASE
           WHEN gdp_growth >= 2.0 THEN 'High Growth'
           WHEN gdp_growth >= 0.5 AND gdp_growth < 2.0 THEN 'Moderate Growth'
           ELSE 'Low Growth'
       END AS growth_category
FROM year
WHERE year = 2022;

-- query 2
SELECT y.year, y.gdp_growth, y.population_growth, s.state_name
FROM year y
JOIN state_info s ON y.state_abbr = s.state_abbr;

-- query 3

SELECT DISTINCT i.year, s.state_name, COUNT(i.num_return) AS total_returns
FROM irs_migration_info i
JOIN state_info s ON i.source_state_fips = s.state_fips
GROUP BY i.year, s.state_name
LIMIT 70;

-- query 4
SELECT state_abbr, total_population
FROM (
    -- Subquery to calculate total population for each state
    SELECT state_abbr, SUM(population_growth) AS total_population
    FROM year
    GROUP BY state_abbr
) AS result
WHERE total_population > 1000000;

-- query 5

-- Step 1: Create a VIEW
CREATE VIEW view_state_migration AS
SELECT i.year, r.state_name AS source_state, s.state_name AS destination_state, i.num_return
FROM irs_migration_info i
JOIN state_info r ON i.source_state_fips = r.state_fips
JOIN state_info s ON i.destination_state_fips = s.state_fips;

-- Step 2: Run a SELECT query on the view
SELECT * FROM view_state_migration;

-- Step 3: Modify one of the underlying tables
UPDATE state_info SET state_name = 'New York - Updated' WHERE state_abbr = 'NY';

-- Step 4: Re-run the SELECT query on the view, reflecting changes
SELECT * FROM view_state_migration;

