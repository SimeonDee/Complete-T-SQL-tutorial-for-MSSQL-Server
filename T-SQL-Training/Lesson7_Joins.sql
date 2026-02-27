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

    - USING JOIN: A join that allows you to specify a common column to join on without needing 
        to use the ON clause
    - NATURAL JOIN: A join that automatically joins tables based on columns with the same name 
        and compatible data types
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
    - USING JOIN: Join tables based on a common column without specifying the join condition
    - NATURAL JOIN: Join tables based on columns with the same name and compatible data types
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

- USING JOIN: 
    SELECT columns 
    FROM table1 
    JOIN table2 
    USING (common_column);

- NATURAL JOIN: 
    SELECT columns 
    FROM table1 
    NATURAL JOIN table2;
*/

