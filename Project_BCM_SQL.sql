/*
/* Creating Database "Project_BCM" */ 
CREATE DATABASE Project_BCM  

/* Using "Project_BCM" Database */ 
USE Project_BCM */

/* Creating table for storing country data */ 

/* Creating table for storing Country data */ 
 /*
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

/* (a) - Creating table "Raw_WHR_2016" to store raw data from "HR_2016.csv". */ 

CREATE TABLE dbo.Raw_WHR_2016(Country VARCHAR(100) NULL, 
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


/* (b) - Creating table "Raw_WHR_2017" to store raw data from "happiNess_report_2017.csv". */

CREATE TABLE dbo.Raw_WHR_2017(Country VARCHAR(100) NULL, 
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


/* (c) - Creating table "Raw_WHR_2018" to store raw data from "2018.csv". */

CREATE TABLE dbo.Raw_WHR_2018(Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5))


/* (d) - Creating table "Raw_WHR_2019" to store raw data from "report_2019.csv". */

CREATE TABLE dbo.Raw_WHR_2019(Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3),
										GDP_per_Capita DECIMAL(7,5),
										Family DECIMAL(7,5),
										Health DECIMAL(7,5),
										Freedom DECIMAL(7,5),
										Generosity DECIMAL(7,5),
										Trust DECIMAL(7,5))
								


/* Using "TRUNCATE" to remove all rows (data) from a table and "BULK INSERT" to populate the tables. */ 

TRUNCATE TABLE dbo.Country
TRUNCATE TABLE dbo.Raw_WHR_2016
TRUNCATE TABLE dbo.Raw_WHR_2017
TRUNCATE TABLE dbo.Raw_WHR_2018
TRUNCATE TABLE dbo.Raw_WHR_2019 


/* Inserting data into "dbo.Country" from "Country_List.csv". */ 


BULK INSERT dbo.Country
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Country_List.csv'
WITH
(
	FIRSTROW=2, /* Import of data starts as from row 2, else header will be imported as well. */
	FORMAT='CSV'
)


/* List the data which has been inserted in table "dbo.Country". */ 

SELECT * 
FROM dbo.Country


/* Inserting data into the report tables. */ 

/* (a) - Inserting data into "dbo.Raw_WHR_2016" from "HR_2016.csv". */


BULK INSERT dbo.Raw_WHR_2016
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\HR_2016.csv'
WITH
(

	FIRSTROW=2, /* Import of data starts as from row 2, else header will be imported as well. */
	FORMAT='CSV'
	
)


/* List the data which has been inserted in table "dbo.WHR_2016". */ 

SELECT * 
FROM dbo.Raw_WHR_2016


/* (b) - Inserting data into "dbo.Raw_WHR_2017" from "happiNess_report_2017.csv". */

BULK INSERT dbo.Raw_WHR_2017
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\happiNess_report_2017.csv'
WITH
(

	FIRSTROW=2, /* Import of data starts as from row 2, else header will be imported as well. */
	FORMAT='CSV'
	
)


/* List the data which has been inserted in table "dbo.WHR_2017". */ 

SELECT * 
FROM dbo.Raw_WHR_2017


	/* (c) - Inserting data into "dbo.Raw_WHR_2018" from "2018.csv". */

	BULK INSERT dbo.Raw_WHR_2018
	FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\2018.csv'
	WITH
	(

		FIRSTROW=2, /* Import of data starts as from row 2, else header will be imported as well. */
		FORMAT='CSV' 
		/* Convert "Trust" from "DECIMAL" TO "VARCHAR(20)" using CAST([Trust] AS VARCHAR(20)) */
		
	)


/* List the data which has been inserted in table "dbo.WHR_2018". */ 

SELECT * 
FROM dbo.Raw_WHR_2018


/* (d) - Inserting data into "dbo.Raw_WHR_2019" from "report_2019.csv". */

BULK INSERT dbo.Raw_WHR_2019
FROM 'C:\Users\pkavi\Documents\MCB_Assignment\Data Files\report_2019.csv'
WITH
(

	FIRSTROW=2, /* Import of data starts as from row 2, else header will be imported as well. */
	FORMAT='CSV'
	
)

/* List the data which has been inserted in table "dbo.Raw_WHR_2019". */ 

SELECT * 
FROM dbo.Raw_WHR_2019



/* Creating table to store data that will be used for analysis. */ 

/* (a) - Creating table "WHR_2016" to store data used for analysis. */ 

CREATE TABLE dbo.WHR_2016(
										Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3), 
										Happiness_Rank INT, 
										GDP_per_Capita DECIMAL(7,5), 
										Family DECIMAL(7,5), 
										Health DECIMAL(7,5), 
										Freedom DECIMAL(7,5), 
										Trust DECIMAL(7,5), 
										Generosity DECIMAL(7,5), 
										Dystopia DECIMAL(7,5)
)
										

/* (b) - Creating table "WHR_2017" to store data used for analysis. */

CREATE TABLE dbo.WHR_2017(
										Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3), 
										Happiness_Rank INT, 
										GDP_per_Capita DECIMAL(7,5), 
										Family DECIMAL(7,5), 
										Health DECIMAL(7,5), 
										Freedom DECIMAL(7,5), 
										Trust DECIMAL(7,5), 
										Generosity DECIMAL(7,5), 
										Dystopia DECIMAL(7,5)
)
										

/* (c) - Creating table "WHR_2018" to store data used for analysis. */

CREATE TABLE dbo.WHR_2018(
										Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3), 
										Happiness_Rank INT, 
										GDP_per_Capita DECIMAL(7,5), 
										Family DECIMAL(7,5), 
										Health DECIMAL(7,5), 
										Freedom DECIMAL(7,5), 
										Trust DECIMAL(7,5), 
										Generosity DECIMAL(7,5)
)
										

/* (d) - Creating table "WHR_2019" to store data used for analysis. */

CREATE TABLE dbo.WHR_2019(
										Country VARCHAR(100) NULL, 
										Happiness_Score DECIMAL(6,3), 
										Happiness_Rank INT, 
										GDP_per_Capita DECIMAL(7,5), 
										Family DECIMAL(7,5), 
										Health DECIMAL(7,5), 
										Freedom DECIMAL(7,5), 
										Trust DECIMAL(7,5), 
										Generosity DECIMAL(7,5)
)


/* Using "TRUNCATE" to remove all rows (data) from a table. */ 

TRUNCATE TABLE dbo.WHR_2016
TRUNCATE TABLE dbo.WHR_2017
TRUNCATE TABLE dbo.WHR_2018
TRUNCATE TABLE dbo.WHR_2019


/* Inserting data into the report tables for analysis. */ 

/* (a) - Inserting data into "dbo.WHR_2016" from "Raw_WHR_2016". */


INSERT INTO dbo.WHR_2016 

SELECT Country, Happiness_Score, 
	
	RANK() OVER(

		ORDER BY Happiness_Score DESC 
		) AS Happiness_Rank,
		
		GDP_per_Capita, Family, Health,
		Freedom, Trust, Generosity, Dystopia
		
FROM dbo.Raw_WHR_2016


/* List the data which has been inserted in table "dbo.WHR_2016". */ 

SELECT * 
FROM dbo.WHR_2016


/* (b) - Inserting data into "dbo.WHR_2017" from "Raw_WHR_2017". */


INSERT INTO dbo.WHR_2017 

SELECT Country, Happiness_Score, 
	
	RANK() OVER(

		ORDER BY Happiness_Score DESC 
		) AS Happiness_Rank,
		
		GDP_per_Capita, Family, Health,
		Freedom, Trust, Generosity, Dystopia
		
FROM dbo.Raw_WHR_2017


/* List the data which has been inserted in table "dbo.WHR_2017". */ 

SELECT * 
FROM dbo.WHR_2017


/* (c) - Inserting data into "dbo.WHR_2018" from "Raw_WHR_2018". */


INSERT INTO dbo.WHR_2018 

SELECT Country, Happiness_Score, 
	
	RANK() OVER(

		ORDER BY Happiness_Score DESC 
		) AS Happiness_Rank,
		
		GDP_per_Capita, Family, Health,
		Freedom, Trust, Generosity
		
FROM dbo.Raw_WHR_2018


/* List the data which has been inserted in table "dbo.WHR_2018". */ 

SELECT * 
FROM dbo.WHR_2018


/* (d) - Inserting data into "dbo.WHR_2019" from "Raw_WHR_2019". */


INSERT INTO dbo.WHR_2019 

SELECT Country, Happiness_Score, 
	
	RANK() OVER(

		ORDER BY Happiness_Score DESC 
		) AS Happiness_Rank,
		
		GDP_per_Capita, Family, Health,
		Freedom, Trust, Generosity
		
FROM dbo.Raw_WHR_2019


/* List the data which has been inserted in table "dbo.WHR_2019". */ 

SELECT * 
FROM dbo.WHR_2019

*/ 

USE Project_MCB