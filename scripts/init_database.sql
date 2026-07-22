/*
=======================================
 Created by: Mahdi Javadi
 Date: 2024-06-10
=======================================
Scripts Purpose:
    This script is designed to initialize the data warehouse database and create 
    the necessary schema for the bronze, silver, and gold layers. It first checks 
    if the data warehouse database already exists and drops it if it does. 
    Then, it creates a new data warehouse database and sets up the required schema 
    for organizing data into different layers.


Warning:
    This script will drop the existing data warehouse database if it exists, 
    which will result in the loss of all data in that database. 
    Use with caution and ensure that you have backups if necessary.
*/

USE master;
GO


-- drop the data warehouse database if it already exists
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'data_warehouse')
BEGIN
    ALTER DATABASE data_warehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE data_warehouse;
END;
GO


-- create the data warehouse database
CREATE DATABASE data_warehouse;
GO

USE data_warehouse;
GO

-- create schema for the data warehouse (bronze, silver, gold  layers)
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
