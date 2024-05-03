create database IRS_MIGRATION;

use IRS_MIGRATION;

-- creating region table
create table region(
    state_abbr VARCHAR(2),
    state_name VARCHAR(50),
    region varchar(50),
    PRIMARY KEY (state_abbr));

-- creating year table
CREATE TABLE year (
  year INT,
  state_abbr varchar(2),
  gdp_growth DECIMAL(12, 2) ,
  population_growth DECIMAL(12, 2),
  PRIMARY KEY (year,state_abbr),
  FOREIGN KEY (state_abbr) REFERENCES region(state_abbr)
);

-- adding a constraint in year table.
ALTER TABLE year
ADD CONSTRAINT chk_gdp_growth CHECK (gdp_growth >= 0),
ADD CONSTRAINT chk_population_growth CHECK (population_growth >= 0);

-- creating state_info table.
CREATE TABLE state_info (
  state_fips INT PRIMARY KEY ,
  state_abbr VARCHAR(2),
  state_name VARCHAR(50),
  FOREIGN KEY (state_abbr) REFERENCES region(state_abbr)
);

-- creating irs_migration_info table.
CREATE TABLE irs_migration_info (
  year INT,
  source_state_fips INT,
  destination_state_fips INT,
  num_return INT,
  num_exemption INT,
  PRIMARY KEY (year, source_state_fips, num_return),
  FOREIGN KEY (year) REFERENCES year(year),
  FOREIGN KEY (source_state_fips) REFERENCES state_info(state_fips),
  FOREIGN KEY (destination_state_fips) REFERENCES state_info(state_fips)
);

-- insert data into state_info table from a csv file.
LOAD DATA LOCAL INFILE '/Users/harshilvaria/Downloads/year.csv'
	IGNORE INTO TABLE state_info
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;
-- Query OK, 52 rows affected (0.00 sec)
-- Records: 52  Deleted: 0  Skipped: 0  Warnings: 0


LOAD DATA LOCAL INFILE '/Users/harshilvaria/Downloads/irs_migration.csv'
	IGNORE INTO TABLE irs_migration_info
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;
-- Query OK, 23840 rows affected (0.19 sec)
-- Records: 23840  Deleted: 0  Skipped: 0  Warnings: 0

LOAD DATA LOCAL INFILE '/Users/harshilvaria/Downloads/year.csv'
	IGNORE INTO TABLE year
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;
-- Query OK, 2005 rows affected (0.03 sec)
-- Records: 2005  Deleted: 0  Skipped: 0  Warnings: 0



INSERT INTO region (state_abbr, state_name, region) VALUES
('AL', 'Alabama', 'Southeast'),
('AK', 'Alaska', 'West'),
('AZ', 'Arizona', 'West'),
('AR', 'Arkansas', 'South'),
('CA', 'California', 'West'),
('CO', 'Colorado', 'West'),
('CT', 'Connecticut', 'Northeast'),
('DE', 'Delaware', 'South'),
('FL', 'Florida', 'Southeast'),
('GA', 'Georgia', 'Southeast'),
('HI', 'Hawaii', 'West'),
('ID', 'Idaho', 'West'),
('IL', 'Illinois', 'Midwest'),
('IN', 'Indiana', 'Midwest'),
('IA', 'Iowa', 'Midwest'),
('KS', 'Kansas', 'Midwest'),
('KY', 'Kentucky', 'South'),
('LA', 'Louisiana', 'South'),
('ME', 'Maine', 'Northeast'),
('MD', 'Maryland', 'South'),
('MA', 'Massachusetts', 'Northeast'),
('MI', 'Michigan', 'Midwest'),
('MN', 'Minnesota', 'Midwest'),
('MS', 'Mississippi', 'South'),
('MO', 'Missouri', 'Midwest'),
('MT', 'Montana', 'West'),
('NE', 'Nebraska', 'Midwest'),
('NV', 'Nevada', 'West'),
('NH', 'New Hampshire', 'Northeast'),
('NJ', 'New Jersey', 'Northeast'),
('NM', 'New Mexico', 'West'),
('NY', 'New York', 'Northeast'),
('NC', 'North Carolina', 'Southeast'),
('ND', 'North Dakota', 'Midwest'),
('OH', 'Ohio', 'Midwest'),
('OK', 'Oklahoma', 'South'),
('OR', 'Oregon', 'West'),
('PA', 'Pennsylvania', 'Northeast'),
('RI', 'Rhode Island', 'Northeast'),
('SC', 'South Carolina', 'Southeast'),
('SD', 'South Dakota', 'Midwest'),
('TN', 'Tennessee', 'South'),
('TX', 'Texas', 'South'),
('UT', 'Utah', 'West'),
('VT', 'Vermont', 'Northeast'),
('VA', 'Virginia', 'Southeast'),
('WA', 'Washington', 'West'),
('WV', 'West Virginia', 'South'),
('WI', 'Wisconsin', 'Midwest'),
('WY', 'Wyoming', 'West');
-- Query OK, 50 rows affected (0.01 sec)
-- Records: 50  Duplicates: 0  Warnings: 0