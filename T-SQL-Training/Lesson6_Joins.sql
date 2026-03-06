/*
-----------------------------------------------------------------
LESSON 6: INNER & OUTER JOINS
-----------------------------------------------------------------
- Data is split across multiple tables
- Joins let you combine related information

In this lesson, we will cover the following topics: 
    - INNER JOIN: Returns only the rows that have matching values in both tables

    - LEFT OUTER JOIN: Returns all rows from the left table and the matched rows from the right table; 
        if there is no match, the result is NULL on the right side

    - RIGHT OUTER JOIN: Returns all rows from the right table and the matched rows from the left table; 
        if there is no match, the result is NULL on the left side

    - FULL OUTER JOIN: Returns all rows when there is a match in either left or right table; 
        if there is no match, the result is NULL on the side that does not have a match

    - CROSS JOIN: Returns the Cartesian product of the two tables, meaning it returns all 
        possible combinations of rows from both tables

    - SELF JOIN: A join where a table is joined with itself to compare rows within the same table

    - GROUP BY
    - HAVING

Why Joins:
----------
- Joins are used to combine rows from two or more tables based on a related column between them.
- They allow you to retrieve data from multiple tables in a single query, which is essential 
    for relational databases where data is often normalized across multiple tables.
- Joins help to establish relationships between tables and enable complex queries that 
    can analyze and report on data across those tables.
- They are fundamental for performing operations like filtering, aggregating, 
    and summarizing data from multiple sources.

Example Scenario:
-----------------
- Consider a database with two tables: Customers and Orders. The Customers table contains 
    information about customers, while the Orders table contains information about their orders.
- To retrieve a list of customers along with their orders, you would use a JOIN to combine 
    the data from both tables based on a common column, such as CustomerID.

- Who bought what and when? 
    - INNER JOIN: Get customers who have made orders
    - LEFT OUTER JOIN: Get all customers and their orders (if any)
    - RIGHT OUTER JOIN: Get all orders and the customers who made them (if any)
    - FULL OUTER JOIN: Get all customers and all orders, matching where possible
    - CROSS JOIN: Get all combinations of customers and orders
    - SELF JOIN: Get pairs of customers who live in the same city
    - USING JOIN: Join tables based on a common column without specifying the join condition
    - NATURAL JOIN: Join tables based on columns with the same name and compatible data types

- Employee with their department details
    - INNER JOIN: Get employees who are assigned to a department
    - LEFT OUTER JOIN: Get all employees and their department details (if assigned)
    - RIGHT OUTER JOIN: Get all departments and the employees assigned to them (if any)
    - FULL OUTER JOIN: Get all employees and all departments, matching where possible
    - CROSS JOIN: Get all combinations of employees and departments
    - SELF JOIN: Get pairs of employees who work in the same department
    - USING JOIN: Join tables based on a common column without specifying the join condition
    - NATURAL JOIN: Join tables based on columns with the same name and compatible data types

- Drugs and their manufacturers
    - INNER JOIN: Get drugs that have a manufacturer
    - LEFT OUTER JOIN: Get all drugs and their manufacturer details (if available)
    - RIGHT OUTER JOIN: Get all manufacturers and the drugs they produce (if any)
    - FULL OUTER JOIN: Get all drugs and all manufacturers, matching where possible
    - CROSS JOIN: Get all combinations of drugs and manufacturers
    - SELF JOIN: Get pairs of drugs that are produced by the same manufacturer
--------------------------------------------------------------------------------

Syntax of Joins:
-------------
- INNER JOIN: 
    SELECT columns 
    FROM table1 
    INNER JOIN table2 
    ON table1.common_column = table2.common_column;

- LEFT OUTER JOIN: 
    SELECT columns 
    FROM table1 
    LEFT OUTER JOIN table2 
    ON table1.common_column = table2.common_column;

- RIGHT OUTER JOIN: 
    SELECT columns 
    FROM table1 
    RIGHT OUTER JOIN table2 
    ON table1.common_column = table2.common_column;

- FULL OUTER JOIN: 
    SELECT columns 
    FROM table1 
    FULL OUTER JOIN table2 
    ON table1.common_column = table2.common_column;

- CROSS JOIN: 
    SELECT columns 
    FROM table1 
    CROSS JOIN table2;

- SELF JOIN: 
    SELECT columns 
    FROM table1 AS alias1 
    JOIN table1 AS alias2 
    ON alias1.common_column = alias2.common_column;
*/

--------------------------------
-- Initial Setup
--------------------------------
/* Setup of tables to use for this lesson */

-- Create Customers table
CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

-- Create Orders table
CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Product VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Departments table
CREATE TABLE Departments
(
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

-- Create Employees table
CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- Create Manufacturers table
CREATE TABLE Manufacturers
(
    ManufacturerID INT PRIMARY KEY,
    ManufacturerName VARCHAR(50)
);

-- Create Drugs table
CREATE TABLE Drugs
(
    DrugID INT PRIMARY KEY,
    DrugName VARCHAR(50),
    ManufacturerID INT,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID)
);

-- Insert sample data into Customers
INSERT INTO Customers
    (CustomerID, CustomerName, City)
VALUES
    (1, 'Wale', 'Sokoto'),
    (2, 'Bimbo', 'Abuja'),
    (3, 'Dayo', 'Ibadan'),
    (4, 'David', 'Osogbo');

-- Insert sample data into Orders
INSERT INTO Orders
    (OrderID, CustomerID, OrderDate, Product)
VALUES
    (1, 1, '2023-01-01', 'Laptop'),
    (2, 2, '2023-01-02', 'Phone'),
    (3, 1, '2023-01-03', 'Tablet'),
    (4, 4, '2023-01-04', 'Mouse');

-- Insert sample data into Departments
INSERT INTO Departments
    (DeptID, DeptName)
VALUES
    (1, 'HR'),
    (2, 'IT'),
    (3, 'Finance'),
    (4, 'Marketing');

-- Insert sample data into Employees
INSERT INTO Employees
    (EmpID, EmpName, DeptID)
VALUES
    (1, 'Eve', 1),
    (2, 'Frank', 2),
    (3, 'Grace', 2),
    (4, 'Heidi', NULL),
    -- No department
    (5, 'Ivan', 3);

-- Insert sample data into Manufacturers
INSERT INTO Manufacturers
    (ManufacturerID, ManufacturerName)
VALUES
    (1, 'PharmaCorp'),
    (2, 'MediLabs'),
    (3, 'HealthInc');

-- Insert sample data into Drugs
INSERT INTO Drugs
    (DrugID, DrugName, ManufacturerID)
VALUES
    (1, 'Aspirin', 1),
    (2, 'Ibuprofen', 1),
    (3, 'Paracetamol', 2),
    (4, 'Vitamin C', NULL);
-- No manufacturer


--------------------------------
-- INNER JOIN
--------------------------------

-- INNER JOIN: Returns only the rows that have matching values in both tables

-- Example 1: Who bought what and when? Get customers who have made orders
SELECT C.CustomerName, O.Product, O.OrderDate
FROM Customers C
    INNER JOIN Orders O ON C.CustomerID = O.CustomerID;

-- Example 2: Employee with their department details - Get employees who are assigned to a department
SELECT E.EmpName, D.DeptName
FROM Employees E
    INNER JOIN Departments D ON E.DeptID = D.DeptID;

-- Example 3: Drugs and their manufacturers - Get drugs that have a manufacturer
SELECT D.DrugName, M.ManufacturerName
FROM Drugs D
    INNER JOIN Manufacturers M ON D.ManufacturerID = M.ManufacturerID;


--------------------------------
-- LEFT JOIN / LEFT OUTER JOIN
--------------------------------

-- LEFT OUTER JOIN: Returns all rows from the left table and the matched rows 
-- from the right table; if there is no match, the result is NULL on the right side

-- Example 1: Who bought what and when? Get all customers and their orders (if any)
SELECT C.CustomerName, O.Product, O.OrderDate
FROM Customers C
    LEFT OUTER JOIN Orders O ON C.CustomerID = O.CustomerID;

-- Example 2: Employee with their department details - Get all employees and their 
-- department details (if assigned)
SELECT E.EmpName, D.DeptName
FROM Employees E
    LEFT OUTER JOIN Departments D ON E.DeptID = D.DeptID;

-- Example 3: Drugs and their manufacturers - Get all drugs and their manufacturer details (if available)
SELECT D.DrugName, M.ManufacturerName
FROM Drugs D
    LEFT OUTER JOIN Manufacturers M ON D.ManufacturerID = M.ManufacturerID;



--------------------------------
-- RIGHT JOIN / RIGHT OUTER JOIN
--------------------------------

-- RIGHT OUTER JOIN: Returns all rows from the right table and the matched rows
-- from the left table; if there is no match, the result is NULL on the left side

-- Example 1: Who bought what and when? Get all orders and the customers who made them (if any)
SELECT C.CustomerName, O.Product, O.OrderDate
FROM Customers C
    RIGHT OUTER JOIN Orders O ON C.CustomerID = O.CustomerID;

-- Example 2: Employee with their department details - Get all departments and the 
-- employees assigned to them (if any)
SELECT E.EmpName, D.DeptName
FROM Employees E
    RIGHT OUTER JOIN Departments D ON E.DeptID = D.DeptID;

-- Example 3: Drugs and their manufacturers - Get all manufacturers and the drugs they produce (if any)
SELECT D.DrugName, M.ManufacturerName
FROM Drugs D
    RIGHT OUTER JOIN Manufacturers M ON D.ManufacturerID = M.ManufacturerID;


--------------------------------
-- FULL OUTER JOIN
--------------------------------

-- FULL OUTER JOIN: Returns all rows when there is a match in either left or right table; 
-- if there is no match, the result is NULL on the side that does not have a match

-- Example 1: Who bought what and when? Get all customers and all orders, matching where possible
SELECT C.CustomerName, O.Product, O.OrderDate
FROM Customers C
    FULL OUTER JOIN Orders O ON C.CustomerID = O.CustomerID;

-- Example 2: Employee with their department details - Get all employees and all departments, matching where possible
SELECT E.EmpName, D.DeptName
FROM Employees E
    FULL OUTER JOIN Departments D ON E.DeptID = D.DeptID;

-- Example 3: Drugs and their manufacturers - Get all drugs and all manufacturers, matching where possible
SELECT D.DrugName, M.ManufacturerName
FROM Drugs D
    FULL OUTER JOIN Manufacturers M ON D.ManufacturerID = M.ManufacturerID;




--------------------------------
-- CROSS JOIN
--------------------------------

-- CROSS JOIN: Returns the Cartesian product of the two tables, meaning it returns 
-- all possible combinations of rows from both tables

-- Example 1: Who bought what and when? Get all combinations of customers and orders
SELECT C.CustomerName, O.Product, O.OrderDate
FROM Customers C
CROSS JOIN Orders O;

-- Example 2: Employee with their department details - Get all combinations of employees and departments
SELECT E.EmpName, D.DeptName
FROM Employees E
CROSS JOIN Departments D;

-- Example 3: Drugs and their manufacturers - Get all combinations of drugs and manufacturers
SELECT D.DrugName, M.ManufacturerName
FROM Drugs D
CROSS JOIN Manufacturers M;




--------------------------------
-- SELF JOIN
--------------------------------

-- SELF JOIN: A join where a table is joined with itself to compare rows within the same table

-- Example 1: Who bought what and when? Get pairs of customers who live in the same city
SELECT C1.CustomerName AS Customer1, C2.CustomerName AS Customer2, C1.City
FROM Customers C1
    INNER JOIN Customers C2 ON C1.City = C2.City AND C1.CustomerID < C2.CustomerID;

-- Example 2: Employee with their department details - Get pairs of employees who work in the same department
SELECT E1.EmpName AS Employee1, E2.EmpName AS Employee2, D.DeptName
FROM Employees E1
    INNER JOIN Employees E2 ON E1.DeptID = E2.DeptID AND E1.EmpID < E2.EmpID
    INNER JOIN Departments D ON E1.DeptID = D.DeptID;

-- Example 3: Drugs and their manufacturers - Get pairs of drugs that are produced by the same manufacturer
SELECT D1.DrugName AS Drug1, D2.DrugName AS Drug2, M.ManufacturerName
FROM Drugs D1
    INNER JOIN Drugs D2 ON D1.ManufacturerID = D2.ManufacturerID AND D1.DrugID < D2.DrugID
    INNER JOIN Manufacturers M ON D1.ManufacturerID = M.ManufacturerID;

