/*
/*

/* Creating Database "Project_BCM" */ 
CREATE DATABASE Project_BCM

/* Using "Project_BCM" Database */ 
USE Project_BCM

/* Creating tables to upload report files */ 

/* Creating table for storing Country data */ 

CREATE TABLE dbo.Country(Country VARCHAR(100) NULL, 
										Image_File VARCHAR(MAX) NULL, 
										Image_URL VARCHAR(MAX) NULL,
										Alpha_2 VARCHAR(100) NULL,
										Alpha_3 VARCHAR(100) NULL,
										Country_Code VARCHAR(MAX) NULL,
										iso_3166_2 VARCHAR(100) NULL,
										Region VARCHAR(100) NULL,
										Sub_Region VARCHAR(100) NULL,
										Intermediate_Region VARCHAR(100) NULL,
										Region_Code VARCHAR(MAX) NULL, 
										Sub_Region_Code VARCHAR(MAX) NULL,  
										Intermediate_Region_Code VARCHAR(MAX) NULL)
							  
/* Note: "dbo.Country" will consume data from the file "Country_List.csv". */ 


/* Creating table for storing data from report files. */ 

(a)

CREATE TABLE dbo.WHR_2016(Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3),
										Lower_Confidence_Interval DECIMAL(7,5),
										Upper_Confidence_Interval DECIMAL(7,5),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Dystopia DECIMAL(7,5))
										

(b)

CREATE TABLE dbo.WHR_2017(Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3),
										Whisker_High DECIMAL(7,5),
										Whisker_Low DECIMAL(7,5),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Dystopia DECIMAL(7,5))
										

(c)

CREATE TABLE dbo.WHR_2018(Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5))
										

(d)

CREATE TABLE dbo.WHR_2019(Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5))
										

/* Note: 	(a)"dbo.WHR_2016" will consume data from .csv file "HR_2016". 
			(b)"dbo.WHR_2017" will consume data from .csv file "happiNess_report_2017". 
			(c)"dbo.WHR_2018" will consume data from .csv file "2018". 
			(d)"dbo.WHR_2019" will consume data from .csv file "report_2019". */
			

/* Using "BULK INSERT" to populate the tables. */ 


TRUNCATE TABLE dbo.Country
TRUNCATE TABLE dbo.WHR_2016
TRUNCATE TABLE dbo.WHR_2017
TRUNCATE TABLE dbo.WHR_2018
TRUNCATE TABLE dbo.WHR_2019


*/


/* Inserting data into "dbo.Country" from "Country_List.csv". */ 


BULK INSERT dbo.Country
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Country_List.csv'
WITH
(
	FIRSTROW=2,
	FORMAT='CSV'
)


/* List the data which has been inserted in table "dbo.Country". */ 

SELECT * 
FROM dbo.Country


/* Inserting data into the report tables. */ 

(a) 

/* Inserting data into "dbo.WHR_2016" from "HR_2016.csv". */


BULK INSERT dbo.WHR_2016
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\HR_2016.csv'
WITH
(

	FIRSTROW=2,
	FORMAT='CSV'
	
)


/* List the data which has been inserted in table "dbo.WHR_2016". */ 

SELECT * 
FROM dbo.WHR_2016


(b)

/* Inserting data into "dbo.WHR_2017" from "happiNess_report_2017.csv". */

BULK INSERT dbo.WHR_2017
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\happiNess_report_2017.csv'
WITH
(

	FIRSTROW=2,
	FORMAT='CSV'
	
)


/* List the data which has been inserted in table "dbo.WHR_2017". */ 

SELECT * 
FROM dbo.WHR_2017


(c)

/* Inserting data into "dbo.WHR_2018" from "2018.csv". */

BULK INSERT dbo.WHR_2018
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\2018.csv'
WITH
(

	FIRSTROW=2,
	FORMAT='CSV'
	
)

/* List the data which has been inserted in table "dbo.WHR_2018". */ 

SELECT * 
FROM dbo.WHR_2018


(d)

/* Inserting data into "dbo.WHR_2019" from "report_2019.csv". */

BULK INSERT dbo.WHR_2019
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\report_2019.csv'
WITH
(

	FIRSTROW=2,
	FORMAT='CSV'
	
)

/* List the data which has been inserted in table "dbo.WHR_2019". */ 

SELECT * 
FROM dbo.WHR_2019



/* Creating table "dbo.CountriesVerification" to verify consistency of data in the four datasets. */ 

CREATE TABLE dbo.CountriesVerification(Country VARCHAR(100) NULL)


/* Inserting data in "dbo.CountriesVerification" table from WHR_2016, WHR_2017, WHR_2018, WHR_2019". */ 

INSERT INTO dbo.CountriesVerification
	
	SELECT DISTINCT Country
	FROM dbo.WHR_2016
UNION
	SELECT DISTINCT Country
	FROM dbo.WHR_2017
UNION
	SELECT DISTINCT Country
	FROM dbo.WHR_2018
UNION
	SELECT DISTINCT Country
	FROM dbo.WHR_2019


/* List the data which has been inserted in table "dbo.CountriesVerification". */ 

SELECT * 
FROM dbo.CountriesVerification



/* Creating table "dbo.Combined1" to assign year to the data from the four datasets. */ 

CREATE TABLE dbo.Combined1(Year INT, Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3),
										Happiness_Rank INT,
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5)
)


/* Inserting data in "dbo.Combined1" for comparison. */ 

INSERT INTO dbo.Combined1

	SELECT 2016 as Year, Country, 
		Happiness_Score, 
		
		RANK() OVER(

		ORDER BY Happiness_Score DESC 
		) AS Happiness_Rank,
		
		GDP_per_Capita, Family, Health, 
		Freedom, Trust, Generosity
	
	FROM dbo.WHR_2016

UNION 

	SELECT 2017 as Year, Country, 
		Happiness_Score, 
		
		RANK() OVER(

		ORDER BY Happiness_Score DESC 
		) AS Happiness_Rank,
		
		GDP_per_Capita, Family, Health, 
		Freedom, Trust, Generosity

	FROM dbo.WHR_2017

UNION 

	SELECT 2018 as Year, Country, 
		Happiness_Score, 
		
		RANK() OVER(

		ORDER BY Happiness_Score DESC 
		) AS Happiness_Rank,
		
		GDP_per_Capita, Family, Health, 
		Freedom, Trust, Generosity

	FROM dbo.WHR_2018

UNION 

	SELECT 2019 as Year, Country, 
		Happiness_Score, 
		
		RANK() OVER(

		ORDER BY Happiness_Score DESC 
		) AS Happiness_Rank,
		
		GDP_per_Capita, Family, Health, 
		Freedom, Trust, Generosity

	FROM dbo.WHR_2019


/* List the data which has been inserted in table "dbo.Combined1". */ 

SELECT * 
FROM dbo.Combined1 



/* Creating table "dbo.Combined2" to verify missing data from the four datasets. */ 

CREATE TABLE dbo.Combined2(Year INT DEFAULT NULL, Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3),
										Happiness_Rank INT DEFAULT NULL,
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Trust DECIMAL(7,5),
										Generosity DECIMAL(7,5)
)



/* Inserting data in "dbo.Combined2" for comparison to obtain the list of missing countries and year from the four datasets. */ 

INSERT INTO dbo.Combined2 

SELECT a.Year, a.Country,
	b.Happiness_Score, b.Happiness_Rank, 
	b.GDP_per_Capita, b.Family, b.Health, 
	b.Freedom, b.Trust, b.Generosity 

FROM 

(
SELECT DISTINCT c.Country, d.Year 

FROM 

	(SELECT e.Country  
	 FROM dbo.WHR_2016 e 

	 INNER JOIN 

	 dbo.WHR_2017 f 
	 ON e.Country = f.Country 

	 INNER JOIN 

	 dbo.WHR_2018 g 
	 ON e.Country = g.Country 

	 INNER JOIN 

	 dbo.WHR_2019 h 
	 ON e.Country = h.Country) c 

	FULL JOIN 
	
	(SELECT DISTINCT Year, Country 
	 FROM dbo.Combined1) d 
	 ON c.Country = d.Country 
	 WHERE c.Country is not NULL AND d.country is not NULL) a 

LEFT JOIN 

	 dbo.Combined1 b 
ON a.Country = b.Country AND a.Year = b.Year 



/* List the data from table "dbo.Combined2" */

SELECT * 
FROM dbo.Combined2



*/





