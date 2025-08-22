--Create Database 'Warehouse'
-- In this database we have three schemas bronze,silver,gold
USE master;
GO
--Creating Database
Create Database DataWarehouse;
GO
USE DataWarehouse;
GO

--Create Schemas
CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO
  
CREATE SCHEMA gold;
GO
