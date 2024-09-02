# Google Capstone Cyclistic-Bike-Share-Project
Project Resources : [Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/learn/google-data-analytics-capstone)
## Project Introduction
## Scenario
- You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share
company in Chicago.
- The director of marketing believes the company’s future success
depends on maximizing the number of annual memberships.
- Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently.
- From these insights, your team will design a new marketing strategy to convert casual riders into annual
members.
- But first, Cyclistic executives must approve your recommendations, so they must be
backed up with compelling data insights and professional data visualizations.
### Characters and teams
- *Cyclistic*: A bike-share program that features more than 5,800 bicycles and 600
docking stations.
- *Lily Moreno*: The director of marketing and your manager. Moreno is responsible for
the development of campaigns and initiatives to promote the bike-share program.
These may include email, social media, and other channels.
- *Cyclistic marketing analytics team*: A team of data analysts who are responsible for
collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
- *Cyclistic executive team*: The notoriously detail-oriented executive team will decide
whether to approve the recommended marketing program

# Project Kickoff 
## Ask Phase: Business Questions & Key Stakeholders

- Three questions will guide the future marketing program:  
	1. How do annual members and casual riders use Cyclistic bikes differently?  
	2. Why would casual riders buy Cyclistic annual memberships?  
	3. How can Cyclistic use digital media to influence casual riders to become members?  

Moreno has assigned me the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?

## Prepare Phase:
### Data Gathering

I plan to utilize Cyclistic's archived trip information to conduct an analysis and detect patterns. This data can be obtained through the [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) source, with permission granted by Motivate International Inc. pursuant to their [licensing agreement](https://ride.divvybikes.com/data-license-agreement).  
Note - This is public data that you can use to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit you from using riders’ personally identifiable information. This means that you won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.
### Tool Selection for Analysis
1. **Tool for Data Cleaning, Transformation, and Processing: SQL**
	- We chose SQL for these tasks because the dataset exceeded 4.5 million rows, making it impractical to manage with Excel (which is typically suitable for datasets of less than 1 million rows). SQL's capacity to handle large volumes of data makes it the preferred choice for data wrangling.
2. **Tool for Analysis and Visualization: Tableau**
	- While there are several tools available for data visualization, including Excel and Power BI, our selection of Tableau is deliberate. Tableau offers dynamic capabilities and a diverse range of visualization options, making it the ideal choice for our analytical and visualization needs.
### Data Loading
-There are total 10 csv files containing data from Jan2021-Dec2021
-Importing and combining 10 files of data to single table please [click here](Data Collection.md)
