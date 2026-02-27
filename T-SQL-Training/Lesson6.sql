/*
-----------------------------------------------------------------
LESSON 6: T-SQL DATA MANIPULATION AND TABLE STRUCTURE ALTERATION
-----------------------------------------------------------------
In this lesson, we will cover the following topics: 

A. INSERT, UPDATE, DELETE, TRUNCATE
    - Insert new records into tables
    - Update existing records
    - Delete records from tables
    - Truncate tables (remove all records from a table)

B. ALTER TABLE
    - Add new columns to existing tables
    - Modify existing columns (data type, size, etc.)
    - Drop columns from tables
    - Add or drop constraints (e.g., primary key, foreign key, unique, check)

--------------------------------------------------------------------------------
*/

-------------------------------------------------------------------------
-- PRELIMINARY SETUP
-------------------------------------------------------------------------
/*
Before we dive into the data manipulation and table alteration commands, 
let's set up some sample tables and data to work with. 

We will create one table to demonstrate the INSERT, UPDATE, DELETE, and TRUNCATE commands, 
and another table to demonstrate the ALTER TABLE command.
*/

CREATE DATABASE TSQLTraining;
GO

USE TSQLTraining;
GO

CREATE TABLE Drugs
(
    DrugID INT PRIMARY KEY,
    DrugName VARCHAR(100),
    Price DECIMAL(10, 2) DEFAULT 0.00,
    Stock INT DEFAULT 0
);


/*
-------------------------------------------------
-------------------------------------------------
A. INSERT, UPDATE, DELETE, TRUNCATE
-------------------------------------------------
-------------------------------------------------
*/


-------------------------------------------------
-- INSERT STATEMENT
-------------------------------------------------
/*
    The INSERT statement is used to add new records to a table.

    Outline:
    - Insert a single record into a table
    - Insert multiple records into a table
    - Insert records with specific column names exempting columns with default values.
    - Insert records from another table (using SELECT)


    Syntax of INSERT statement:
    ------------------------
    1. Insert a single record:
        INSERT INTO table_name (column1, column2, ...)
        VALUES (value1, value2, ...);

    2. Insert multiple records:
        INSERT INTO table_name (column1, column2, ...)
        VALUES (value1, value2, ...),
            (value1, value2, ...),
*/


-- Insert a single record into the Drugs table
------------------------------------------------
INSERT INTO Drugs
    (DrugID, DrugName, Price, Stock)
VALUES
    (1, 'Aspirin', 9.99, 100);

-- Insert multiple records into the Drugs table
------------------------------------------------
INSERT INTO Drugs
    (DrugID, DrugName, Price, Stock)
VALUES
    (2, 'Ibuprofen', 14.99, 150),
    (3, 'Paracetamol', 7.99, 200),
    (4, 'Amoxicillin', 19.99, 50),
    (5, 'Ciprofloxacin', 29.99, 30),
    (6, 'Metformin', 24.99, 80),
    (7, 'Lisinopril', 12.99, 120),
    (8, 'Atorvastatin', 17.99, 90),
    (9, 'Omeprazole', 11.99, 110),
    (10, 'Simvastatin', 15.99, 70);

-- Insert records with specific column names exempting columns with default values.
----------------------------------------------------------------------------------
INSERT INTO Drugs
    (DrugID, DrugName)
VALUES
    (11, 'Losartan'),
    (12, 'Amlodipine');
-- The Price and Stock columns will automatically get the default value of 0.00 and 0 respectively.


-- Insert records from another table (using SELECT)
------------------------------------------------
-- Create another table to copy data from
CREATE TABLE NewDrugs
(
    DrugID INT PRIMARY KEY,
    DrugName VARCHAR(100),
    Price DECIMAL(10, 2),
    Stock INT
);

INSERT INTO NewDrugs
    (DrugID, DrugName, Price, Stock)
VALUES
    (13, 'Losartan', 13.99, 60),
    (14, 'Amlodipine', 16.99, 40),
    (15, 'Metoprolol', 18.99, 30),
    (16, 'Albuterol', 22.99, 20),
    (17, 'Gabapentin', 25.99, 10);

-- Now, inserting records from NewDrugs into Drugs
INSERT INTO Drugs
    (DrugID, DrugName, Price, Stock)
SELECT DrugID, DrugName, Price, Stock
FROM NewDrugs;


-------------------------------------------------
-- UPDATE STATEMENT
-------------------------------------------------
/*
    The UPDATE statement is used to modify existing records in a table.

    Outline:
    - Update a single record
    - Update multiple records
    - Update records based on a condition
    - Update records using a subquery

    Syntax of UPDATE statement:
    ------------------------
    1. Update a single record:
        UPDATE table_name
        SET column1 = value1, column2 = value2, ...
        WHERE condition;

    2. Update multiple records:
        UPDATE table_name
        SET column1 = value1, column2 = value2, ...
        WHERE condition;

    3. Update records based on a condition:
        UPDATE table_name
        SET column1 = value1, column2 = value2, ...
        WHERE condition;

    4. Update records using a subquery:
        UPDATE table_name
        SET column1 = (SELECT value FROM another_table WHERE condition)
        WHERE condition;
*/

-- Update a single record in the Drugs table
UPDATE Drugs
SET Price = 8.99, Stock = 120
WHERE DrugID = 1;

-- Update multiple records in the Drugs table
UPDATE Drugs
SET Price = Price + Price * 0.10 -- Increase price by 10%
WHERE Stock < 100;

-- Update records based on a condition
UPDATE Drugs
SET Stock = Stock + 50
WHERE DrugName IN ('Ibuprofen', 'Paracetamol');

-- Update records using a subquery
UPDATE Drugs
SET Price = (SELECT AVG(Price)
FROM NewDrugs)
WHERE DrugID IN (SELECT DrugID
FROM NewDrugs);

-------------------------------------------------
-- DELETE STATEMENT
-------------------------------------------------
/*
    The DELETE statement is used to remove existing records from a table.

    Outline:
    - Delete a single record
    - Delete multiple records
    - Delete records based on a condition
    - Delete all records from a table

    Syntax of DELETE statement:
    ---------------------------
    1. Delete a single record:
        DELETE FROM table_name
        WHERE condition;

    2. Delete multiple records:
        DELETE FROM table_name
        WHERE condition;

    3. Delete records based on a condition:
        DELETE FROM table_name
        WHERE condition;

    4. Delete all records from a table:
        DELETE FROM table_name;  # Very dangerous, use with caution!
*/

-- Delete a single record from the Drugs table
DELETE FROM Drugs
WHERE DrugID = 16;

-- Delete multiple records from the Drugs table
DELETE FROM Drugs
WHERE Stock < 50;

-- Delete records based on a condition
DELETE FROM Drugs
WHERE DrugName LIKE 'A%';
-- Deletes drugs starting with 'A'  # Use with caution!

-- Delete all records from the Drugs table
DELETE FROM Drugs;
-- Use with caution!
/*
NOTE:
    - TRUNCATE TABLE is a better option if you want to remove all records from a table, 
    as it is faster and uses fewer system resources than DELETE.
*/


------------------------------------
-- TRUNCATE TABLE STATEMENT
------------------------------------
/*
    The TRUNCATE TABLE statement is used to remove all records from a table,
    but it is faster and uses fewer system resources than DELETE because it does not log individual row deletions. 
    
    NOTE:
    - TRUNCATE TABLE cannot be used when a table is referenced by a FOREIGN KEY constraint.

    Syntax of TRUNCATE TABLE:
    ----------------------
    TRUNCATE TABLE table_name;
*/

-- Truncate the NewDrugs table
TRUNCATE TABLE NewDrugs;
-- Use with caution!


/*
---------------------------------
---------------------------------
B. ALTER TABLE
---------------------------------
---------------------------------
    The ALTER TABLE statement is used to modify the structure of an existing table.

    Outline:
        - Add new columns to existing tables
        - Modify existing columns (data type, size, etc.)
        - Drop columns from tables
        - Add or drop constraints (e.g., primary key, foreign key, unique, check)

    Syntax of ALTER TABLE statement:
    ---------------------------
    1. Add a new column:
        ALTER TABLE table_name
        ADD column_name data_type;

    2. Modify an existing column:
        ALTER TABLE table_name
        ALTER COLUMN column_name new_data_type;

    3. Drop a column:
        ALTER TABLE table_name
        DROP COLUMN column_name;

    4. Add a constraint:
        ALTER TABLE table_name
        ADD CONSTRAINT constraint_name constraint_type (column_name);

    5. Drop a constraint:
        ALTER TABLE table_name
        DROP CONSTRAINT constraint_name;
*/


-- Add a new column to the Drugs table
ALTER TABLE Drugs
ADD ExpirationDate DATE;

-- Modify an existing column in the Drugs table
ALTER TABLE Drugs
ALTER COLUMN Price DECIMAL(12, 2);
-- Changing the data type and precision of the Price column

-- Drop a column from the Drugs table
ALTER TABLE Drugs
DROP COLUMN ExpirationDate;

-- Add a new constraint to the Drugs table
ALTER TABLE Drugs
ADD CONSTRAINT UQ_DrugName UNIQUE (DrugName);
-- Adding a unique constraint on the DrugName column

-- Add Primary Key constraint to the NewDrugs table
ALTER TABLE NewDrugs
ADD CONSTRAINT PK_NewDrugs PRIMARY KEY (DrugID);

-- Add Check constraint to the Drugs table
ALTER TABLE Drugs
ADD CONSTRAINT CHK_Price CHECK (Price >= 0);
-- Adding a check constraint

-- Drop a constraint from the Drugs table
ALTER TABLE Drugs
DROP CONSTRAINT UQ_DrugName;
-- Dropping the unique constraint on the DrugName

-- Drop Primary Key constraint from the NewDrugs table
ALTER TABLE NewDrugs
DROP CONSTRAINT PK_NewDrugs;

-- Drop Check constraint from the Drugs table
ALTER TABLE Drugs
DROP CONSTRAINT CHK_Price;

-- Delete the Drugs and NewDrugs tables to clean up
DROP TABLE Drugs;
DROP TABLE NewDrugs;

/*
---------------------------------
SUMMARY
---------------------------------
    In this lesson, we covered the following topics:
    A. INSERT, UPDATE, DELETE, TRUNCATE
        - Insert new records into tables
        - Update existing records
        - Delete records from tables
        - Truncate tables (remove all records from a table)
    B. ALTER TABLE
        - Add new columns to existing tables
        - Modify existing columns (data type, size, etc.)
        - Drop columns from tables  
        - Add or drop constraints (e.g., primary key, foreign key, unique, check)

    Key takeaways:
    - Use INSERT to add new records, UPDATE to modify existing records, DELETE to remove records, and TRUNCATE to quickly remove all records from a table.
    - Use ALTER TABLE to change the structure of a table by adding, modifying, or dropping columns and constraints.
    - Always be cautious when using DELETE and TRUNCATE, as they can lead to data loss if not used carefully.
    - Always back up your data before performing any destructive operations.
*/

-- Next Lesson: JOINS
