--------------------------------------------
-- ORDER BY clause for Sorting result set --
--------------------------------------------
-- ORDER BY ColumnName, ColumnOrdinal, ColumnAlias [ASC/DESC] - ASC is default

-- ColumnName ORDER BY
SELECT FirstName, LastName
FROM Sales.vIndividualCustomer
ORDER BY FirstName DESC;

-- ColumnOrdinal ORDER BY
SELECT FirstName, LastName
FROM Sales.vIndividualCustomer
ORDER BY 1;

-- ColumnAlias ORDER BY
SELECT FirstName, LastName AS 'Customer Last Name'
FROM Sales.vIndividualCustomer
ORDER BY 'Customer Last Name' DESC;

/*
How we order our 6 Clauses for SQL Queries:
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY

The order SQL processes these:
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
*/

-- This will sort LastName in ASC order first, then FirstName in DESC order for LastName ties.
SELECT FirstName, LastName
FROM Sales.vIndividualCustomer
ORDER BY LastName, FirstName DESC;

SELECT LastName, FirstName, SalesQuota
FROM Sales.vSalesPerson
WHERE SalesQuota >= 25000
ORDER BY SalesQuota DESC, LastName ASC;

-----------------------
-- Practice Problems --
-----------------------
-- #1 From the HumanResources.vEmployeeDepartment view, return the FirstName, LastName, and JobTitle columns. Sort the results by the FirstName column in ascending order.
SELECT FirstName, LastName, JobTitle
FROM HumanResources.vEmployeeDepartment
ORDER BY FirstName;

-- #2 Modify the query from question 1 to sort the results by: FirstName in ascending order, and then LastName in descending order.
SELECT FirstName, LastName, JobTitle
FROM HumanResources.vEmployeeDepartment
ORDER BY FirstName, LastName DESC;

-- #3 From the Sales.vIndividualCustomer view, return the FirstName, LastName, and CountryRegionName columns. Sort the results by the CountryRegionName column using the column ordinal in the ORDER BY clause.
SELECT FirstName, LastName, CountryRegionName
FROM Sales.vIndividualCustomer
ORDER BY 3;

-- #4 From the Sales.vIndividualCustomer view, return the FirstName, LastName, and CountryRegionName columns for rows where the CountryRegionName is either "United States" or "France". Sort the results by the CountryRegionName column in ascending order.
SELECT FirstName, LastName, CountryRegionName
FROM Sales.vIndividualCustomer
WHERE CountryRegionName IN ('United States', 'France')
ORDER BY 3;

-- #5 From the Sales.vStoreWithDemographics view, return the following columns: Name AnnualSale YearOpened SquareFeet (alias as "Store Size") NumberEmployees (alias as "Total Employees") Return only rows where: AnnualSales > 1,000,000 NumberEmployees ≥ 45 Order the results by: Store Size in descending order, then Total Employees in descending order.
SELECT AnnualSales, YearOpened, SquareFeet AS 'Store Size', NumberEmployees AS 'Total Employees'
FROM Sales.vStoreWithDemographics
WHERE AnnualSales > 1000000 AND NumberEmployees >= 45
ORDER BY 'Store Size' DESC, 'Total Employees' DESC;