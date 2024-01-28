CREATE OR ALTER FUNCTION fun_multi(@date datetime)
RETURNS @orderDetail TABLE
(
   ProductID INT,
   SalesOrderID INT,
   SalesOrderNumber nvarchar(30),
   CustomerID INT,
   AccountNumber nvarchar(30),
   OrderDate datetime
)
AS
BEGIN
   INSERT INTO @orderDetail
   select sod.ProductID,
          soh.SalesOrderID,
          soh.SalesOrderNumber,
          soh.CustomerID,
          soh.AccountNumber,
          soh.OrderDate
   FROM Sales.SalesOrderHeader soh
   JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
   WHERE  YEAR(soh.OrderDate) = YEAR(@date)

   RETURN
END
GO

SELECT 
	c.CustomerID, COUNT(*) 
FROM  Sales.Customer c 
INNER JOIN dbo.fun_multi('2014-01-01') fun ON c.CustomerID = fun.CustomerID
GROUP BY c.CustomerID

