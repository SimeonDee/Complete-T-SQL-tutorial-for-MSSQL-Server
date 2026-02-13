----------------------------
-- GROUP BY & HAVING
----------------------------
/*
------------------------------------------------------
- Group data using GROUP BY
- Apply aggregate functions per group
- Understand GROUP BY rules
- Filter aggregated results using HAVING
- Build meaningful summary reports
------------------------------------------------------

Use Cases:
-------------------------------
- Summary for the entire table
- Summaries per category or group

Examples:
--------
    - Calculate total sales per product or customer
    - Count number of orders per region
    - Find average salary per department
    - Identify top-selling products
    - Analyze sales trends over time
    - Orders per country?


GROUP BY:
---------
    - Used to group rows that have the same values in specified columns
    - Often used with aggregate functions to perform calculations on each group
    - You must include all non-aggregated columns in the GROUP BY clause
    - Can group by multiple columns to create subgroups
    - NULL values are treated as a single group

HAVING:
-------
    - Used to filter groups based on aggregate conditions
    - Applied after GROUP BY to filter the aggregated results
    - Can use aggregate functions in the HAVING clause
    - Can also include non-aggregated columns in the HAVING clause
    - Multiple conditions can be combined using AND/OR in HAVING

Aggregate Functions Recap:
--------------------------
    - COUNT(column): Counts the number of non-NULL values in a column
    - SUM(column): Calculates the total sum of a numeric column
    - AVG(column): Calculates the average value of a numeric column
    - MIN(column): Finds the minimum value in a column
    - MAX(column): Finds the maximum value in a column
    - COUNT(*) counts all rows, including those with NULL values
    - SUM(column) ignores NULLs
    - AVG(column) ignores NULLs
*/

------------------------------------PRELIMINARY SETUP--------------------------------
-- Preliminary setup: Create sample Products table and insert data
CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

INSERT INTO Products
    (ProductID, ProductName, Category, Price)
VALUES
    (101, 'Laptop', 'Electronics', 1200.00),
    (102, 'Mouse', 'Electronics', 25.00),
    (103, 'Keyboard', 'Electronics', 45.00);

-- Preliminary setup: Create sample Customers table and insert data
CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Country VARCHAR(50)
);

INSERT INTO Customers
    (CustomerID, CustomerName, Country)
VALUES
    (1, 'Wale', 'USA'),
    (2, 'Bimbo', 'NGN'),
    (3, 'Charles', 'UK'),
    (4, 'Tunde', 'USA'),
    (5, 'Sola', 'NGN'),
    (6, 'Ayo', 'UK');


-- Preliminary setup: Create sample Sales table and insert data
CREATE TABLE Sales
(
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quatity INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales
    (SaleID, CustomerID, ProductID, Quatity, SalesAmount, SaleDate)
VALUES
    (1, 1, 101, 1, 1200.00, '2024-01-15'),
    (2, 2, 102, 2, 25.00, '2024-01-15'),
    (3, 3, 103, 3, 45.00, '2024-01-15'),
    (4, 1, 102, 4, 1200.00, '2024-01-16'),
    (5, 2, 101, 2, 2400.00, '2024-01-16'),
    (6, 3, 101, 1, 1200.00, '2024-01-17'),
    (7, 1, 103, 1, 45.00, '2024-01-17'),
    (8, 2, 103, 2, 90.00, '2024-01-17'),
    (9, 3, 102, 3, 75.00, '2024-01-17'),
    (10, 1, 101, 3, 3600.00, '2024-01-18'),
    (11, 2, 102, 1, 25.00, '2024-01-19'),
    (12, 3, 103, 2, 90.00, '2024-01-19'),
    (13, 4, 101, 1, 1200.00, '2024-01-20'),
    (14, 5, 102, 2, 25.00, '2024-01-21'),
    (15, 6, 103, 3, 45.00, '2024-01-21'),
    (16, 4, 102, 4, 1200.00, '2024-01-21'),
    (17, 5, 101, 2, 2400.00, '2024-01-22'),
    (18, 6, 101, 1, 1200.00, '2024-02-23'),
    (19, 4, 103, 1, 45.00, '2024-02-23'),
    (20, 5, 103, 2, 90.00, '2024-02-23'),
    (21, 6, 102, 3, 75.00, '2024-02-24'),
    (22, 4, 101, 3, 3600.00, '2024-02-24'),
    (23, 5, 102, 1, 25.00, '2024-02-25'),
    (24, 6, 103, 2, 90.00, '2024-02-26');

------------------------------------END OF PRELIMINARY SETUP--------------------------------

-----------------------------------
-- GROUP BY
------------------------------------
/*
    - Used to group rows that have the same values in specified columns
    - Often used with aggregate functions to perform calculations on each group
    - You must include all non-aggregated columns in the GROUP BY clause
    - Can group by multiple columns to create subgroups
    - NULL values are treated as a single group


Syntax for GROUP BY:
-------------------------------------------------------------------
    SELECT ColumnName, AggregateFunction(ColumnName) AS AliasName
    FROM TableName
    WHERE Condition
    GROUP BY ColumnName
    ORDER BY ColumnName;
-------------------------------------------------------------------
*/

-- Example of using GROUP BY to calculate total sales amount per product
SELECT
    ProductID,
    SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY ProductID
ORDER BY ProductID;

-- Example of using GROUP BY to calculate total sales amount per customer
SELECT
    CustomerID,
    SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
ORDER BY CustomerID;

-- Example of using GROUP BY to calculate average sales amount per product
SELECT
    ProductID,
    AVG(SalesAmount) AS AverageSales
FROM Sales
GROUP BY ProductID
ORDER BY ProductID;

-- Example of using GROUP BY to calculate average sales amount per customer
SELECT
    CustomerID,
    AVG(SalesAmount) AS AverageSales
FROM Sales
GROUP BY CustomerID
ORDER BY CustomerID;

-----------------------------------
-- HAVING
-----------------------------------
/*
    - Used to filter groups based on aggregate conditions
    - Applied after GROUP BY to filter the aggregated results
    - Can use aggregate functions in the HAVING clause
    - Can also include non-aggregated columns in the HAVING clause
    - Multiple conditions can be combined using AND/OR in HAVING


Syntax for HAVING:
-----------------------------------------------------------------------
    SELECT ColumnName, AggregateFunction(ColumnName) AS AliasName
    FROM TableName
    WHERE Condition
    GROUP BY ColumnName
    HAVING AggregateFunction(ColumnName) Condition
    ORDER BY ColumnName;
-----------------------------------------------------------------------
*/

-- Example of using HAVING to filter products with total sales greater than 5000
SELECT
    ProductID,
    SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY ProductID
HAVING SUM(SalesAmount) > 5000
ORDER BY ProductID;

-- Example of using HAVING to filter customers with average sales amount greater than 1000
SELECT
    CustomerID,
    AVG(SalesAmount) AS AverageSales
FROM Sales
GROUP BY CustomerID
HAVING AVG(SalesAmount) > 1000
ORDER BY CustomerID;

-- Example of using HAVING to filter products with sales count greater than 5
SELECT
    ProductID,
    COUNT(*) AS SalesCount
FROM Sales
GROUP BY ProductID
HAVING COUNT(*) > 5
ORDER BY ProductID;

-- Example of using HAVING to filter sales grouped by date with total sales greater than 2000
SELECT
    SaleDate,
    SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY SaleDate
HAVING SUM(SalesAmount) > 2000
ORDER BY SaleDate;


------------------------------------
-- HAVING VS WHERE:
------------------------------------
/*
    - WHERE filters rows before grouping, while HAVING filters groups after aggregation
    - WHERE is applied before GROUP BY, while HAVING is applied after GROUP BY
    - WHERE cannot use aggregate functions, while HAVING can
    - WHERE is used for row-level filtering, while HAVING is used for group-level filtering
    - You can use both WHERE and HAVING in the same query to filter rows and groups
*/

-- Example of using both WHERE and HAVING in the same query 
/* 
    - to filter sales for a specific date 
    - and then filter groups with total sales greater than 2000
*/
SELECT
    SaleDate,
    SUM(SalesAmount) AS TotalSales
FROM Sales
WHERE SaleDate >= '2024-01-17' AND SaleDate <= '2024-01-23'
GROUP BY SaleDate
HAVING SUM(SalesAmount) > 2000
ORDER BY SaleDate;


-- Example of using both WHERE and HAVING in the same query
/*
    - to filter sales for a specific date range
    - and then filter products with sales count greater than 5
*/
SELECT
    ProductID,
    COUNT(*) AS SalesCount
FROM Sales
WHERE SaleDate >= '2024-01-17' AND SaleDate <= '2024-01-23'
GROUP BY ProductID
HAVING COUNT(*) > 5
ORDER BY ProductID;

/*
Common Mistakes with GROUP BY and HAVING:
-----------------------------------------
    - Forgetting to include non-aggregated columns in the GROUP BY clause
    - Using WHERE instead of HAVING to filter aggregated results
    - Using aggregate functions in the WHERE clause instead of HAVING
    - Not understanding the order of execution (WHERE -> GROUP BY -> HAVING)
    - Mixing aggregated and non-aggregated columns without proper grouping  
    - Not handling NULL values correctly in GROUP BY
*/