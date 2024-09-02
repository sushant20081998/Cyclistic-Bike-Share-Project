CREATE database cyclistic;
 
use cyclistic;
-- Creating table to import data from csv file 
CREATE TABLE 202101_divvy (
	ride_id VARCHAR(255),
	rideable_type MEDIUMTEXT,
	started_at datetime,
	ended_at datetime,
	start_station_name MEDIUMTEXT,
	start_station_id MEDIUMTEXT,
	end_station_name MEDIUMTEXT,
	end_station_id MEDIUMTEXT,
	start_lat DOUBLE,
	start_lng DOUBLE,
	end_lat DOUBLE,
	end_lng DOUBLE,
	member_casual MEDIUMTEXT
);

select * from 202101_divvy;


CREATE TABLE cyclistic.`202102_divvy` LIKE cyclistic.`202101_divvy`;
CREATE TABLE cyclistic.`202103_divvy` LIKE cyclistic.`202101_divvy`;
CREATE TABLE cyclistic.`202104_divvy` LIKE cyclistic.`202101_divvy`;
CREATE TABLE cyclistic.`202105_divvy` LIKE cyclistic.`202101_divvy`;
CREATE TABLE cyclistic.`202106_divvy` LIKE cyclistic.`202101_divvy`;
CREATE TABLE cyclistic.`202107_divvy` LIKE cyclistic.`202101_divvy`;
CREATE TABLE cyclistic.`202108_divvy` LIKE cyclistic.`202101_divvy`;
CREATE TABLE cyclistic.`202109_divvy` LIKE cyclistic.`202101_divvy`;
CREATE TABLE cyclistic.`202110_divvy` LIKE cyclistic.`202101_divvy`;
CREATE TABLE cyclistic.`202111_divvy` LIKE cyclistic.`202101_divvy`;
CREATE TABLE cyclistic.`202112_divvy` LIKE cyclistic.`202101_divvy`;

-- Combining all the tabble into one single table

CREATE TABLE IF NOT EXISTS cyclistic.`combined_Table` AS ( 
	SELECT * FROM cyclistic.`202101_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202102_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202103_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202104_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202105_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202106_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202107_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202108_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202109_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202110_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202111_divvy` 
	UNION ALL 
	SELECT * FROM cyclistic.`202112_divvy` 
);
-- Data exploration using MySQL
-- 1.1 Count of all rows in comined_table
SELECT COUNT(*) FROM cyclistic.combined_table;
-- 1.2 Count of all duplicate Rows
SELECT DISTINCT COUNT(ride_id) FROM cyclistic.combined_table;

-- 1.3 blank fields in combined_table
SELECT 'blank_count_ride_id' AS column_name, count(*) AS count_value FROM cyclistic.combined_table WHERE ride_id = ''
UNION ALL
SELECT 'blank_count_rideable_type', COUNT(*) FROM cyclistic.combined_table WHERE rideable_type = ''
UNION ALL
SELECT 'blank_count_started_at', COUNT(*) FROM cyclistic.combined_table WHERE started_at is null 
UNION ALL
SELECT 'blank_count_ended_at', COUNT(*) FROM cyclistic.combined_table WHERE ended_at is null
UNION ALL
SELECT 'blank_count_start_station_name', COUNT(*) FROM cyclistic.combined_table WHERE start_station_name = ''
UNION ALL
SELECT 'blank_count_start_station_id', COUNT(*) FROM cyclistic.combined_table WHERE start_station_id = ''
UNION ALL
SELECT 'blank_count_end_station_name', COUNT(*) FROM cyclistic.combined_table WHERE end_station_name = ''
UNION ALL
SELECT 'blank_count_end_station_id', COUNT(*) FROM cyclistic.combined_table WHERE end_station_id = ''
UNION ALL
SELECT 'blank_count_start_lat', COUNT(*) FROM cyclistic.combined_table WHERE start_lat = ''
UNION ALL
SELECT 'blank_count_start_lng', COUNT(*) FROM cyclistic.combined_table WHERE start_lng = ''
UNION ALL
SELECT 'blank_count_end_lat', COUNT(*) FROM cyclistic.combined_table WHERE end_lat = ''
UNION ALL
SELECT 'blank_count_end_lng', COUNT(*) FROM cyclistic.combined_table WHERE end_lng = ''
UNION ALL
SELECT 'blank_count_member_casual', COUNT(*) FROM cyclistic.combined_table WHERE member_casual = '';

-- outliers or false values
SELECT *  FROM cyclistic.combined_table
WHERE timestampdiff(MINUTE,started_at,ended_at) < 0;  -- this query returns result where ride ends even before it start (false values) 87 rows

SELECT *  FROM cyclistic.combined_table
WHERE timestampdiff(MINUTE,started_at,ended_at) = 0; -- start time and end time is same hence total ride duration is 0 (51137 rows)

SELECT COUNT(*) AS longer_than_a_day
FROM combined_Table
WHERE TIMESTAMPDIFF(HOUR, started_at, ended_at) >= 24; -- 4026 rides where trip duration is more than a day

SELECT COUNT(*) AS less_than_a_minute
FROM combined_Table
WHERE TIMESTAMPDIFF(SECOND, started_at, ended_at) <= 60; -- 117320 rides where trip duration is less than a minute

-- -----------Cleaning of Data--------- --
SELECT COUNT(*) FROM cyclistic.combined_table; -- 5595063 rows of record before data cleaning

-- Deletion of blank rows
DELETE FROM combined_Table
WHERE 
	start_station_name = '' OR 
	start_station_id = '' OR 
	end_station_name = '' OR 
	end_station_id = '' OR 
	end_lat = '' OR 
	end_lng = '';

DELETE FROM combined_table
WHERE timestampdiff(HOUR,started_at,ended_at) >=24; -- 1275 rows

DELETE FROM combined_table
WHERE timestampdiff(SECOND,started_at,ended_at) < 60;    -- 34868 rows

DELETE FROM combined_table
WHERE timestampdiff(MINUTE,started_at,ended_at) <= 0; -- 0 rows

SELECT COUNT(*) FROM cyclistic.combined_table; -- 4552159 rows of record after data cleaning

-- Data transformation
-- 1.1 Adding ride_duration column
ALTER table combined_table
ADD column ride_duration TIME;
-- ride_duration = ended_at - started_at
UPDATE combined_table 
SET ride_duration = timediff(ended_at,started_at);

-- 1.2 Creation of month column
 ALTER TABLE combined_table
 ADD COLUMN month varchar(2);
-- 
UPDATE combined_table
SET month = month(started_at);

-- 1.3 Creation of day_of_week column
ALTER TABLE combined_table
ADD COLUMN day_of_week int;
--
UPDATE combined_table
SET day_of_week = dayofweek(started_at);

SELECT * FROM combined_table limit 10;

-- 1.4 Hour in a day
ALTER TABLE combined_table
ADD COLUMN hour_in_day int;

UPDATE combined_table
SET hour_in_day = date_format(started_at,'%H');

use cyclistic
alter table combined_table
update combined_table
set ride_duration=ride_duration/100;
