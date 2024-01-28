CREATE OR ALTER FUNCTION dbo.GetOrderValue(@OrderQty SMALLINT, @UnitPrice MONEY, @UnitPriceDiscount MONEY)
RETURNS MONEY
AS
BEGIN
	RETURN @OrderQty * (@UnitPrice - @UnitPriceDiscount);
END
GO

SELECT dbo.GetOrderValue(OrderQty, UnitPrice, UnitPriceDiscount), * FROM Sales.SalesOrderDetail;

ALTER TABLE Sales.SalesOrderDetail ADD OrderValue AS dbo.GetOrderValue(OrderQty, UnitPrice, UnitPriceDiscount) PERSISTED;
-- Use to drop the column if you would like to start over again
-- ALTER TABLE Sales.SalesOrderDetail DROP COLUMN OrderValue
GO

CREATE OR ALTER FUNCTION dbo.GetOrderValue(@OrderQty SMALLINT, @UnitPrice MONEY, @UnitPriceDiscount MONEY)
RETURNS MONEY
WITH SCHEMABINDING
AS
BEGIN
	RETURN @OrderQty * (@UnitPrice - @UnitPriceDiscount);
END
GO

ALTER TABLE Sales.SalesOrderDetail ADD OrderValue AS dbo.GetOrderValue(OrderQty, UnitPrice, UnitPriceDiscount) PERSISTED;

SELECT * FROM Sales.SalesOrderDetail;

ALTER TABLE Sales.SalesOrderDetail DROP COLUMN OrderValue;