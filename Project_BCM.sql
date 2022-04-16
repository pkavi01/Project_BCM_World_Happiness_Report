
/* */

/* ----- Project_BCM - World Happiness Report ----- */ 

/* ----- Presented by Kavi Persand ----- */ 



/* ---------------------------------------- Task 1: ---------------------------------------------------------- 

Based on the data files provided implement a database using python library of your choice (preferably) or 
any other language with necessary tables, columns, data types and constraints. 

Create your tables in the database with appropriate naming convention.  ----------------------------------- */ 


/* Creating Database "Project_BCM" */ 

CREATE DATABASE Project_BCM 


/* Using "Project_BCM" Database for implementing tables, ... etc */

USE Project_BCM 


/* - Creating table for storing raw Country data */ 

CREATE TABLE dbo.Country(
						Country VARCHAR(100) NULL, 
						Image_File VARCHAR(MAX) NULL, 
						Image_URL VARCHAR(MAX) NULL,
						Alpha_2 VARCHAR(100) NULL,
						Alpha_3 VARCHAR(100) NULL,
						Country_Code VARCHAR(MAX) NULL,
						iso_3166_2 VARCHAR(100) NULL,
						Region VARCHAR(100) DEFAULT 'Nan',
						Sub_Region VARCHAR(100) DEFAULT NULL,
						Intermediate_Region VARCHAR(100) DEFAULT NULL,
						Region_Code VARCHAR(MAX) NULL, 
						Sub_Region_Code VARCHAR(MAX) NULL,  
						Intermediate_Region_Code VARCHAR(MAX) NULL
						)


/* Creating table for storing data from report files. */ 

/* - Creating table "Raw_WHR_2016" to store raw data from "HR_2016.csv". */

CREATE TABLE dbo.Raw_WHR_2016(
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								Lower_Confidence_Interval DECIMAL(7,5),
								Upper_Confidence_Interval DECIMAL(7,5),
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Trust DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Dystopia DECIMAL(7,5)
								)
								
								
/* - Creating table "dbo.Raw_WHR_2017" to store raw data from "happiNess_report_2017.csv". */

CREATE TABLE dbo.Raw_WHR_2017(
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								Whisker_High DECIMAL(7,5),
								Whisker_Low DECIMAL(7,5),
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Trust DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Dystopia DECIMAL(7,5)
								) 


/* - Creating table "Raw_WHR_2018" to store raw data from "2018.csv". */

CREATE TABLE dbo.Raw_WHR_2018(
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Trust DECIMAL(7,5)
								)


/* - Creating table "Raw_WHR_2019" to store raw data from "report_2019.csv". */

CREATE TABLE dbo.Raw_WHR_2019(
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Trust DECIMAL(7,5)
								)



/* ---------------------------------------- Task 2: ---------------------------------------------------------- 

Develop an automated data pipeline (using python library of your choice (preferably) or any other language) 
to trigger the process that will consume the files and load them in the tables that you created in step 1 with proper data format. 

You are expected to create a package with appropriate functions or procedures. 
All the objects that you need to create shall be available on your working environment and properly compiled. ----------------------------------- */ 


/* - Using "TRUNCATE" to remove all rows (data) from a table and "BULK INSERT" to populate the tables. */ 

TRUNCATE TABLE dbo.Country
TRUNCATE TABLE dbo.Raw_WHR_2016
TRUNCATE TABLE dbo.Raw_WHR_2017
TRUNCATE TABLE dbo.Raw_WHR_2018
TRUNCATE TABLE dbo.Raw_WHR_2019


/* Inserting data into the report tables. */ 

/* - Inserting data into "dbo.Raw_WHR_2016" from "HR_2016.csv". */

BULK INSERT dbo.Raw_WHR_2016
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\HR_2016.csv'
WITH
(

	FIRSTROW=2, /* Import of data starts as from row 2, else header will be imported as well. */
	FORMAT='CSV' 
			
)


/* List all the data which has been inserted in table "dbo.WHR_2016". */ 

SELECT * 
FROM dbo.Raw_WHR_2016  /* There are XXX records in table "dbo.Raw_WHR_2016" */ 


/* - Inserting data into "dbo.Raw_WHR_2017" from "happiNess_report_2017.csv". */

BULK INSERT dbo.Raw_WHR_2017
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\happiNess_report_2017.csv'
WITH
(

	FIRSTROW=2, /* Import of data starts as from row 2, else header will be imported as well. */
	FORMAT='CSV' 
			
)


/* List all the data which has been inserted in table "dbo.WHR_2017". */ 

SELECT * 
FROM dbo.Raw_WHR_2017  /* There are XXX records in table "dbo.Raw_WHR_2017" */ 


/* - Inserting data into "dbo.Raw_WHR_2018" from "2018.csv". */

BULK INSERT dbo.Raw_WHR_2018
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\2018.csv'
WITH
(

	FIRSTROW=2, /* Import of data starts as from row 2, else header will be imported as well. */
	FORMAT='CSV' 
			
)


/* List all the data which has been inserted in table "dbo.WHR_2018". */ 

SELECT * 
FROM dbo.Raw_WHR_2018  /* There are XXX records in table "dbo.Raw_WHR_2018" */ 


/* - Inserting data into "dbo.Raw_WHR_2019" from "report_2019.csv". */

BULK INSERT dbo.Raw_WHR_2019
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\report_2019.csv'
WITH
(

	FIRSTROW=2, /* Import of data starts as from row 2, else header will be imported as well. */
	FORMAT='CSV' 
			
)


/* List all the data which has been inserted in table "dbo.WHR_2019". */ 

SELECT * 
FROM dbo.Raw_WHR_2019  /* There are XXX records in table "dbo.Raw_WHR_2019" */ 



/* ---------------------------------------- Task 3: ---------------------------------------------------------- 

The data scientist wishes to have a modelling record in both csv and parquet format containing the details as per table below. 

Complement the existing data pipeline in step 2 to return the required information. ----------------------------------- */ 


-- Task 3.1: Overall_Happiness_Rank and Happiness_Status of Country based on Happiness_Score --

/* -- Finding Overall_Happiness_Rank and Happiness_Status of Country in table "dbo.Raw_WHR_2016" based on Happiness_Score. -- */ 

/* -- Finding Overall_Happiness_Rank using the RANK() function. -- */ 

SELECT Country, Happiness_Score, 

		RANK() OVER(

			ORDER BY Happiness_Score DESC 
			) AS Overall_Happiness_Rank 

FROM dbo.Raw_WHR_2016 		


/* -- Finding Happiness_Status using CASE -- */ 	

SELECT Country, Happiness_Score, 

			(CASE WHEN Happiness_Score < 2.6 THEN 'RED' 
				WHEN Happiness_Score BETWEEN 2.6 AND 5.6 THEN 'AMBER' 
				WHEN Happiness_Score > 5.6 THEN 'GREEN' 
				END) AS Happiness_Status		 

FROM dbo.Raw_WHR_2016 


/* --- SQL Statement to find Overall_Happiness_Rank and Happiness_Status of a Country from table "dbo.Raw_WHR_2016". --- */ 

SELECT Country, Happiness_Score, 

		RANK() OVER(

			ORDER BY Happiness_Score DESC 
			) AS Overall_Happiness_Rank, 
			
		(CASE WHEN Happiness_Score < 2.6 THEN 'RED' 
				WHEN Happiness_Score BETWEEN 2.6 AND 5.6 THEN 'AMBER' 
				WHEN Happiness_Score > 5.6 THEN 'GREEN' 
				END) AS Happiness_Status, 

		Lower_Confidence_Interval, Upper_Confidence_Interval, GDP_per_Capita, 
		Family, Health, Freedom, Trust, Generosity, Dystopia 
		
FROM dbo.Raw_WHR_2016 

/* --- x --- */ 


/* - Creating table "dbo.newRaw_WHR_2016" to store raw data from "HR_2016.csv" together with Overall_Happiness_Rank and Happiness_Status of Country. */

/* - Table "dbo.newRaw_WHR_2016" extracted and saved as "newWHR2016.csv" for analysis purposes in R STUDIO (R-Programming). */


CREATE TABLE dbo.newRaw_WHR_2016(		
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								Overall_Happiness_Rank INT DEFAULT NULL, 
								Happiness_Status VARCHAR(20), 
								Lower_Confidence_Interval DECIMAL(7,5),
								Upper_Confidence_Interval DECIMAL(7,5),
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Trust DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Dystopia DECIMAL(7,5)
								)


/* Using "TRUNCATE" to remove all rows (data) from a table. */ 

TRUNCATE TABLE dbo.newRaw_WHR_2016 


/* Inserting data in table "dbo.newRaw_WHR_2016" together with Overall_Happiness_Rank and Happiness_Status of Country. */

INSERT INTO dbo.newRaw_WHR_2016 

	SELECT Country, Happiness_Score, 

			RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Overall_Happiness_Rank, 

				(CASE WHEN Happiness_Score < 2.6 THEN 'RED' 
				WHEN Happiness_Score BETWEEN 2.6 AND 5.6 THEN 'AMBER' 
				WHEN Happiness_Score > 5.6 THEN 'GREEN' 
				END) AS Happiness_Status,

			Lower_Confidence_Interval, Upper_Confidence_Interval, GDP_per_Capita, 
			Family, Health, Freedom, Trust, Generosity, Dystopia 

	FROM dbo.Raw_WHR_2016 


/* List all the data which has been inserted in table "dbo.newRaw_WHR_2016". */ 

SELECT * 
FROM dbo.newRaw_WHR_2016  /* There are XXX records in table "dbo.newRaw_WHR_2016" */ 


/* - Table "dbo.newRaw_WHR_2016" extracted and saved as "newWHR2016.csv" for analysis purposes in R STUDIO (R-Programming). */

-- x --


/* - Creating table "dbo.newRaw_WHR_2017" to store raw data from "happiNess_report_2017.csv" together with Overall_Happiness_Rank and Happiness_Status of Country. */

/* - Table "dbo.newRaw_WHR_2017" extracted and saved as "newWHR2017.csv" for analysis purposes in R STUDIO (R-Programming). */


CREATE TABLE dbo.newRaw_WHR_2017(		
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								Overall_Happiness_Rank INT DEFAULT NULL, 
								Happiness_Status VARCHAR(20), 
								Whisker_High DECIMAL(7,5),
								Whisker_Low DECIMAL(7,5),
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Trust DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Dystopia DECIMAL(7,5)
								)


/* Using "TRUNCATE" to remove all rows (data) from a table. */ 

TRUNCATE TABLE dbo.newRaw_WHR_2017 


/* Inserting data in table "dbo.newRaw_WHR_2017" together with Overall_Happiness_Rank and Happiness_Status of Country. */

INSERT INTO dbo.newRaw_WHR_2017 

	SELECT Country, Happiness_Score, 

			RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Overall_Happiness_Rank, 

				(CASE WHEN Happiness_Score < 2.6 THEN 'RED' 
				WHEN Happiness_Score BETWEEN 2.6 AND 5.6 THEN 'AMBER' 
				WHEN Happiness_Score > 5.6 THEN 'GREEN' 
				END) AS Happiness_Status,

			Whisker_High, Whisker_Low, GDP_per_Capita, 
			Family, Health, Freedom, Trust, Generosity, Dystopia 

	FROM dbo.Raw_WHR_2017 


/* List all the data which has been inserted in table "dbo.newRaw_WHR_2017". */ 

SELECT * 
FROM dbo.newRaw_WHR_2017  /* There are XXX records in table "dbo.newRaw_WHR_2017" */ 


/* - Table "dbo.newRaw_WHR_2017" extracted and saved as "newWHR2017.csv" for analysis purposes in R STUDIO (R-Programming). */

-- x --


/* - Creating table "dbo.newRaw_WHR_2018" to store raw data from "2018.csv" together with Overall_Happiness_Rank and Happiness_Status of Country. */

/* - Table "dbo.newRaw_WHR_2018" extracted and saved as "newWHR2018.csv" for analysis purposes in R STUDIO (R-Programming). */


CREATE TABLE dbo.newRaw_WHR_2018(		
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								Overall_Happiness_Rank INT DEFAULT NULL, 
								Happiness_Status VARCHAR(20), 
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Trust DECIMAL(7,5) 
								)


/* Using "TRUNCATE" to remove all rows (data) from a table. */ 

TRUNCATE TABLE dbo.newRaw_WHR_2018 


/* Inserting data in table "dbo.newRaw_WHR_2018" together with Overall_Happiness_Rank and Happiness_Status of Country. */

INSERT INTO dbo.newRaw_WHR_2018 

	SELECT Country, Happiness_Score, 

			RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Overall_Happiness_Rank, 

				(CASE WHEN Happiness_Score < 2.6 THEN 'RED' 
				WHEN Happiness_Score BETWEEN 2.6 AND 5.6 THEN 'AMBER' 
				WHEN Happiness_Score > 5.6 THEN 'GREEN' 
				END) AS Happiness_Status,

			GDP_per_Capita, 
			Family, Health, Freedom, Generosity, Trust  

	FROM dbo.Raw_WHR_2018 


/* List all the data which has been inserted in table "dbo.newRaw_WHR_2018". */ 

SELECT * 
FROM dbo.newRaw_WHR_2018  /* There are XXX records in table "dbo.newRaw_WHR_2018" */ 


/* - Table "dbo.newRaw_WHR_2018" extracted and saved as "newWHR2018.csv" for analysis purposes in R STUDIO (R-Programming). */

-- x --


/* - Creating table "dbo.newRaw_WHR_2019" to store raw data from "report_2019.csv" together with Overall_Happiness_Rank and Happiness_Status of Country. */

/* - Table "dbo.newRaw_WHR_2019" extracted and saved as "newWHR2019.csv" for analysis purposes in R STUDIO (R-Programming). */


CREATE TABLE dbo.newRaw_WHR_2019(		
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								Overall_Happiness_Rank INT DEFAULT NULL, 
								Happiness_Status VARCHAR(20), 
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Generosity DECIMAL(7,5), 
								Trust DECIMAL(7,5)
								)


/* Using "TRUNCATE" to remove all rows (data) from a table. */ 

TRUNCATE TABLE dbo.newRaw_WHR_2019 


/* Inserting data in table "dbo.newRaw_WHR_2019" together with Overall_Happiness_Rank and Happiness_Status of Country. */

INSERT INTO dbo.newRaw_WHR_2019 

	SELECT Country, Happiness_Score, 

			RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Overall_Happiness_Rank, 

				(CASE WHEN Happiness_Score < 2.6 THEN 'RED' 
				WHEN Happiness_Score BETWEEN 2.6 AND 5.6 THEN 'AMBER' 
				WHEN Happiness_Score > 5.6 THEN 'GREEN' 
				END) AS Happiness_Status,

			GDP_per_Capita, Family, Health, Freedom, Generosity, Trust

	FROM dbo.Raw_WHR_2019 


/* List all the data which has been inserted in table "dbo.newRaw_WHR_2019". */ 

SELECT * 
FROM dbo.newRaw_WHR_2019  /* There are XXX records in table "dbo.newRaw_WHR_2019" */ 


/* - Table "dbo.newRaw_WHR_2019" extracted and saved as "newWHR2019.csv" for analysis purposes in R STUDIO (R-Programming). */

-- x --


-- Task 3.2: Dividing countries according to Region to find Region_Code, Regional_Happiness_Rank AS Rank Per Region and adding Country_URL. -- 

------------------------------------------------------------ x- REGION -x ------------------------------------------------------------ 

/* -- List all the data in table "dbo.Raw_WHR_2016" ORDER BY "Region". -- */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
ORDER BY a.Region  /* 150 rows displayed */

/* -- List of Regions: AFRICA, AMERICAS, ASIA, EUROPE, NAN and OCEANIA -- */ 


/* --- Finding Regional_Happiness_Rank using the RANK() function. --- */ 

/* -- Region in UPPERCASE and Regional Rank for table "dbo.Raw_WHR_Africa_2016". -- */

SELECT Country, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

			ORDER BY Happiness_Score DESC 
			) AS Regional_Happiness_Rank, 

		GDP_per_Capita, Family, Health, Freedom, 
		Trust, Generosity, Dystopia 

FROM dbo.Raw_WHR_Africa_2016 		

------------------------------------------------------------ x- 2016 -x ------------------------------------------------------------ 

------------------------------ AFRICA ------------------------------


/* Breaking "dbo.Raw_WHR_2016" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Africa" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Africa'  /* 39 rows displayed */ 


/* Creating table "dbo.Raw_WHR_Africa_2016" to store data pertaining to countries from the "Africa" region. */ 

CREATE TABLE dbo.Raw_WHR_Africa_2016(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Africa_2016". */ 

TRUNCATE TABLE dbo.Raw_WHR_Africa_2016 


/* - Inserting data into "dbo.Raw_WHR_Africa_2016" from "dbo.Raw_WHR_2016". */ 

INSERT INTO dbo.Raw_WHR_Africa_2016 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Africa'  /* 39 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Africa_2016". */

SELECT *
FROM dbo.Raw_WHR_Africa_2016 


/* --- Finding Regional_Happiness_Rank using the RANK() function and UPPER(Region) to display values in UPPERCASE. --- */ 

/* --Region in UPPERCASE and Regional Rank for table "dbo.Raw_WHR_Africa_2016". */

SELECT Country, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

			ORDER BY Happiness_Score DESC 
			) AS Regional_Happiness_Rank, 

		GDP_per_Capita, Family, Health, Freedom, 
		Trust, Generosity, Dystopia 

FROM dbo.Raw_WHR_Africa_2016 		


/* Creating table "dbo.WHR_Africa_2016" to store data pertaining to countries from the "Africa" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Africa_2016(
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan', 
									Happiness_Score DECIMAL(6,3), 
									Regional_Happiness_Rank INT DEFAULT NULL, 
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Trust DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Dystopia DECIMAL(7,5)
									)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Africa_2016". */ 

TRUNCATE TABLE dbo.WHR_Africa_2016 


/* - Inserting data into "dbo.WHR_Africa_2016" from "dbo.Raw_WHR_Africa_2016". */ 

INSERT INTO dbo.WHR_Africa_2016 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Africa_2016  /* 39 rows inserted */ 

/* List all the data in table "dbo.WHR_Africa_2016". */

SELECT *
FROM dbo.WHR_Africa_2016 


------------------------------ XXXXXX --------------------------------


------------------------------ AMERICAS ------------------------------


/* Breaking "dbo.Raw_WHR_2016" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Americas" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Americas'  /* 26 rows displayed */ 


/* Creating table "dbo.Raw_WHR_Americas_2016" to store data pertaining to countries from the "Americas" region. */ 

CREATE TABLE dbo.Raw_WHR_Americas_2016(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Americas_2016". */ 

TRUNCATE TABLE dbo.Raw_WHR_Americas_2016 


/* - Inserting data into "dbo.Raw_WHR_Americas_2016" from "dbo.Raw_WHR_2016". */ 

INSERT INTO dbo.Raw_WHR_Americas_2016 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Americas'  /* 26 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Americas_2016". */

SELECT *
FROM dbo.Raw_WHR_Americas_2016 


/* Creating table "dbo.WHR_Americas_2016" to store data pertaining to countries from the "Americas" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Americas_2016(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5)
										)

/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Americas_2016". */ 

TRUNCATE TABLE dbo.WHR_Americas_2016 

/* - Inserting data into "dbo.WHR_Americas_2016" from "dbo.Raw_WHR_Americas_2016". */ 

INSERT INTO dbo.WHR_Americas_2016 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Americas_2016  /* 26 rows inserted */ 

/* List all the data in table "dbo.WHR_Americas_2016". */

SELECT *
FROM dbo.WHR_Americas_2016 


------------------------------ XXXXXX ------------------------------


------------------------------ ASIA ------------------------------


//* Breaking "dbo.Raw_WHR_2016" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Asia" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Asia'  /* 44 rows displayed */


/* Creating table "dbo.Raw_WHR_Asia_2016" to store data pertaining to countries from the "Asia" region. */ 

CREATE TABLE dbo.Raw_WHR_Asia_2016(
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan',
									Happiness_Score DECIMAL(6,3),
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Trust DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Dystopia DECIMAL(7,5)
									)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Asia_2016". */ 

TRUNCATE TABLE dbo.Raw_WHR_Asia_2016 


/* - Inserting data into "dbo.Raw_WHR_Asia_2016" from "dbo.Raw_WHR_2016". */ 

INSERT INTO dbo.Raw_WHR_Asia_2016 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Asia'  /* 44 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Asia_2016". */

SELECT *
FROM dbo.Raw_WHR_Asia_2016 

	
/* Creating table "dbo.WHR_Asia_2016" to store data pertaining to countries from the "Asia" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Asia_2016(
								Country VARCHAR(100) NULL, 
								Country_URL VARCHAR(MAX) NULL, 
								Region_Code VARCHAR(MAX) NULL, 
								Region VARCHAR(100) DEFAULT 'Nan', 
								Happiness_Score DECIMAL(6,3), 
								Regional_Happiness_Rank INT DEFAULT NULL, 
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Trust DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Dystopia DECIMAL(7,5)
								)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Asia_2016". */ 

TRUNCATE TABLE dbo.WHR_Asia_2016 


/* - Inserting data into "dbo.WHR_Asia_2016" from "dbo.Raw_WHR_Asia_2016". */ 

INSERT INTO dbo.WHR_Asia_2016 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Asia_2016  /* 44 rows inserted */ 


/* List all the data in table "dbo.WHR_Asia_2016". */

SELECT *
FROM dbo.WHR_Asia_2016 


------------------------------ XXXXXX ------------------------------


------------------------------ EUROPE ------------------------------


/* Breaking "dbo.Raw_WHR_2016" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Europe" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Europe'  /* 39 rows displayed */


/* Creating table "dbo.Raw_WHR_Europe_2016" to store data pertaining to countries from the "Europe" region. */ 

CREATE TABLE dbo.Raw_WHR_Europe_2016(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5)
										)

/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Europe_2016". */ 

TRUNCATE TABLE dbo.Raw_WHR_Europe_2016 


/* - Inserting data into "dbo.Raw_WHR_Europe_2016" from "dbo.Raw_WHR_2016". */ 

INSERT INTO dbo.Raw_WHR_Europe_2016 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Europe'  /* 39 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Europe_2016". */

SELECT *
FROM dbo.Raw_WHR_Europe_2016 


/* Creating table "dbo.WHR_Europe_2016" to store data pertaining to countries from the "Europe" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Europe_2016(
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan', 
									Happiness_Score DECIMAL(6,3), 
									Regional_Happiness_Rank INT DEFAULT NULL, 
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Trust DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Dystopia DECIMAL(7,5)
									)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Europe_2016". */ 

TRUNCATE TABLE dbo.WHR_Europe_2016 


/* - Inserting data into "dbo.WHR_Europe_2016" from "dbo.Raw_WHR_Europe_2016". */ 

INSERT INTO dbo.WHR_Europe_2016 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Europe_2016  /* 39 rows inserted */ 


/* List all the data in table "dbo.WHR_Europe_2016". */

SELECT *
FROM dbo.WHR_Europe_2016 


------------------------------ XXXXXX ------------------------------


------------------------------ NAN ------------------------------


/* Breaking "dbo.Raw_WHR_2016" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Nan" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Nan'  /* 3 rows displayed */


/* Creating table "dbo.Raw_WHR_Nan_2016" to store data pertaining to countries from the "Nan" region. */ 

CREATE TABLE dbo.Raw_WHR_Nan_2016(
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan',
									Happiness_Score DECIMAL(6,3),
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Trust DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Dystopia DECIMAL(7,5)
									)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Nan_2016". */ 

TRUNCATE TABLE dbo.Raw_WHR_Nan_2016 


/* - Inserting data into "dbo.Raw_WHR_Nan_2016" from "dbo.Raw_WHR_2016". */ 

INSERT INTO dbo.Raw_WHR_Nan_2016 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Nan'  /* 3 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Nan_2016". */

SELECT *
FROM dbo.Raw_WHR_Nan_2016 


/* Creating table "dbo.WHR_Nan_2016" to store data pertaining to countries from the "Nan" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Nan_2016(
								Country VARCHAR(100) NULL, 
								Country_URL VARCHAR(MAX) NULL, 
								Region_Code VARCHAR(MAX) NULL, 
								Region VARCHAR(100) DEFAULT 'Nan', 
								Happiness_Score DECIMAL(6,3), 
								Regional_Happiness_Rank INT DEFAULT NULL, 
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Trust DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Dystopia DECIMAL(7,5)
								)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Nan_2016". */ 

TRUNCATE TABLE dbo.WHR_Nan_2016 


/* - Inserting data into "dbo.WHR_Nan_2016" from "dbo.Raw_WHR_Nan_2016". */ 

INSERT INTO dbo.WHR_Nan_2016 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Nan_2016  /* 3 rows inserted */ 


/* List all the data in table "dbo.WHR_Nan_2016". */

SELECT *
FROM dbo.WHR_Nan_2016 


------------------------------ XXXXXX ------------------------------


------------------------------ OCEANIA ------------------------------


/* Breaking "dbo.Raw_WHR_2016" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Oceania" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Oceania'  /* 2 rows displayed */


/* Creating table "dbo.Raw_WHR_Oceania_2016" to store data pertaining to countries from the "Oceania" region. */ 

CREATE TABLE dbo.Raw_WHR_Oceania_2016(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Oceania_2016". */ 

TRUNCATE TABLE dbo.Raw_WHR_Oceania_2016 


/* - Inserting data into "dbo.Raw_WHR_Oceania_2016" from "dbo.Raw_WHR_2016". */ 

INSERT INTO dbo.Raw_WHR_Oceania_2016 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2016 b
ON a.Country=b.Country 
WHERE a.Region='Oceania'  /* 2 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Oceania_2016". */

SELECT *
FROM dbo.Raw_WHR_Oceania_2016 


/* Creating table "dbo.WHR_Oceania_2016" to store data pertaining to countries from the "Oceania" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Oceania_2016(
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan', 
									Happiness_Score DECIMAL(6,3), 
									Regional_Happiness_Rank INT DEFAULT NULL, 
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Trust DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Dystopia DECIMAL(7,5)
									)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Oceania_2016". */ 

TRUNCATE TABLE dbo.WHR_Oceania_2016 


/* - Inserting data into "dbo.WHR_Oceania_2016" from "dbo.Raw_WHR_Oceania_2016". */ 

INSERT INTO dbo.WHR_Oceania_2016 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Oceania_2016  /* 2 rows inserted */ 


/* List all the data in table "dbo.WHR_Oceania_2016". */

SELECT *
FROM dbo.WHR_Oceania_2016 


------------------------------ XXXXXX ------------------------------


------------------------------------------------------------ x- 2017 -x ------------------------------------------------------------ 

------------------------------ AFRICA ------------------------------


/* Breaking "dbo.Raw_WHR_2017" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Africa" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Africa'  /* 41 rows displayed */


/* Creating table "dbo.Raw_WHR_Africa_2017" to store data pertaining to countries from the "Africa" region. */ 
	
CREATE TABLE dbo.Raw_WHR_Africa_2017(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Africa_2017". */ 

TRUNCATE TABLE dbo.Raw_WHR_Africa_2017 


/* - Inserting data into "dbo.Raw_WHR_Africa_2017" from "dbo.Raw_WHR_2017". */ 

INSERT INTO dbo.Raw_WHR_Africa_2017 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Africa'  /* 41 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Africa_2017". */

SELECT *
FROM dbo.Raw_WHR_Africa_2017 


/* --- Finding Regional_Happiness_Rank using the RANK() function. --- */ 

/* --Region in UPPERCASE and Regional Rank for table "dbo.Raw_WHR_Africa_2017". */

SELECT Country, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

			ORDER BY Happiness_Score DESC 
			) AS Regional_Happiness_Rank, 

		GDP_per_Capita, Family, Health, Freedom, 
		Trust, Generosity, Dystopia 

FROM dbo.Raw_WHR_Africa_2017 		


/* Creating table "dbo.WHR_Africa_2017" to store data pertaining to countries from the "Africa" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Africa_2017(
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan', 
									Happiness_Score DECIMAL(6,3), 
									Regional_Happiness_Rank INT DEFAULT NULL, 
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Trust DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Dystopia DECIMAL(7,5)
									)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Africa_2017". */ 

TRUNCATE TABLE dbo.WHR_Africa_2017 


/* - Inserting data into "dbo.WHR_Africa_2017" from "dbo.Raw_WHR_Africa_2017". */ 

INSERT INTO dbo.WHR_Africa_2017 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Africa_2017  /* 41 rows inserted */ 


/* List all the data in table "dbo.WHR_Africa_2017". */

SELECT *
FROM dbo.WHR_Africa_2017 


------------------------------ XXXXXX --------------------------------


------------------------------ AMERICAS ------------------------------


/* Breaking "dbo.Raw_WHR_2017" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Americas" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Americas'  /* 24 rows displayed */ 


/* Creating table "dbo.Raw_WHR_Americas_2017" to store data pertaining to countries from the "Americas" region. */ 

CREATE TABLE dbo.Raw_WHR_Americas_2017(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Americas_2017". */ 

TRUNCATE TABLE dbo.Raw_WHR_Americas_2017 


/* - Inserting data into "dbo.Raw_WHR_Americas_2017" from "dbo.Raw_WHR_2017". */ 

INSERT INTO dbo.Raw_WHR_Americas_2017 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Americas'  /* 24 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Americas_2017". */

SELECT *
FROM dbo.Raw_WHR_Americas_2017 


/* Creating table "dbo.WHR_Americas_2017" to store data pertaining to countries from the "Americas" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Americas_2017(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5)
										)

/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Americas_2017". */ 

TRUNCATE TABLE dbo.WHR_Americas_2017 

/* - Inserting data into "dbo.WHR_Americas_2017" from "dbo.Raw_WHR_Americas_2017". */ 

INSERT INTO dbo.WHR_Americas_2017 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Americas_2017  /* 24 rows inserted */ 

/* List all the data in table "dbo.WHR_Americas_2017". */

SELECT *
FROM dbo.WHR_Americas_2017 


------------------------------ XXXXXX ------------------------------


------------------------------ ASIA ------------------------------


//* Breaking "dbo.Raw_WHR_2017" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Asia" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Asia'  /* 41 rows displayed */


/* Creating table "dbo.Raw_WHR_Asia_2017" to store data pertaining to countries from the "Asia" region. */ 

CREATE TABLE dbo.Raw_WHR_Asia_2017(
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan',
									Happiness_Score DECIMAL(6,3),
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Trust DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Dystopia DECIMAL(7,5)
									)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Asia_2017". */ 

TRUNCATE TABLE dbo.Raw_WHR_Asia_2017 


/* - Inserting data into "dbo.Raw_WHR_Asia_2017" from "dbo.Raw_WHR_2017". */ 

INSERT INTO dbo.Raw_WHR_Asia_2017 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Asia'  /* 41 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Asia_2017". */

SELECT *
FROM dbo.Raw_WHR_Asia_2017 

	
/* Creating table "dbo.WHR_Asia_2017" to store data pertaining to countries from the "Asia" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Asia_2017(
								Country VARCHAR(100) NULL, 
								Country_URL VARCHAR(MAX) NULL, 
								Region_Code VARCHAR(MAX) NULL, 
								Region VARCHAR(100) DEFAULT 'Nan', 
								Happiness_Score DECIMAL(6,3), 
								Regional_Happiness_Rank INT DEFAULT NULL, 
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Trust DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Dystopia DECIMAL(7,5)
								)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Asia_2017". */ 

TRUNCATE TABLE dbo.WHR_Asia_2017 


/* - Inserting data into "dbo.WHR_Asia_2017" from "dbo.Raw_WHR_Asia_2017". */ 

INSERT INTO dbo.WHR_Asia_2017 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Asia_2017  /* 41 rows inserted */ 


/* List all the data in table "dbo.WHR_Asia_2017". */

SELECT *
FROM dbo.WHR_Asia_2017 


------------------------------ XXXXXX ------------------------------


------------------------------ EUROPE ------------------------------


/* Breaking "dbo.Raw_WHR_2017" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Europe" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Europe'  /* 39 rows displayed */


/* Creating table "dbo.Raw_WHR_Europe_2017" to store data pertaining to countries from the "Europe" region. */ 

CREATE TABLE dbo.Raw_WHR_Europe_2017(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5)
										)

/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Europe_2017". */ 

TRUNCATE TABLE dbo.Raw_WHR_Europe_2017 


/* - Inserting data into "dbo.Raw_WHR_Europe_2017" from "dbo.Raw_WHR_2017". */ 

INSERT INTO dbo.Raw_WHR_Europe_2017 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Europe'  /* 39 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Europe_2017". */

SELECT *
FROM dbo.Raw_WHR_Europe_2017 


/* Creating table "dbo.WHR_Europe_2017" to store data pertaining to countries from the "Europe" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Europe_2017(
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan', 
									Happiness_Score DECIMAL(6,3), 
									Regional_Happiness_Rank INT DEFAULT NULL, 
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Trust DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Dystopia DECIMAL(7,5)
									)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Europe_2017". */ 

TRUNCATE TABLE dbo.WHR_Europe_2017 


/* - Inserting data into "dbo.WHR_Europe_2017" from "dbo.Raw_WHR_Europe_2017". */ 

INSERT INTO dbo.WHR_Europe_2017 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Europe_2017  /* 39 rows inserted */ 


/* List all the data in table "dbo.WHR_Europe_2017". */

SELECT *
FROM dbo.WHR_Europe_2017 


------------------------------ XXXXXX ------------------------------


------------------------------ NAN ------------------------------


/* Breaking "dbo.Raw_WHR_2017" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Nan" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Nan'  /* 3 rows displayed */


/* Creating table "dbo.Raw_WHR_Nan_2017" to store data pertaining to countries from the "Nan" region. */ 

CREATE TABLE dbo.Raw_WHR_Nan_2017(
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan',
									Happiness_Score DECIMAL(6,3),
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Trust DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Dystopia DECIMAL(7,5)
									)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Nan_2017". */ 

TRUNCATE TABLE dbo.Raw_WHR_Nan_2017 


/* - Inserting data into "dbo.Raw_WHR_Nan_2017" from "dbo.Raw_WHR_2017". */ 

INSERT INTO dbo.Raw_WHR_Nan_2017 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Nan'  /* 3 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Nan_2017". */

SELECT *
FROM dbo.Raw_WHR_Nan_2017 


/* Creating table "dbo.WHR_Nan_2017" to store data pertaining to countries from the "Nan" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Nan_2017(
								Country VARCHAR(100) NULL, 
								Country_URL VARCHAR(MAX) NULL, 
								Region_Code VARCHAR(MAX) NULL, 
								Region VARCHAR(100) DEFAULT 'Nan', 
								Happiness_Score DECIMAL(6,3), 
								Regional_Happiness_Rank INT DEFAULT NULL, 
								GDP_per_Capita DECIMAL(7,5),
								Family DECIMAL(7,5),
								Health DECIMAL(7,5),
								Freedom DECIMAL(7,5),
								Trust DECIMAL(7,5),
								Generosity DECIMAL(7,5),
								Dystopia DECIMAL(7,5)
								)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Nan_2017". */ 

TRUNCATE TABLE dbo.WHR_Nan_2017 


/* - Inserting data into "dbo.WHR_Nan_2017" from "dbo.Raw_WHR_Nan_2017". */ 

INSERT INTO dbo.WHR_Nan_2017 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Nan_2017  /* 3 rows inserted */ 


/* List all the data in table "dbo.WHR_Nan_2017". */

SELECT *
FROM dbo.WHR_Nan_2017 


------------------------------ XXXXXX ------------------------------


------------------------------ OCEANIA ------------------------------


/* Breaking "dbo.Raw_WHR_2017" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Oceania" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Oceania'  /* 2 rows displayed */


/* Creating table "dbo.Raw_WHR_Oceania_2017" to store data pertaining to countries from the "Oceania" region. */ 

CREATE TABLE dbo.Raw_WHR_Oceania_2017(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Oceania_2017". */ 

TRUNCATE TABLE dbo.Raw_WHR_Oceania_2017 


/* - Inserting data into "dbo.Raw_WHR_Oceania_2017" from "dbo.Raw_WHR_2017". */ 

INSERT INTO dbo.Raw_WHR_Oceania_2017 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2017 b
ON a.Country=b.Country 
WHERE a.Region='Oceania'  /* 2 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Oceania_2017". */

SELECT *
FROM dbo.Raw_WHR_Oceania_2017 


/* Creating table "dbo.WHR_Oceania_2017" to store data pertaining to countries from the "Oceania" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Oceania_2017(
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan', 
									Happiness_Score DECIMAL(6,3), 
									Regional_Happiness_Rank INT DEFAULT NULL, 
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Trust DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Dystopia DECIMAL(7,5)
									)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Oceania_2017". */ 

TRUNCATE TABLE dbo.WHR_Oceania_2017 


/* - Inserting data into "dbo.WHR_Oceania_2017" from "dbo.Raw_WHR_Oceania_2017". */ 

INSERT INTO dbo.WHR_Oceania_2017 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Oceania_2017  /* 2 rows inserted */ 


/* List all the data in table "dbo.WHR_Oceania_2017". */

SELECT *
FROM dbo.WHR_Oceania_2017 


------------------------------ XXXXXX ------------------------------


------------------------------------------------------------ x- 2018 -x ------------------------------------------------------------ 

------------------------------ AFRICA ------------------------------


/* Breaking "dbo.Raw_WHR_2018" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Africa" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Generosity, b.Trust
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b  /* Converting "Trust" column to VARCHAR(20) using CAST([Trust] AS VARCHAR(20)) */
ON a.Country=b.Country 
WHERE a.Region='Africa'  /* 41 rows displayed */


/* Creating table "dbo.Raw_WHR_Africa_2018" to store data pertaining to countries from the "Africa" region. */ 

CREATE TABLE dbo.Raw_WHR_Africa_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Africa_2018". */ 

TRUNCATE TABLE dbo.Raw_WHR_Africa_2018 


/* - Inserting data into "dbo.Raw_WHR_Africa_2018" from "dbo.Raw_WHR_2018". */ 

INSERT INTO dbo.Raw_WHR_Africa_2018 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Generosity, b.Trust
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b  /* Converting "Trust" column to VARCHAR(20) using CAST([Trust] AS VARCHAR(20)) */
ON a.Country=b.Country 
WHERE a.Region='Africa'  /* 41 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Africa_2018". */

SELECT *
FROM dbo.Raw_WHR_Africa_2018 


/* --- Finding Regional_Happiness_Rank using the RANK() function. --- */ 

/* --Region in UPPERCASE and Regional Rank for table "dbo.Raw_WHR_Africa_2018". */

SELECT Country, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

			ORDER BY Happiness_Score DESC 
			) AS Regional_Happiness_Rank, 

		GDP_per_Capita, Family, Health, Freedom, 
		Trust, Generosity, Dystopia 

FROM dbo.Raw_WHR_Africa_2018 		


/* Creating table "dbo.WHR_Africa_2018" to store data pertaining to countries from the "Africa" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Africa_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Africa_2018". */ 

TRUNCATE TABLE dbo.WHR_Africa_2018 


/* - Inserting data into "dbo.WHR_Africa_2018" from "dbo.Raw_WHR_Africa_2018". */ 

INSERT INTO dbo.WHR_Africa_2018 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Africa_2018  /* 41 rows inserted */ 

/* List all the data in table "dbo.WHR_Africa_2018". */

SELECT *
FROM dbo.WHR_Africa_2018 


------------------------------ XXXXXX --------------------------------


------------------------------ AMERICAS ------------------------------


/* Breaking "dbo.Raw_WHR_2018" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Americas" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b
ON a.Country=b.Country 
WHERE a.Region='Americas'  /* 23 rows displayed */ 


/* Creating table "dbo.Raw_WHR_Americas_2018" to store data pertaining to countries from the "Americas" region. */ 

CREATE TABLE dbo.Raw_WHR_Americas_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Americas_2018". */ 

TRUNCATE TABLE dbo.Raw_WHR_Americas_2018 


/* - Inserting data into "dbo.Raw_WHR_Americas_2018" from "dbo.Raw_WHR_2018". */ 

INSERT INTO dbo.Raw_WHR_Americas_2018 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b
ON a.Country=b.Country 
WHERE a.Region='Americas'  /* 23 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Americas_2018". */

SELECT *
FROM dbo.Raw_WHR_Americas_2018 


/* Creating table "dbo.WHR_Americas_2018" to store data pertaining to countries from the "Americas" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Americas_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)

/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Americas_2018". */ 

TRUNCATE TABLE dbo.WHR_Americas_2018 

/* - Inserting data into "dbo.WHR_Americas_2018" from "dbo.Raw_WHR_Americas_2018". */ 

INSERT INTO dbo.WHR_Americas_2018 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Americas_2018  /* 23 rows inserted */ 

/* List all the data in table "dbo.WHR_Americas_2018". */

SELECT *
FROM dbo.WHR_Americas_2018 


------------------------------ XXXXXX ------------------------------


------------------------------ ASIA ------------------------------


//* Breaking "dbo.Raw_WHR_2018" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Asia" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b
ON a.Country=b.Country 
WHERE a.Region='Asia'  /* 44 rows displayed */


/* Creating table "dbo.Raw_WHR_Asia_2018" to store data pertaining to countries from the "Asia" region. */ 

CREATE TABLE dbo.Raw_WHR_Asia_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Asia_2018". */ 

TRUNCATE TABLE dbo.Raw_WHR_Asia_2018 


/* - Inserting data into "dbo.Raw_WHR_Asia_2018" from "dbo.Raw_WHR_2018". */ 

INSERT INTO dbo.Raw_WHR_Asia_2018 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b
ON a.Country=b.Country 
WHERE a.Region='Asia'  /* 44 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Asia_2018". */

SELECT *
FROM dbo.Raw_WHR_Asia_2018 

	
/* Creating table "dbo.WHR_Asia_2018" to store data pertaining to countries from the "Asia" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Asia_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Asia_2018". */ 

TRUNCATE TABLE dbo.WHR_Asia_2018 


/* - Inserting data into "dbo.WHR_Asia_2018" from "dbo.Raw_WHR_Asia_2018". */ 

INSERT INTO dbo.WHR_Asia_2018 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Asia_2018  /* 44 rows inserted */ 


/* List all the data in table "dbo.WHR_Asia_2018". */

SELECT *
FROM dbo.WHR_Asia_2018 


------------------------------ XXXXXX ------------------------------


------------------------------ EUROPE ------------------------------


/* Breaking "dbo.Raw_WHR_2018" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Europe" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b
ON a.Country=b.Country 
WHERE a.Region='Europe'  /* 39 rows displayed */


/* Creating table "dbo.Raw_WHR_Europe_2018" to store data pertaining to countries from the "Europe" region. */ 

CREATE TABLE dbo.Raw_WHR_Europe_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)

/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Europe_2018". */ 

TRUNCATE TABLE dbo.Raw_WHR_Europe_2018 


/* - Inserting data into "dbo.Raw_WHR_Europe_2018" from "dbo.Raw_WHR_2018". */ 

INSERT INTO dbo.Raw_WHR_Europe_2018 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b
ON a.Country=b.Country 
WHERE a.Region='Europe'  /* 39 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Europe_2018". */

SELECT *
FROM dbo.Raw_WHR_Europe_2018 


/* Creating table "dbo.WHR_Europe_2018" to store data pertaining to countries from the "Europe" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Europe_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Europe_2018". */ 

TRUNCATE TABLE dbo.WHR_Europe_2018 


/* - Inserting data into "dbo.WHR_Europe_2018" from "dbo.Raw_WHR_Europe_2018". */ 

INSERT INTO dbo.WHR_Europe_2018 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Europe_2018  /* 39 rows inserted */ 


/* List all the data in table "dbo.WHR_Europe_2018". */

SELECT *
FROM dbo.WHR_Europe_2018 


------------------------------ XXXXXX ------------------------------


------------------------------ NAN ------------------------------


/* Breaking "dbo.Raw_WHR_2018" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Nan" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b
ON a.Country=b.Country 
WHERE a.Region='Nan'  /* 3 rows displayed */


/* Creating table "dbo.Raw_WHR_Nan_2018" to store data pertaining to countries from the "Nan" region. */ 

CREATE TABLE dbo.Raw_WHR_Nan_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Nan_2018". */ 

TRUNCATE TABLE dbo.Raw_WHR_Nan_2018 


/* - Inserting data into "dbo.Raw_WHR_Nan_2018" from "dbo.Raw_WHR_2018". */ 

INSERT INTO dbo.Raw_WHR_Nan_2018 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b
ON a.Country=b.Country 
WHERE a.Region='Nan'  /* 3 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Nan_2018". */

SELECT *
FROM dbo.Raw_WHR_Nan_2018 


/* Creating table "dbo.WHR_Nan_2018" to store data pertaining to countries from the "Nan" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Nan_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5) 
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Nan_2018". */ 

TRUNCATE TABLE dbo.WHR_Nan_2018 


/* - Inserting data into "dbo.WHR_Nan_2018" from "dbo.Raw_WHR_Nan_2018". */ 

INSERT INTO dbo.WHR_Nan_2018 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Nan_2018  /* 3 rows inserted */ 


/* List all the data in table "dbo.WHR_Nan_2018". */

SELECT *
FROM dbo.WHR_Nan_2018 


------------------------------ XXXXXX ------------------------------


------------------------------ OCEANIA ------------------------------


/* Breaking "dbo.Raw_WHR_2018" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Oceania" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b
ON a.Country=b.Country 
WHERE a.Region='Oceania'  /* 2 rows displayed */


/* Creating table "dbo.Raw_WHR_Oceania_2018" to store data pertaining to countries from the "Oceania" region. */ 

CREATE TABLE dbo.Raw_WHR_Oceania_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Oceania_2018". */ 

TRUNCATE TABLE dbo.Raw_WHR_Oceania_2018 


/* - Inserting data into "dbo.Raw_WHR_Oceania_2018" from "dbo.Raw_WHR_2018". */ 

INSERT INTO dbo.Raw_WHR_Oceania_2018 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2018 b
ON a.Country=b.Country 
WHERE a.Region='Oceania'  /* 2 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Oceania_2018". */

SELECT *
FROM dbo.Raw_WHR_Oceania_2018 


/* Creating table "dbo.WHR_Oceania_2018" to store data pertaining to countries from the "Oceania" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Oceania_2018(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Oceania_2018". */ 

TRUNCATE TABLE dbo.WHR_Oceania_2018 


/* - Inserting data into "dbo.WHR_Oceania_2018" from "dbo.Raw_WHR_Oceania_2018". */ 

INSERT INTO dbo.WHR_Oceania_2018 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Oceania_2018  /* 2 rows inserted */ 


/* List all the data in table "dbo.WHR_Oceania_2018". */

SELECT *
FROM dbo.WHR_Oceania_2018 


------------------------------ XXXXXX ------------------------------


------------------------------------------------------------ x- 2019 -x ------------------------------------------------------------ 

------------------------------ AFRICA ------------------------------


/* Breaking "dbo.Raw_WHR_2019" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Africa" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Generosity, b.Trust
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Africa'  /* 41 rows displayed */

/* Creating table "dbo.Raw_WHR_Africa_2019" to store data pertaining to countries from the "Africa" region. */ 

CREATE TABLE dbo.Raw_WHR_Africa_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Africa_2019". */ 

TRUNCATE TABLE dbo.Raw_WHR_Africa_2019 


/* - Inserting data into "dbo.Raw_WHR_Africa_2019" from "dbo.Raw_WHR_2019". */ 

INSERT INTO dbo.Raw_WHR_Africa_2019 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Generosity, b.Trust
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Africa'  /* 41 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Africa_2019". */

SELECT *
FROM dbo.Raw_WHR_Africa_2019 


/* --- Finding Regional_Happiness_Rank using the RANK() function. --- */ 

/* --Region in UPPERCASE and Regional Rank for table "dbo.Raw_WHR_Africa_2019". */

SELECT Country, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

			ORDER BY Happiness_Score DESC 
			) AS Regional_Happiness_Rank, 

		GDP_per_Capita, Family, Health, Freedom, 
		Trust, Generosity, Dystopia 

FROM dbo.Raw_WHR_Africa_2019 		


/* Creating table "dbo.WHR_Africa_2019" to store data pertaining to countries from the "Africa" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Africa_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Africa_2019". */ 

TRUNCATE TABLE dbo.WHR_Africa_2019 


/* - Inserting data into "dbo.WHR_Africa_2019" from "dbo.Raw_WHR_Africa_2019". */ 

INSERT INTO dbo.WHR_Africa_2019 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Africa_2019  /* 41 rows inserted */ 

/* List all the data in table "dbo.WHR_Africa_2019". */

SELECT *
FROM dbo.WHR_Africa_2019 


------------------------------ XXXXXX --------------------------------


------------------------------ AMERICAS ------------------------------


/* Breaking "dbo.Raw_WHR_2019" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Americas" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Americas'  /* 26 rows displayed */ 


/* Creating table "dbo.Raw_WHR_Americas_2019" to store data pertaining to countries from the "Americas" region. */ 

CREATE TABLE dbo.Raw_WHR_Americas_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Americas_2019". */ 

TRUNCATE TABLE dbo.Raw_WHR_Americas_2019 


/* - Inserting data into "dbo.Raw_WHR_Americas_2019" from "dbo.Raw_WHR_2019". */ 

INSERT INTO dbo.Raw_WHR_Americas_2019 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Americas'  /* 22 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Americas_2019". */

SELECT *
FROM dbo.Raw_WHR_Americas_2019 


/* Creating table "dbo.WHR_Americas_2019" to store data pertaining to countries from the "Americas" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Americas_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Americas_2019". */ 

TRUNCATE TABLE dbo.WHR_Americas_2019 


/* - Inserting data into "dbo.WHR_Americas_2019" from "dbo.Raw_WHR_Americas_2019". */ 

INSERT INTO dbo.WHR_Americas_2019 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Americas_2019  /* 22 rows inserted */ 

/* List all the data in table "dbo.WHR_Americas_2019". */

SELECT *
FROM dbo.WHR_Americas_2019 


------------------------------ XXXXXX ------------------------------


------------------------------ ASIA ------------------------------


//* Breaking "dbo.Raw_WHR_2019" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Asia" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Asia'  /* 44 rows displayed */


/* Creating table "dbo.Raw_WHR_Asia_2019" to store data pertaining to countries from the "Asia" region. */ 

CREATE TABLE dbo.WHR_Americas_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Asia_2019". */ 

TRUNCATE TABLE dbo.Raw_WHR_Asia_2019 


/* - Inserting data into "dbo.Raw_WHR_Asia_2019" from "dbo.Raw_WHR_2019". */ 

INSERT INTO dbo.Raw_WHR_Asia_2019 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Asia'  /* 44 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Asia_2019". */

SELECT *
FROM dbo.Raw_WHR_Asia_2019 

	
/* Creating table "dbo.WHR_Asia_2019" to store data pertaining to countries from the "Asia" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Asia_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Asia_2019". */ 

TRUNCATE TABLE dbo.WHR_Asia_2019 


/* - Inserting data into "dbo.WHR_Asia_2019" from "dbo.Raw_WHR_Asia_2019". */ 

INSERT INTO dbo.WHR_Asia_2019 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Asia_2019  /* 44 rows inserted */ 


/* List all the data in table "dbo.WHR_Asia_2019". */

SELECT *
FROM dbo.WHR_Asia_2019 


------------------------------ XXXXXX ------------------------------


------------------------------ EUROPE ------------------------------


/* Breaking "dbo.Raw_WHR_2019" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Europe" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Europe'  /* 39 rows displayed */


/* Creating table "dbo.Raw_WHR_Europe_2019" to store data pertaining to countries from the "Europe" region. */ 

CREATE TABLE dbo.Raw_WHR_Europe_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Europe_2019". */ 

TRUNCATE TABLE dbo.Raw_WHR_Europe_2019 


/* - Inserting data into "dbo.Raw_WHR_Europe_2019" from "dbo.Raw_WHR_2019". */ 

INSERT INTO dbo.Raw_WHR_Europe_2019 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Europe'  /* 38 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Europe_2019". */

SELECT *
FROM dbo.Raw_WHR_Europe_2019 


/* Creating table "dbo.WHR_Europe_2019" to store data pertaining to countries from the "Europe" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Europe_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Europe_2019". */ 

TRUNCATE TABLE dbo.WHR_Europe_2019 


/* - Inserting data into "dbo.WHR_Europe_2019" from "dbo.Raw_WHR_Europe_2019". */ 

INSERT INTO dbo.WHR_Europe_2019 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Europe_2019  /* 38 rows inserted */ 


/* List all the data in table "dbo.WHR_Europe_2019". */

SELECT *
FROM dbo.WHR_Europe_2019 


------------------------------ XXXXXX ------------------------------


------------------------------ NAN ------------------------------


/* Breaking "dbo.Raw_WHR_2019" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Nan" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Nan'  /* 3 rows displayed */


/* Creating table "dbo.Raw_WHR_Nan_2019" to store data pertaining to countries from the "Nan" region. */ 

CREATE TABLE dbo.Raw_WHR_Nan_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Nan_2019". */ 

TRUNCATE TABLE dbo.Raw_WHR_Nan_2019 


/* - Inserting data into "dbo.Raw_WHR_Nan_2019" from "dbo.Raw_WHR_2019". */ 

INSERT INTO dbo.Raw_WHR_Nan_2019 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Nan'  /* 4 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Nan_2019". */

SELECT *
FROM dbo.Raw_WHR_Nan_2019 


/* Creating table "dbo.WHR_Nan_2019" to store data pertaining to countries from the "Nan" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Nan_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Nan_2019". */ 

TRUNCATE TABLE dbo.WHR_Nan_2019 


/* - Inserting data into "dbo.WHR_Nan_2019" from "dbo.Raw_WHR_Nan_2019". */ 

INSERT INTO dbo.WHR_Nan_2019 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Nan_2019  /* 4 rows inserted */ 


/* List all the data in table "dbo.WHR_Nan_2019". */

SELECT *
FROM dbo.WHR_Nan_2019 


------------------------------ XXXXXX ------------------------------


------------------------------ OCEANIA ------------------------------


/* Breaking "dbo.Raw_WHR_2019" into separate regions; namely "Africa", "Americas", "Asia", "Europe", "Nan" and "Oceania"; using "Oceania" as example. */ 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Oceania'  /* 2 rows displayed */


/* Creating table "dbo.Raw_WHR_Oceania_2019" to store data pertaining to countries from the "Oceania" region. */ 

CREATE TABLE dbo.Raw_WHR_Oceania_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan',
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Raw_WHR_Oceania_2019". */ 

TRUNCATE TABLE dbo.Raw_WHR_Oceania_2019 


/* - Inserting data into "dbo.Raw_WHR_Oceania_2019" from "dbo.Raw_WHR_2019". */ 

INSERT INTO dbo.Raw_WHR_Oceania_2019 

SELECT a.Country, a.Image_URL AS Country_URL, a.Region_Code, a.Region, b.Happiness_Score, b.GDP_per_Capita, b.Family, b.Health, b.Freedom, b.Trust, b.Generosity, b.Dystopia
FROM dbo.Country a 
INNER JOIN dbo.Raw_WHR_2019 b
ON a.Country=b.Country 
WHERE a.Region='Oceania'  /* 2 rows inserted */ 


/* List all the data in table "dbo.Raw_WHR_Oceania_2019". */

SELECT *
FROM dbo.Raw_WHR_Oceania_2019 


/* Creating table "dbo.WHR_Oceania_2019" to store data pertaining to countries from the "Oceania" region in UPPERCASE with "Regional_Happiness_Rank". */ 

CREATE TABLE dbo.WHR_Oceania_2019(
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										)


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Oceania_2019". */ 

TRUNCATE TABLE dbo.WHR_Oceania_2019 


/* - Inserting data into "dbo.WHR_Oceania_2019" from "dbo.Raw_WHR_Oceania_2019". */ 

INSERT INTO dbo.WHR_Oceania_2019 

SELECT Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, 

		RANK() OVER(

				ORDER BY Happiness_Score DESC 
				) AS Regional_Happiness_Rank,

		GDP_per_Capita, Family, Health, Freedom, Trust, Generosity, Dystopia

FROM dbo.Raw_WHR_Oceania_2019  /* 2 rows inserted */ 


/* List all the data in table "dbo.WHR_Oceania_2019". */

SELECT *
FROM dbo.WHR_Oceania_2019 


------------------------------ XXXXXX ------------------------------


------------------------------------------------------------ x- 2016 -x ------------------------------------------------------------ 

/* - Combining all Regional data together from dataframes "dbo.WHR_Africa_2016", "dbo.WHR_Americas_2016", "dbo.WHR_Asia_2016", "dbo.WHR_Europe_2016", "dbo.WHR_Nan_2016" and "dbo.WHR_Oceania_2016". */

-------------------- SQL Statement: 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Africa_2016 

UNION 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Americas_2016 

UNION 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Asia_2016  

UNION 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Europe_2016 

UNION 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Nan_2016  

UNION 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Oceania_2016 


/* Creating table "dbo.WHR_Combined_2016" to store data pertaining to countries from the tables "dbo.WHR_Africa_2016", "dbo.WHR_Americas_2016", "dbo.WHR_Asia_2016", "dbo.WHR_Europe_2016", "dbo.WHR_Nan_2016" and "dbo.WHR_Oceania_2016". */ 

CREATE TABLE dbo.WHR_Combined_2016(
										Year INT DEFAULT NULL, 
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										) 

/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Combined_2016". */ 

TRUNCATE TABLE dbo.WHR_Combined_2016 

/* - Inserting data into "dbo.WHR_Combined_2016". */ 

INSERT INTO dbo.WHR_Combined_2016 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Africa_2016 

UNION 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Americas_2016 

UNION 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Asia_2016  

UNION 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Europe_2016 

UNION 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Nan_2016  

UNION 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Oceania_2016 


/* List all the data in table "dbo.WHR_Combined_2016". */

SELECT *
FROM dbo.WHR_Combined_2016  /* 153 rows displayed */ 


------------------------------ XXXXXX -------------------------------- 


------------------------------------------------------------ x- 2017 -x ------------------------------------------------------------ 


/* Creating table "dbo.WHR_Combined_2017" to store data pertaining to countries from the tables "dbo.WHR_Africa_2017", "dbo.WHR_Americas_2017", "dbo.WHR_Asia_2017", "dbo.WHR_Europe_2017", "dbo.WHR_Nan_2017" and "dbo.WHR_Oceania_2017". */ 

CREATE TABLE dbo.WHR_Combined_2017(
										Year INT DEFAULT NULL, 
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										) 

/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Combined_2017". */ 

TRUNCATE TABLE dbo.WHR_Combined_2017 

/* - Inserting data into "dbo.WHR_Combined_2017". */ 

INSERT INTO dbo.WHR_Combined_2017 

SELECT 2017 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Africa_2017 

UNION 

SELECT 2017 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Americas_2017 

UNION 

SELECT 2017 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Asia_2017  

UNION 

SELECT 2017 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Europe_2017 

UNION 

SELECT 2017 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Nan_2017  

UNION 

SELECT 2017 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Oceania_2017 


/* List all the data in table "dbo.WHR_Combined_2017". */

SELECT *
FROM dbo.WHR_Combined_2017  /* 150 rows displayed */


------------------------------ XXXXXX --------------------------------


------------------------------------------------------------ x- 2018 -x ------------------------------------------------------------ 


/* Creating table "dbo.WHR_Combined_2018" to store data pertaining to countries from the tables "dbo.WHR_Africa_2018", "dbo.WHR_Americas_2018", "dbo.WHR_Asia_2018", "dbo.WHR_Europe_2018", "dbo.WHR_Nan_2018" and "dbo.WHR_Oceania_2018". */ 

CREATE TABLE dbo.WHR_Combined_2018(
										Year INT DEFAULT NULL, 
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										) 

/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Combined_2018". */ 

TRUNCATE TABLE dbo.WHR_Combined_2018 

/* - Inserting data into "dbo.WHR_Combined_2018". */ 

INSERT INTO dbo.WHR_Combined_2018 

SELECT 2018 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Africa_2018 

UNION 

SELECT 2018 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Americas_2018 

UNION 

SELECT 2018 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Asia_2018  

UNION 

SELECT 2018 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Europe_2018 

UNION 

SELECT 2018 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Nan_2018  

UNION 

SELECT 2018 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Oceania_2018 


/* List all the data in table "dbo.WHR_Combined_2018". */

SELECT *
FROM dbo.WHR_Combined_2018  /* 152 rows displayed. */ 


------------------------------ XXXXXX --------------------------------


------------------------------------------------------------ x- 2019 -x ------------------------------------------------------------ 


/* Creating table "dbo.WHR_Combined_2019" to store data pertaining to countries from the tables "dbo.WHR_Africa_2019", "dbo.WHR_Americas_2019", "dbo.WHR_Asia_2019", "dbo.WHR_Europe_2019", "dbo.WHR_Nan_2019" and "dbo.WHR_Oceania_2019". */ 

CREATE TABLE dbo.WHR_Combined_2019(
										Year INT DEFAULT NULL, 
										Country VARCHAR(100) NULL, 
										Country_URL VARCHAR(MAX) NULL, 
										Region_Code VARCHAR(MAX) NULL, 
										Region VARCHAR(100) DEFAULT 'Nan', 
										Happiness_Score DECIMAL(6,3), 
										Regional_Happiness_Rank INT DEFAULT NULL, 
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5)
										) 

/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Combined_2019". */ 

TRUNCATE TABLE dbo.WHR_Combined_2019 

/* - Inserting data into "dbo.WHR_Combined_2019". */ 

INSERT INTO dbo.WHR_Combined_2019 

SELECT 2019 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Africa_2019 

UNION 

SELECT 2019 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Americas_2019 

UNION 

SELECT 2019 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Asia_2019  

UNION 

SELECT 2019 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Europe_2019 

UNION 

SELECT 2019 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Nan_2019  

UNION 

SELECT 2019 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Oceania_2019 


/* List all the data in table "dbo.WHR_Combined_2019". */

SELECT *
FROM dbo.WHR_Combined_2019  /* 151 rows displayed. */ 


------------------------------ XXXXXX -------------------------------- 


-- /* ----- Combining tables "dbo.WHR_Combined_2016", "dbo.WHR_Combined_2017", "dbo.WHR_Combined_2018" and "dbo.WHR_Combined_2019" together in table "dbo.WHR_CombinedList". ----- */ --


/* - Table dbo.WHR_CombinedList contains data from the combined tables "dbo.WHR_Combined_2016", "dbo.WHR_Combined_2017", "dbo.WHR_Combined_2018" and "dbo.WHR_Combined_2019" as per requirements of Task 3. */ 

CREATE TABLE dbo.WHR_CombinedList( 
									Year INT DEFAULT NULL, 
									Country VARCHAR(100) NULL, 
									Country_URL VARCHAR(MAX) NULL, 
									Region_Code VARCHAR(MAX) NULL, 
									Region VARCHAR(100) DEFAULT 'Nan', 
									Happiness_Score DECIMAL(6,3), 
									Regional_Happiness_Rank INT DEFAULT NULL, 
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Generosity DECIMAL(7,5),
									Trust DECIMAL(7,5)
									) 


/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_CombinedList". */ 

TRUNCATE TABLE dbo.WHR_CombinedList 


/* - Inserting data into "dbo.WHR_Combined_2019". */ 

INSERT INTO dbo.WHR_CombinedList 

SELECT 2016 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Combined_2016  

UNION 

SELECT 2017 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Combined_2017 

UNION 

SELECT 2018 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family AS Social_Support, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Combined_2018 

UNION 

SELECT 2019 AS Year, Country, Country_URL, Region_Code, UPPER(Region) AS Region, Happiness_Score, Regional_Happiness_Rank AS Rank_per_Region, 
				GDP_per_Capita, Family AS Social_Support, Health AS Healthy_Life_Expectancy, Freedom AS Freedom_to_make_Life_Choices, Generosity, Trust AS Perceptions_of_Corruption 
		/* Converting "Trust" column to VARCHAR(20) using CAST() - CAST([Trust] AS VARCHAR(20)) */

FROM dbo.WHR_Combined_2019 

/* List all the data in table "dbo.WHR_CombinedList". */

SELECT *
FROM dbo.WHR_CombinedList  /* 606 rows displayed. */


------------------------------ XXXXXX -------------------------------- 


-- /* ----- Combining tables "dbo.newRaw_WHR_2016", "dbo.newRaw_WHR_2017", "dbo.newRaw_WHR_2018" and "dbo.newRaw_WHR_2019" together in table "dbo.WHR_Combined2". ----- */ --


/* - Creating table "dbo.WHR_Combined2" which will hold combined data from table "dbo.newRaw_WHR_2016", "dbo.newRaw_WHR_2017", "dbo.newRaw_WHR_2018" and "dbo.newRaw_WHR_2019". */

CREATE TABLE dbo.WHR_Combined2(  
									Year INT DEFAULT NULL, 
									Country VARCHAR(100) NULL, 
									Happiness_Score DECIMAL(6,3),
									Overall_Happiness_Rank INT DEFAULT NULL, 
									Happiness_Status VARCHAR(20) NULL,
									GDP_per_Capita DECIMAL(7,5),
									Family DECIMAL(7,5),
									Health DECIMAL(7,5),
									Freedom DECIMAL(7,5),
									Generosity DECIMAL(7,5), 
									Trust DECIMAL(7,5) 
									)
									
									
/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.WHR_Combined2". */ 

TRUNCATE TABLE dbo.WHR_Combined2 


/* - Inserting data in dbo.WHR_Combined2. */ 

INSERT INTO dbo.WHR_Combined2 

SELECT Year, Country, Happiness_Score, Overall_Happiness_Rank, Happiness_Status, GDP_per_Capita, Family, Health, 
		Freedom, Generosity, Trust 

FROM dbo.newRaw_WHR_2016 

UNION 

SELECT Year, Country, Happiness_Score, Overall_Happiness_Rank, Happiness_Status, GDP_per_Capita, Family, Health, 
		Freedom, Generosity, Trust 

FROM dbo.newRaw_WHR_2017 

UNION 

SELECT Year, Country, Happiness_Score, Overall_Happiness_Rank, Happiness_Status, GDP_per_Capita, Family, Health, 
		Freedom, Generosity, Trust 

FROM dbo.newRaw_WHR_2018 

UNION 

SELECT Year, Country, Happiness_Score, Overall_Happiness_Rank, Happiness_Status, GDP_per_Capita, Family, Health, 
		Freedom, Generosity, Trust 

FROM dbo.newRaw_WHR_2019 


/* List all the data in table "dbo.WHR_Combined2". */

SELECT *
FROM dbo.WHR_Combined2  /* 624 rows displayed. */


----- Task 3 - SQL Statement: ----- 

SELECT DISTINCT a.Year, a.Country, a.Country_URL, a.Region_Code, a.Region, (a.Regional_Happiness_Rank) AS Rank_per_Region, (b.Overall_Happiness_Rank) AS Overall_Rank, 
b.Happiness_Score, b.Happiness_Status, a.GDP_per_Capita, a.Family, (a.Family) AS Social_Support, (a.Health) AS Healthy_Life_Expectancy, (a.Freedom) AS Freedom_to_make_life_choices, 
a.Generosity, (a.Trust) AS Perceptions_of_Corruption 

FROM dbo.WHR_CombinedList a 
INNER JOIN dbo.WHR_Combined2 b 
ON a.Country=b.Country 

----- x ----- 


/* - Creating table "dbo.Task_3" to return values as per form. */

CREATE TABLE dbo.Task_3(  
							Year INT DEFAULT NULL, 
							Country VARCHAR(100) NULL, 
							Country_URL VARCHAR(MAX) NULL, 
							Region_Code VARCHAR(MAX) NULL, 
							Region VARCHAR(100) DEFAULT 'Nan', 
							Regional_Happiness_Rank INT DEFAULT NULL, 
							Overall_Happiness_Rank INT DEFAULT NULL,
							Happiness_Score DECIMAL(6,3), 
							Happiness_Status VARCHAR(20) NULL,
							GDP_per_Capita DECIMAL(7,5),
							Family DECIMAL(7,5), 
							Social_Support DECIMAL(7,5) DEFAULT NULL,
							Health DECIMAL(7,5),
							Freedom DECIMAL(7,5),
							Generosity DECIMAL(7,5),
							Trust DECIMAL(7,5) 
							) 
										
										
/* Using "TRUNCATE" to remove all rows (data) from a table"dbo.Task_3". */ 

TRUNCATE TABLE dbo.Task_3 


/* - Inserting data in dbo.Task_3. */ 

INSERT INTO dbo.Task_3 

SELECT DISTINCT a.Year, a.Country, a.Country_URL, a.Region_Code, a.Region, (a.Regional_Happiness_Rank) AS Rank_per_Region, (b.Overall_Happiness_Rank) AS Overall_Rank, 
b.Happiness_Score, b.Happiness_Status, a.GDP_per_Capita, a.Family, (a.Family) AS Social_Support, (a.Health) AS Healthy_Life_Expectancy, (a.Freedom) AS Freedom_to_make_life_choices, 
a.Generosity, (a.Trust) AS Perceptions_of_Corruption 

FROM dbo.WHR_CombinedList a 
INNER JOIN dbo.WHR_Combined2 b 
ON a.Country=b.Country 


/* List all the data in table "dbo.WHR_Combined2". */

SELECT *
FROM dbo.Task_3  /* 2 364 rows displayed. */ 


------------------------------ XXXXXX --------------------------------


/* ---------------------------------------- Task 4: ---------------------------------------------------------- */

An application in BCM wants to consume an extract in JSON format containing the details as per table below. 

Complement the existing data pipeline in step 2 to return the required information. ----------------------------------- */ 


/* - Creating table "dbo.Task_4" to return Highest Rank, Lowest Rank, Highest Happiness Score, Lowest Happiness Score per Country for all the years. */ 

CREATE TABLE dbo.Task_4(
								Country VARCHAR(100) NULL, 
								Highest_Overall_Rank INT DEFAULT NULL, 
								Lowest_Overall_Rank INT DEFAULT NULL,
								Highest_Happiness_Score DECIMAL(6,3),
								Lowest_Happiness_Score DECIMAL(6,3)
								)


/* Using "TRUNCATE" to remove all rows (data) from a table "dbo.Task_4". */ 

TRUNCATE TABLE dbo.Task_4


/* Inserting data into "dbo.Task_4". */ 

INSERT INTO dbo.Task_4 

	SELECT "Country", MIN(Overall_Happiness_Rank) AS Highest_Overall_Rank, MAX(Overall_Happiness_Rank) AS Lowest_Overall_Rank, 

			MAX(Happiness_Score) AS Highest_Happiness_Score, MIN(Happiness_Score) AS Lowest_Happiness_Score 
			
	FROM dbo.WHR_Combined2 
	
	GROUP BY "Country"


/* List the data which has been inserted in table "dbo.Country_Data". */ 

SELECT * 
FROM dbo.Task_4 /* There are 167 records in table "dbo.Task_4" */


------------------------------ XXXXXX --------------------------------


/* ---------------------------------------- Task 5: ---------------------------------------------------------- */

Create a dataset containing the details as per table below (Complement the existing data pipeline in step 2 
to return the required information) and use this dataset to create a small Data Visualization dashboard 
by plotting the data in a world map showing the evolution by year. 

When hovering on a particular location the map the actual score and country image should be displayed. ----------------------------------- */ 


--- SQL Statement to display data as per requirement: ---

-FOR 2016-

	SELECT 2016 AS Year, Country, Happiness_Score, Happiness_Status 
			
	FROM dbo.newRaw_WHR_2016 
	
-FOR 2017-

	SELECT 2017 AS Year, Country, Happiness_Score, Happiness_Status 
			
	FROM dbo.newRaw_WHR_2017 
	
-FOR 2018-

	SELECT 2018 AS Year, Country, Happiness_Score, Happiness_Status 
			
	FROM dbo.newRaw_WHR_2018 
	
-FOR 2019-

	SELECT 2019 AS Year, Country, Happiness_Score, Happiness_Status 
			
	FROM dbo.newRaw_WHR_2019 
		
--- x --- 


/* - Creating table "dbo.Visual_2016", "dbo.Visual_2017", "dbo.Visual_2018" and "dbo.Visual_2019" to return Year, Country, Happiness_Score, Happiness_Status and complement it to create a small Data Visualization dashboard by plotting the data in a World Map showing the evolution by year. */ 

-FOR 2016-

CREATE TABLE dbo.Visual_2016(
								Year INT DEFAULT NULL,
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								Happiness_Status VARCHAR(20) NULL
								)


-FOR 2017-

CREATE TABLE dbo.Visual_2017(
								Year INT DEFAULT NULL,
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								Happiness_Status VARCHAR(20) NULL
								)


-FOR 2018-

CREATE TABLE dbo.Visual_2018(
								Year INT DEFAULT NULL,
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								Happiness_Status VARCHAR(20) NULL
								)


-FOR 2019-

CREATE TABLE dbo.Visual_2019(
								Year INT DEFAULT NULL,
								Country VARCHAR(100) NULL, 
								Happiness_Score DECIMAL(6,3),
								Happiness_Status VARCHAR(20) NULL
								)


/* - Using "TRUNCATE" to remove all rows (data) from the tables "dbo.Visual_2016", "dbo.Visual_2017", "dbo.Visual_2018" and "dbo.Visual_2019". */ 

TRUNCATE TABLE dbo.Visual_2016 
TRUNCATE TABLE dbo.Visual_2017 
TRUNCATE TABLE dbo.Visual_2018 
TRUNCATE TABLE dbo.Visual_2019 


/* Inserting data into tables "dbo.Visual_2016", "dbo.Visual_2017", "dbo.Visual_2018" and "dbo.Visual_2019". */ 

--FOR 2016--

INSERT INTO dbo.Visual_2016  

	SELECT 2016 AS Year, Country, Happiness_Score, Happiness_Status 
			
	FROM dbo.newRaw_WHR_2016  /* - 157 rows inserted in table "dbo.Visual_2016". */

--FOR 2017--

INSERT INTO dbo.Visual_2017  

	SELECT 2017 AS Year, Country, Happiness_Score, Happiness_Status 
			
	FROM dbo.newRaw_WHR_2017  /* - 155 rows inserted in table "dbo.Visual_2017". */

--FOR 2018--

INSERT INTO dbo.Visual_2018  

	SELECT 2018 AS Year, Country, Happiness_Score, Happiness_Status 
			
	FROM dbo.newRaw_WHR_2018  /* - 156 rows inserted in table "dbo.Visual_2018". */

--FOR 2019--

INSERT INTO dbo.Visual_2019  

	SELECT 2019 AS Year, Country, Happiness_Score, Happiness_Status 
			
	FROM dbo.newRaw_WHR_2019  /* - 156 rows inserted in table "dbo.Visual_2019". */


/* - List the data which has been inserted in tables "dbo.Visual_2016", "dbo.Visual_2017", "dbo.Visual_2018" and "dbo.Visual_2019". */ 

-- FOR 2016 --

SELECT * 
FROM dbo.Visual_2016 /* There are 157 records in table "dbo.Visual_2016" */

-- FOR 2017 --

SELECT * 
FROM dbo.Visual_2017 /* There are 155 records in table "dbo.Visual_2017" */

-- FOR 2018 --

SELECT * 
FROM dbo.Visual_2018 /* There are 156 records in table "dbo.Visual_2018" */

-- FOR 2019 --

SELECT * 
FROM dbo.Visual_2019 /* There are 156 records in table "dbo.Visual_2019" */


------------------------------ XXXXXX --------------------------------


/* ---------------------------------------- Task 6: ---------------------------------------------------------- 

The World Bank provides several APIs to have access global data. Complement the data pipeline in Step 3 
to add three new columns ‘Capital City’, ‘Longitude’ and ‘Latitude’ using the API:- http://api.worldbank.org/v2/country. 
More information on how to use the API can be found on the following 
URL:- https://datahelpdesk.worldbank.org/knowledgebase/articles/898590-country-apiqueries ----------------------------------- */ 


--- SQL Statement to display data as per requirement: ---

SELECT a.Year, a.Country, (b.Capital_City) AS Capital_City, (b.Lat) AS Latitude, (b.Lng) AS Longitude, a.Happiness_Score, a.Overall_Happiness_Rank, 
a.Happiness_Status, a.GDP_per_Capita, a.Family, a.Health, a.Freedom, a.Generosity, a.Trust 

FROM a.dbo.WHR_Combined2 a 
INNER JOIN dbo.Country_Data b 
ON a.Country=b.Country
		
--- x --- 


/* Creating table "dbo.CombinedCountry" to return Capital City as well as Latitute and Longitude with data in "dbo.WHR_Combined2" table. */ 

CREATE TABLE dbo.CombinedCountry(
								Year INT DEFAULT NULL, 
								Country VARCHAR(100) NULL, 
								Capital_City VARCHAR(MAX) NULL,  
								Lng DECIMAL(12,9) DEFAULT NULL,
								Lat DECIMAL(12,9) DEFAULT NULL,
								Happiness_Score DECIMAL(6,3), 
								Overall_Happiness_Rank INT DEFAULT NULL, 
								Happiness_Status VARCHAR(20) NULL, 
								GDP_per_Capita DECIMAL(7,5), 
								Family DECIMAL(7,5), 
								Health DECIMAL(7,5), 
								Freedom DECIMAL(7,5), 
								Generosity DECIMAL(7,5), 
								Trust DECIMAL(7,5), 
								)
								

/* Using "TRUNCATE" to remove all rows (data) from table "dbo.CombinedCountry". */ 

TRUNCATE TABLE dbo.CombinedCountry


/* Inserting data into "dbo.CombinedCountry" from "dbo.Country_Data" and "dbo.WHR_Combined2" tables. */ 

INSERT INTO dbo.CombinedCountry 

SELECT a.Year, a.Country, (b.Capital_City) AS Capital_City, (b.Lat) AS Latitude, (b.Lng) AS Longitude, a.Happiness_Score, a.Overall_Happiness_Rank, 
a.Happiness_Status, a.GDP_per_Capita, a.Family, a.Health, a.Freedom, a.Generosity, a.Trust 

FROM a.dbo.WHR_Combined2 a 
INNER JOIN dbo.Country_Data b 
ON a.Country=b.Country


/* List the data which has been inserted in table "dbo.Country_Data". */ 

SELECT * 
FROM dbo.CombinedCountry /* There are XXX records in table "dbo.Country_Data" */


------------------------------ XXXXXX --------------------------------





/*

*/