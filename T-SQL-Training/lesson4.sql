
/*
--------------------------------------------------------------------------------
LESSON 4:
--------------------------------------------------------------------------------

A. SORTING WITH ORDER BY AND LIMITING RESULTS WITH TOP, OFFSET, FETCH
    - Sort query results using ORDER BY
    - Sort by multiple columns
    - Control ascending and descending order
    - Limit result sets using TOP and 
    - Paginate result sets using OFFSET–FETCH
    - Conditional logic with CASE expressions

B. AGGREGATE FUNCTIONS
    - Understand what aggregate functions are
    - Use COUNT, SUM, AVG, MIN, MAX
    - Handle NULL values in aggregation
    - Perform basic data summarization 

--------------------------------------------------------------------------------
*/


-------------------------------------------------------------------------
-- PRELIMINARY SETUP
-------------------------------------------------------------------------
-- Create a sample Departments and Employees tables with mock data for demonstration purposes.



-------------------------------------------------------------------------
-- == Creating tables ==
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
/*
Note: 
    Ensure that the DepartmentID values in the Employees table match the DepartmentID 
    values in the Departments table to satisfy the foreign key constraint.
*/

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



---------------------------------START-----------------------------------------
-- Lesson 4 (A): SORTING WITH ORDER BY AND LIMITING RESULTS WITH TOP, OFFSET, FETCH
-------------------------------------------------------------------------------

/*
-------------------------------------------------------
-   Sort query results using ORDER BY
-   Sort by multiple columns
-   Control ascending and descending order
-   Limit result sets using TOP and OFFSET–FETCH
-------------------------------------------------------

Why Sorting and Limiting Results is Important?
----------------------------------------------
- Sorting helps answer questions like:
    - Top customers by revenue
    - Latest transactions
    - Best-performing products
    - Worst-performing regions


NOTE:
    - Default sorting order is ascending (ASC), but you can specify descending order (DESC) 
    for any column in the ORDER BY clause.
    - When sorting by multiple columns, the sorting is performed first by the first column, 
    then by the second column within each group of the first column, and so on.
    - TOP is used to limit the number of rows returned by a query, often used with ORDER BY
    -  OFFSET and FETCH are used for pagination.


Syntax of a SELECT statement with ORDER BY clause
------------------------------------------------
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition
    ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;
*/


-- Default sorting order is ascending (ASC)
SELECT
    FirstName,
    LastName,
    Salary
FROM Employees
ORDER BY Salary;


-- Sorting in descending order (DESC) (Single column)
-- (e.g. Sort by Salary in descending order)
SELECT
    FirstName,
    LastName,
    Salary
FROM Employees
ORDER BY Salary DESC;


-- Example of sorting data using the ORDER BY clause with multiple columns
-- (e.g. Sort by DepartmentID in ascending order, then by LastName in ascending order within each department)
SELECT
    FirstName,
    LastName,
    DepartmentID
FROM Employees
ORDER BY DepartmentID ASC, LastName ASC;

-------------------------------------------------
-- Limiting Rows with TOP and ORDER BY
-------------------------------------------------
/* 
Use cases:
    - Top N customers
    - Highest sales
    - Latest transactions
*/

-- Example of using TOP and ORDER BY to limit the number of rows returned by a query
-- (e.g. Get the top 5 highest paid employees)
SELECT TOP 5
    FirstName,
    LastName,
    Salary
FROM Employees
ORDER BY Salary DESC;

-- (e.g Get the top 10 most recently hired employees)
SELECT TOP 10
    *
FROM Employees
ORDER BY HireDate DESC;

-- (e.g. Get the top 3 employees with the lowest salaries)
SELECT TOP 3
    FirstName,
    LastName,
    Salary
FROM Employees
ORDER BY Salary ASC;


-- Example of using TOP with ORDER BY to get the top 5 highest paid employees
SELECT TOP 5
    FirstName,
    LastName,
    Salary
FROM Employees
ORDER BY Salary DESC;


-------------------------------------------------
-- OFFSET & FETCH (Pagination)
-------------------------------------------------
/*
Use cases:
    - Web applications with paginated results
    - Reporting with large datasets
    - Analyzing data in chunks
    - Navigating through large result sets without overwhelming the user or the system
    - Dashboards that display a limited number of records at a time
*/

-- Example of using OFFSET and FETCH to implement pagination 
-- (e.g., get the next 7 employees after skipping the first 10 employees)

-- Page 1: OFFSET 0 ROWS FETCH NEXT 7 ROWS ONLY
SELECT
    FirstName,
    LastName,
    Salary
FROM Employees
ORDER BY EmployeeID
OFFSET 0 ROWS FETCH NEXT 7 ROWS ONLY;

-- Page 2: OFFSET 7 ROWS FETCH NEXT 7 ROWS ONLY
SELECT
    FirstName,
    LastName,
    Salary
FROM Employees
ORDER BY EmployeeID
OFFSET 7 ROWS FETCH NEXT 7 ROWS ONLY;


-------------------------------------------------
-- CONDITIONAL LOGIC WITH CASE EXPRESSIONS
-------------------------------------------------
/*
Use cases:
---------------------------------
    - Classify customers based on purchase history
    - Segment products by sales performance
    - Label performance levels
    - Convert numeric values into business-friendly categories

    - Categorizing data based on conditions
    - Creating new columns based on existing data
    - Implementing complex business logic in queries
    - Handling NULL values and providing default values

Syntax of a CASE expression:
---------------------------------
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE default_result
END
*/



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

-- CASE with Text Conditions
SELECT
    FirstName,
    LastName,
    DepartmentID,
    CASE DepartmentID
        WHEN 1 THEN 'HR'
        WHEN 2 THEN 'IT'
        WHEN 3 THEN 'Finance'
        ELSE 'Other'
    END AS DepartmentName
FROM Employees;

-- Alternatively, using CASE with a more complex condition
SELECT
    FirstName,
    LastName,
    DepartmentID,
    CASE 
        WHEN DepartmentID = 1 THEN 'HR'
        WHEN DepartmentID = 2 THEN 'IT'
        WHEN DepartmentID = 3 THEN 'Finance'
        ELSE 'Other'
    END AS DepartmentName
FROM Employees;

-- CASE with NULL Handling
SELECT
    FirstName,
    LastName,
    PhoneNumber,
    CASE 
        WHEN PhoneNumber IS NULL THEN 'No Phone'
        ELSE 'Has Phone'
    END AS PhoneStatus
FROM Employees;

/*
CASE Best Practices:
---------------------------------
    - Keep it simple and readable
    - Avoid complex nested CASE expressions
    - Use meaningful aliases for calculated columns
    - Test all conditions to ensure they cover all possible scenarios
*/




--------------------------------------------------------------------------------
-- LESSON 4 (B): AGGREGATE FUNCTIONS
--------------------------------------------------------------------------------

/*
-------------------------------------------
- Understand what aggregate functions are
- Use COUNT, SUM, AVG, MIN, MAX
- Handle NULL values in aggregation
- Perform basic data summarization 
-------------------------------------------


What Are Aggregate Functions?
-----------------------------------
Aggregate functions are built-in functions in SQL that perform 
calculations on a set of values and return a single value as a result. 
They are used to summarize or aggregate data in a meaningful way. Aggregate

    - Work on multiple rows
    - Return a single summarized value


Common Aggregate Functions:
----------------------------------
- COUNT: Counts rows
- SUM: Adds numeric values
- AVG: Calculates average
- MIN: Smallest value
- MAX: Largest value


Use Cases for Aggregate Functions:
-----------------------------------
    - Total sales?
    - Average order value?
    - Highest or lowest transaction?
    - Number of customers?


Handling NULL Values in Aggregation:
-----------------------------------
    - COUNT(column) ignores NULLs
    - SUM(column) ignores NULLs
    - AVG(column) ignores NULLs
    - MIN(column) ignores NULLs
    - MAX(column) ignores NULLs 


Syntax for Using Aggregate Functions:
------------------------------------------
    SELECT
        AggregateFunction(ColumnName) AS AliasName
    FROM TableName
    WHERE Condition
    GROUP BY ColumnName
    ORDER BY ColumnName;
------------------------------------------
*/

-- Example of using COUNT to count the number of employees in each department
SELECT
    DepartmentID,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;

-- Example of using SUM to calculate the total salary for each department
SELECT
    DepartmentID,
    SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID;

-- Example of using AVG to calculate the average salary for each department
SELECT
    DepartmentID,
    AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DepartmentID;

-- Example of using MIN to find the minimum salary in each department
SELECT
    DepartmentID,
    MIN(Salary) AS MinimumSalary
FROM Employees
GROUP BY DepartmentID;

-- Example of using MAX to find the maximum salary in each department
SELECT
    DepartmentID,
    MAX(Salary) AS MaximumSalary
FROM Employees
GROUP BY DepartmentID;

-- Example of using COUNT to count the total number of employees in the company
SELECT COUNT(*) AS TotalEmployees
FROM Employees;

-- Example of using SUM to calculate the total salary expense for the company
SELECT SUM(Salary) AS TotalSalaryExpense
FROM Employees;

-- Example of using AVG to calculate the average salary across the company
SELECT AVG(Salary) AS AverageCompanySalary
FROM Employees;

-- Example of using MIN to find the minimum salary in the company
SELECT MIN(Salary) AS MinimumCompanySalary
FROM Employees;

-- Example of using MAX to find the maximum salary in the company
SELECT MAX(Salary) AS MaximumCompanySalary
FROM Employees;


---------------------------------------------------------------------------
-- Aggregates with WHERE (Filtering Before Aggregation)
---------------------------------------------------------------------------

-- Example: Calculate the average salary for employees in the IT department (DepartmentID = 3)
SELECT AVG(Salary) AS AverageITSalary
FROM Employees
WHERE DepartmentID = 3;

-- Example: Count the number of employees hired after January 1, 2015
SELECT COUNT(*) AS EmployeesHiredAfter2015
FROM Employees
WHERE HireDate > '2015-01-01';


-- Aggregating Expressions
-----------------------------
-- (e.g. Calculate the total salary expense for employees in the IT department (DepartmentID = 3) 
--  with a 10% bonus)
SELECT SUM(Salary * 1.10) AS TotalITSalaryWithBonus
FROM Employees
WHERE DepartmentID = 3;




