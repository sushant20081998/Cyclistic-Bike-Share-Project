```sql
SELECT COUNT(*) FROM cyclistic.combined_table;
```
 5595063 rows of record before data cleaning
### Deletion of blank rows
```sql
DELETE FROM combined_Table
WHERE 
	start_station_name = '' OR 
	start_station_id = '' OR 
	end_station_name = '' OR 
	end_station_id = '' OR 
	end_lat = '' OR 
	end_lng = '';
```
- Deletion of records where ride lasts for more than a day
 ```sql 
DELETE FROM combined_table
WHERE timestampdiff(HOUR,started_at,ended_at) >=24; - 1275 rows
```
 1275 rows

- Deletion of records where ride last for less than 1 minute
```sql
DELETE FROM combined_table
WHERE timestampdiff(SECOND,started_at,ended_at) < 60;    - 34868 rows
```
 34868 rows
- Deletion of records where ride duration is negative
```sql  
DELETE FROM combined_table
WHERE timestampdiff(MINUTE,started_at,ended_at) <= 0; 
```
```sql
SELECT COUNT(*) FROM cyclistic.combined_table;
```
 4552159 rows of record after data cleaning

# Data transformation
### 1.1 Adding ride_duration column
```sql
ALTER table combined_table
ADD column ride_duration TIME;
```
-- ride_duration = ended_at - started_at
```sql
UPDATE combined_table 
SET ride_duration = timediff(ended_at,started_at);
```
-- 1.2 Creation of month column
```sql
 ALTER TABLE combined_table
 ADD COLUMN month varchar(2);
```
```sql
UPDATE combined_table
SET month = month(started_at);
```
### 1.3 Creation of day_of_week column
```sql
ALTER TABLE combined_table
ADD COLUMN day_of_week int;

UPDATE combined_table
SET day_of_week = dayofweek(started_at);
```
### 1.4 Hour in a day
```sql
ALTER TABLE combined_table
ADD COLUMN hour_in_day int;

UPDATE combined_table
SET hour_in_day = date_format(started_at,'%H');
```
```sql
alter table combined_table;
update combined_table
set ride_duration=ride_duration/100;
```
