---------------------------------------------------------------------
-- HAVING Clause for filtering groups based on aggregate functions --
---------------------------------------------------------------------
-- HAVING [Aggregate Function] {comparison operator} [filtering criteria]
-- WHERE filters rows based on column values, while HAVING filters GROUPS based on aggregate functions

SELECT 
    ST.Name AS [Territory Name],
    SUM(TotalDue) AS [Total Sales - 2011]
FROM Sales.SalesOrderHeader SOH
INNER JOIN Sales.SalesTerritory ST
ON SOH.TerritoryID = ST.TerritoryID
WHERE OrderDate BETWEEN '1/1/2011' AND '12/31/2011'
GROUP BY ST.Name
HAVING SUM(TotalDue) > 1000000
ORDER BY 1;

-- Find departments with at least 8 people working there
SELECT *
FROM HumanResources.vEmployeeDepartment;

SELECT 
    Department,
    COUNT(*) AS [Total Employees]
FROM HumanResources.vEmployeeDepartment
GROUP BY Department
HAVING COUNT(*) > 10
ORDER BY [Total Employees] DESC;

SELECT
    SalesPersonID,
    SUM(TotalDue) AS [Total Sales Amount],
    COUNT(*) AS [Total Sales Count]
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '1/1/2011' AND '12/31/2011'
    AND SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
HAVING SUM(TotalDue) > 200000
    AND Count(*) > 20
ORDER BY [Total Sales Amount] DESC;

-----------------------
-- Practice Problems --
-----------------------
/*
#1
Find the total sales by territory for all rows in the Sales.SalesOrderHeader table.
Return only those territories that have exceeded $10 million in historical sales.
Return the total sales and the TerritoryID column.
*/

SELECT
    TerritoryID,
    SUM(TotalDue) AS [Total Sales]
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID
HAVING SUM(TotalDue) > 10000000
ORDER BY 2 DESC;

/*
#2
Using the query from the previous question, join to the Sales.SalesTerritory table and replace the TerritoryID column with the territory’s name.
*/

SELECT
    ST.Name,
    SUM(SOH.TotalDue) AS [Total Sales]
FROM Sales.SalesOrderHeader SOH
    INNER JOIN Sales.SalesTerritory ST
    ON SOH.TerritoryID = ST.TerritoryID
GROUP BY ST.Name
HAVING SUM(TotalDue) > 10000000
ORDER BY 2 DESC;

/*
#3
Using the Production.Product table, find how many products are associated with each color.
Ignore all rows where the color has a NULL value.
Once grouped, return only those colors that had at least 20 products with that color.
*/

SELECT 
    Color,
    COUNT(*) AS [Total]
FROM Production.Product
WHERE Color IS NOT NULL
GROUP BY Color
HAVING COUNT(*) >= 20
ORDER BY 2 DESC;

/*
#4
Starting with the Sales.SalesOrderHeader table, join to the Sales.SalesOrderDetail table.
This table contains the line-item details associated with each sale.

From Sales.SalesOrderDetail, join to the Production.Product table.
Return the Name column from Production.Product and assign it the column alias “Product Name”.

For each product, find out how many of each product was ordered for all orders that occurred in 2011.
Only output those products where at least 200 were ordered.
*/

SELECT 
    P.Name AS [Production Name],
    COUNT(*) AS [Total]
FROM 
    Sales.SalesOrderHeader SOH
    INNER JOIN Sales.SalesOrderDetail SOD
    ON SOH.SalesOrderID = SOD.SalesOrderID
    INNER JOIN Production.Product P
    ON SOD.ProductID = P.ProductID
WHERE 
    OrderDate BETWEEN '1/1/2011' AND '12/31/2011'
GROUP BY 
    P.Name
HAVING
    COUNT(*) >= 200
ORDER BY
    2 DESC;

/*
#5
Find the first and last name of each customer who has placed at least 6 orders between July 1, 2011 and December 31, 2012.
Order your results by the number of orders placed in descending order.

Hint: You will need to join three tables:
Sales.SalesOrderHeader
Sales.Customer
Person.Person
You will use every clause to complete this query.
*/

SELECT
    P.FirstName + ' ' + P.LastName AS [Customer Full Name],
    COUNT(*) AS [Total Purchases]
FROM
    Sales.SalesOrderHeader SOH
    INNER JOIN Sales.Customer C
    ON C.CustomerID = SOH.CustomerID
    INNER JOIN Person.Person P
    ON C.PersonID = P.BusinessEntityID
WHERE 
    OrderDate BETWEEN '7/1/2011' AND '12/31/2012'
GROUP BY 
    P.FirstName + ' ' + P.LastName
HAVING
    COUNT(*) >= 6
ORDER BY 2 DESC;