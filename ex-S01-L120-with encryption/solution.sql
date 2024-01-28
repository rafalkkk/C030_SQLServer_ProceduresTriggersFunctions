DECLARE @sql NVARCHAR(MAX) ;
SELECT @sql=OBJECT_DEFINITION(object_id)
	FROM   sys.procedures
	WHERE  name = 'InsertMultiOrders' AND schema_id = SCHEMA_ID('Sales');
PRINT @sql;
GO

CREATE OR ALTER  PROCEDURE Sales.InsertMultiOrders_enc @OrdersTab MemShopOrders READONLY
WITH ENCRYPTION
AS
BEGIN
   INSERT INTO Sales.ShopOrder (ClientId, OrderDate, OrderNote)
   SELECT ClientId, OrderDate, OrderNote FROM @OrdersTab;
END;
GO



DECLARE @sql NVARCHAR(MAX) ;
SELECT @sql=OBJECT_DEFINITION(object_id)
	FROM   sys.procedures
	WHERE  name = 'InsertMultiOrders_enc' AND schema_id = SCHEMA_ID('Sales');
PRINT @sql;
