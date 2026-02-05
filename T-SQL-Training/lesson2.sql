/*

== 2. SQL Server Server (T-SQL) Data Structure, Types and Constraints ==
------------------------------------------------------------------------

- Database Objects
(Tables, views, stored procedures, functions, etc) ✅
- Tables, columns, rows, schemas and naming convention)  ✅
- SQL Server Data Types ✅ (We stopped here in the last lesson)

- Null Concepts
- Constraints
(NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, IDENTITY, etc) 
------------------------------------------------------------------------


== 3. T-SQL Fundamentals ==
------------------------------------------------------------------------
-   Select statement and Basic Queries (Syntax, selecting columns, aliases, 
    distinct, basic expressions and calculations) 
-   Filtering Data (WHERE clause, comparison and logical operators, 
    between, in, like 
-   Sorting and Conditional Logic
    (ORDER BY, single and multi-column sorting, TOP & ORDER BY, OFFSET,
    FETCH, etc)
-   CASE expressions
------------------------------------------------------------------------

*/


/*
------------------------------------- START ----------------------------
== 2. SQL Server Server (T-SQL) Data Structure, (Types and Constraints) ==
------------------------------------------------------------------------

-- All -TSQL Data Types: https://docs.microsoft.com/en-us/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver16

-- Commonly used data types:
(Filtering, sorting and Conditional Logic)
-- INT, BIGINT, SMALLINT, TINYINT (Integer data types)
-- DECIMAL, NUMERIC, FLOAT, REAL (Numeric data types)
-- CHAR, VARCHAR, NCHAR, NVARCHAR (Character data types)
-- DATE, DATETIME, DATETIME2, TIME (Date and time data types)


== Null Concepts ==
------------------------------------------------------------------------
- NULL represents the absence of a value in a column. It is not the same as an empty string or zero. NULL values can lead to unexpected results in queries if not handled properly. Use
- IS NULL and IS NOT NULL to check for NULL values in queries.


== Constraints ==
------------------------------------------------------------------------
Constraints are rules applied to columns in a table to enforce data integrity. 
They ensure that the data entered into the table meets specific criteria. 

Examples:

1 NOT NULL: Ensures that a column cannot have NULL values. It requires that every record must have a value for that column.
2. UNIQUE constraint ensures that all values in a column are unique. It allows NULL values, but only one NULL value is allowed per column.
3. PRIMARY KEY constraint uniquely identifies each record in a table. It does not allow NULL values and must contain unique values. A table can have only one primary key, which can consist of single or multiple columns (composite key).
4. FOREIGN KEY constraint is used to link two tables together. It ensures that the value in a column (or a set of columns) in one table matches the value in a column (or set of columns) in another table. It helps maintain referential integrity between the tables.
5. IDENTITY constraint is used to create an auto-incrementing column. It automatically generates a unique value for each new record inserted into the table. The syntax for IDENTITY is IDENTITY(seed, increment), where seed is the starting value and increment is the value added to the previous value for each new record.
6. CHECK constraint is used to limit the values that can be placed in a column. It ensures that the value in a column meets a specific condition. For example, you can use a CHECK constraint to ensure that the salary of an employee is greater than zero.
7. DEFAULT constraint is used to provide a default value for a column when no value is specified during an insert operation. It ensures that a column has a default value if none is provided.
*/


-------------------------------------------------------------------------
-- == Creating tables with various data types and constraints ==
-------------------------------------------------------------------------

-- Example of Unique constraint
CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    -- Primary Key constraint
    DepartmentName NVARCHAR(100) UNIQUE
    -- Unique constraint
);

-- Example of creating a table with various data types and constraints
CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    -- Primary Key constraint
    FirstName NVARCHAR(50) NOT NULL,
    -- NOT NULL constraint
    LastName NVARCHAR(50) NOT NULL,
    -- NOT NULL constraint
    Gender CHAR(7) CHECK (Gender IN ('Male', 'Female', 'Other')),
    -- CHECK constraint
    PhoneNumber VARCHAR(15) UNIQUE,
    -- Unique constraint
    BirthDate DATE,
    -- Date data type
    HireDate DATE,
    -- Date data type
    Salary DECIMAL(18, 2) CHECK (Salary > 0),
    -- Decimal data type with CHECK constraint
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    -- Foreign Key constraint
);

-------------------------------------------------------------------------
-- == Adding new data into tables using INSERT statements ==
-------------------------------------------------------------------------

-- INSERT statements to populate the Departments and Employees tables with sample data
-- Syntax: INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);

-- Example of inserting data into the Departments table
INSERT INTO Departments
    (DepartmentID, DepartmentName)
VALUES
    (1, 'Human Resources'),
    (2, 'Finance'),
    (3, 'IT'),
    (4, 'Marketing'),
    (5, 'Sales');

-- Example of inserting data into the Employees table

-- Note: Ensure that the DepartmentID values in the Employees table match the DepartmentID values in the Departments table to satisfy the foreign key constraint.

INSERT INTO Employees
    (EmployeeID, FirstName, LastName, Gender, PhoneNumber, BirthDate, HireDate, Salary, DepartmentID)
VALUES
    (1, 'John', 'Wale', 'Male', '123-456-7890', '1980-01-01', '2005-06-15', 60000.00, 1),
    (2, 'Adekunle', 'Adio', 'Male', '234-567-8901', '1985-02-15', '2010-09-01', 75000.00, 2),
    (3, 'Michael', 'Seun', 'Male', '345-678-9012', '1990-03-20', '2015-01-10', 50000.00, 3),
    (4, 'Sade', 'Ogunleye', 'Female', '456-789-0123', '1995-04-25', '2020-05-20', 45000.00, 4),
    (5, 'David', 'Michael', 'Male', '567-890-1234', '1988-05-30', '2012-11-05', 55000.00, 5),
    (6, 'Badmus', 'Iremide', 'Male', '678-901-2345', '1992-06-10', '2018-03-15', 48000.00, 1),
    (7, 'James', 'Adeosun', 'Male', '789-012-3456', '1983-07-15', '2008-08-01', 65000.00, 2),
    (8, 'Jessica', 'Chukwudi', 'Female', '890-123-4567', '1991-08-20', '2016-12-01', 52000.00, 3),
    (9, 'Daniel', 'Aliyu', 'Male', '901-234-5678', '1987-09-25', '2013-04-10', 58000.00, 4),
    (10, 'Bimbo', 'Edun', 'Female', '012-345-6789', '1993-10-30', '2019-07-01', 47000.00, 5),
    (11, 'Chinedu', 'Okafor', 'Male', '123-456-7891', '1989-11-05', '2014-02-20', 53000.00, 1),
    (12, 'Amina', 'Abdul', 'Female', '234-567-8902', '1990-12-10', '2015-09-01', 51000.00, 2),
    (13, 'Oluwaseun', 'Adeyemi', 'Male', '345-678-9013', '1992-01-15', '2018-03-15', 48000.00, 3),
    (14, 'Aisha', 'Abdul', 'Female', '456-789-0124', '1988-02-20', '2012-11-05', 55000.00, 4),
    (15, 'Funke', 'Adebola', 'Female', '567-890-1235', '1990-03-25', '2015-09-01', 51000.00, 5),
    (16, 'Oluwaseun', 'Adeyemi', 'Male', '678-901-2346', '1992-04-30', '2018-03-15', 48000.00, 1),
    (17, 'Aisha', 'Abdul', 'Female', '789-012-3457', '1988-05-05', '2012-11-05', 55000.00, 2),
    (18, 'Kemi', 'Ogunleye', 'Female', '890-123-4568', '1991-06-10', '2016-12-01', 52000.00, 3),
    (19, 'Emmanuel', 'Okoro', 'Male', '901-234-5679', '1987-07-15', '2013-04-10', 58000.00, 4),
    (20, 'Adewale', 'Adebayo', 'Male', '012-345-6780', '1993-08-20', '2019-07-01', 47000.00, 5);



/*
------------------------------------------------------------------------
== 3. T-SQL Fundamentals ==
(Filtering, sorting and Conditional Logic)
------------------------------------------------------------------------

-   Select statement and Basic Queries (Syntax, selecting columns, aliases, 
    distinct, basic expressions and calculations) 
-   Filtering Data (WHERE clause, comparison and logical operators, 
    between, in, like 
-   Sorting and Conditional Logic
    (ORDER BY, single and multi-column sorting, TOP & ORDER BY, OFFSET,
    FETCH, etc)
-   CASE expressions
------------------------------------------------------------------------
*/


-- Syntax of a basic SELECT statement
------------------------------------------------------------------------
/*
SELECT column1, column2, ...
FROM table_name
WHERE condition
ORDER BY column1, column2, ...;
*/

-- Example of a basic SELECT statement with column selection and aliasing
SELECT
    EmployeeID AS EmpID,
    FirstName, -- no aliasing for this column
    Gender AS Sex, -- Alias with AS keyword
    LastName, -- Alias without AS keyword
    Salary AS MonthlySalary
FROM Employees;

-- Selecting distinct values from a column
SELECT DISTINCT DepartmentID
FROM Employees;

-- Selecting all columns from the Employees table
SELECT *
FROM Employees;

-- Selecting specific columns and performing basic calculations (e.g., calculating annual salary)
SELECT
    FirstName,
    LastName,
    Salary,
    Salary * 12 AS AnnualSalary,
    Salary * 0.10 AS Bonus,
    Salary + (Salary * 0.10) AS TotalCompensation
FROM Employees;

-- Example of filtering data using the WHERE clause with comparison and logical operators
SELECT
    FirstName,
    LastName,
    Salary
FROM Employees
WHERE Salary > 50000 AND DepartmentID = 2;

-- Example of using the BETWEEN operator to filter data based on a range
SELECT
    FirstName,
    LastName,
    HireDate
FROM Employees
WHERE HireDate BETWEEN '2010-01-01' AND '2020-12-31';

-- Example of using the IN operator to filter data based on a list of values
SELECT
    FirstName,
    LastName,
    DepartmentID
FROM Employees
WHERE DepartmentID IN (1, 3, 5);

-- Example of using the LIKE operator to filter data based on a pattern
SELECT
    FirstName,
    LastName,
    PhoneNumber
FROM Employees
WHERE PhoneNumber LIKE '123-%';

-- Example of sorting data using the ORDER BY clause with single
SELECT
    FirstName,
    LastName,
    Salary
FROM Employees
ORDER BY Salary DESC;
-- Sort by Salary in descending order

-- Example of sorting data using the ORDER BY clause with multiple columns
SELECT
    FirstName,
    LastName,
    DepartmentID
FROM Employees
ORDER BY DepartmentID ASC, LastName ASC;
-- Sort by DepartmentID in ascending order, then by LastName in ascending order

-- Example of using TOP with ORDER BY to get the top 5 highest paid employees
SELECT TOP 5
    FirstName,
    LastName,
    Salary
FROM Employees
ORDER BY Salary DESC;

-- Example of using OFFSET and FETCH to implement pagination 
-- (e.g., get the next 10 employees after skipping the first 20 employees)
SELECT
    FirstName,
    LastName,
    Salary
FROM Employees
ORDER BY EmployeeID
OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY;


-- Example of using CASE expressions to create conditional logic in a SELECT statement
SELECT
    FirstName,
    LastName,
    Salary,
    CASE
        WHEN Salary < 50000 THEN 'Low'
        WHEN Salary BETWEEN 50000 AND 70000 THEN 'Medium'
        ELSE 'High'
    END AS SalaryCategory
FROM Employees;
