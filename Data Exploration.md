# Data Exploration
### 1.1 Count of all rows in comined_table
``` sql
SELECT COUNT(*) FROM cyclistic.combined_table;
```
- 5595063 rows of record
### 1.2 Count of all duplicate Rows
```sql
SELECT DISTINCT COUNT(ride_id) FROM cyclistic.combined_table;
```

### 1.3 blank fields in combined_table
```sql
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
```
### outliers or false values
```sql
SELECT *  FROM cyclistic.combined_table
WHERE timestampdiff(MINUTE,started_at,ended_at) < 0;
```
- this query returns result where ride ends even before it start (false values) 87 rows
```sql
SELECT *  FROM cyclistic.combined_table
WHERE timestampdiff(MINUTE,started_at,ended_at) = 0;
```
- start time and end time is same hence total ride duration is 0 (51137 rows)
```sql
SELECT COUNT(*) AS longer_than_a_day
FROM combined_Table
WHERE TIMESTAMPDIFF(HOUR, started_at, ended_at) >= 24;
```
- 4026 rides where trip duration is more than a day
```sql
SELECT COUNT(*) AS less_than_a_minute
FROM combined_Table
WHERE TIMESTAMPDIFF(SECOND, started_at, ended_at) <= 60;
```
 - 117320 rides where trip duration is less than a minute
