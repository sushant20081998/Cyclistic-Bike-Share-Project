# 1. Initial database setup in MySQL 

### 1.1 Database creation in MySQL workbench
```sql
-- Database Creation 
CREATE database cyclistic;
 
-- Display Database 
SHOW databases; 

-- use cyclistic database 
use cyclistic;
```

### 1.2 Table creation in MySQL workbench
```sql
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
```
---
# 2. Data Import

### 2.1 Import file in MySQL via command prompt (Initial Setup)

##### Step 1: Provide MySQL bin directory path
- Copy MySQL bin directory path 
- And paste it in command prompt after cd *(space)* path
```shell
cd C:\Program Files\MySQL\MySQL Server 8.0\bin
```

##### Step 2: Connect to MySQL database
- Connect to MySQL database,
```shell
mysql -u root -p
```
- and provide our password

##### Step 3: Set global variables to import data form local computer folder and quit the server connection
- Set the global variables by using below command so that the data can be imported from local computer folder.
```shell
SET GLOBAL local_infile=1;
```
- Quit current server connection,
```shell
quit;
```
##### Step 4: Connect MySQL server again with the local-infile system variable

> **Note:**
> We'll connect with the MySQL server again with the local-infile system variable. This basically means you want to upload data into a file from a local machine.

- In order to do this, please follow the following commands,
```shell
mysql -u root -p --local_infile
```
- And enter the password
##### Step 5: Upload data
- Now provide the file path of our .csv file and table name in below chunk and execute,
```shell
 mysql> load data local infile 'C:/Users/Windows 10/Desktop/DA/Case Studies/Data Sets/202101-divvy-tripdata.csv'
    -> into table 202101_divvy
    -> fields terminated by ','
    -> enclosed by '"'
    -> lines terminated by '\r\n' ignore 1 rows;
```
Now first file of 202101-divvy-tripdata.csv has been uploaded into our cyclistic database. To check in MySQL workbench, refresh the database and it will appear.

---
### 2.2 Upload remaining .csv files (After initial setup)

##### Step 6.1: Copy table structure and create remaining tables in MySQL workbench
```sql
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
```
##### Step 6.2: Repeat uploading remaining files via command prompt
Now provide the file path of our next .csv file and next table name in below chunk and execute. Repeat this same step till we upload all files.
```shell
mysql> load data local infile 'C:/Users/Windows 10/Desktop/DA/Case Studies/Data Sets/202102-divvy-tripdata.csv'
    -> into table 202102_divvy
    -> fields terminated by ','
    -> enclosed by '"'
    -> lines terminated by '\r\n' ignore 1 rows;
```

---
# 3. Combine all tables into one in mysql workbench

- Create 'combined_Table' table, combination of all 12 tables we created
```sql
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
```
