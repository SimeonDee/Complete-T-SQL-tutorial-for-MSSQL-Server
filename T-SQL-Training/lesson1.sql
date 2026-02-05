/*
------------------------------------------
== Lesson 1: T-SQL Concepts and Data Structure ==
------------------------------------------


1. T-SQL Concepts ✅
------------------------------------------

- SQL and its variants (Oracle SQL, MySQL SQL, PostgreSQL SQL, etc) ✅
- T-SQL Features (variables, control flow logic [if, while, etc], 
    error-handling [TRY...CATCH]) ✅
- Query Command Categories Overview (DDL, DML, SQL, DCL, TCL) ✅
- Importing Flat Files (CSV, TXT, etc) into SQL Server ✅
- Importing Excel Files into SQL Server ✅
- Importing Data from Other Databases (e.g., Oracle, MySQL, etc) into SQL Server ✅


2. Data Structure and Types
- Database Objects (Tables, views, stored procedures, functions, etc) ✅
- Tables, columns, rows, schemas and naming convention)  ✅
- SQL Server Data Types ✅ (We stopped here, but we will cover more data types in the next lesson)
- Null Concepts
- Constraints
(NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, IDENTITY, etc) 
*/


-- T-SQL Query command categories
-- DDL (Data Definition Language)
-- Examples: CREATE, ALTER, DROP, TRUNCATE
CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Salary DECIMAL(18, 2)
);

-- DML (Data Manipulation Language)
-- Examples: SELECT, INSERT, UPDATE, DELETE, MERGE
INSERT INTO Employees
    (EmployeeID, FirstName, LastName, BirthDate, HireDate, Salary)
VALUES
    (1, 'Kunle', 'Badejo', '1980-01-01', '2005-06-15', 60000.00);

-- SQL (Data Query Language)
-- Examples: SELECT, WHERE, ORDER BY, GROUP BY, HAVING, etc
SELECT *
FROM Employees;

-- DCL (Data Control Language)
-- Examples: GRANT, REVOKE, DENY
GRANT SELECT ON Employees TO User1;

-- TCL (Transaction Control Language)
-- Examples: BEGIN TRANSACTION, COMMIT, ROLLBACK, SAVEPOINT, etc
BEGIN TRANSACTION;
UPDATE Employees SET Salary = Salary * 1.10 WHERE EmployeeID = 1;
COMMIT TRANSACTION;

