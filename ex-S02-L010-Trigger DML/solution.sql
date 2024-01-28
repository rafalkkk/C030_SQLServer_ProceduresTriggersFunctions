CREATE TABLE dbo.app_log
([ID] INT IDENTITY PRIMARY KEY,
 [WHO] SYSNAME DEFAULT SUSER_SNAME(),
 [WHEN] DATETIME2 DEFAULT SYSDATETIME(),
 [TABLE] SYSNAME,
 [OPERATION] VARCHAR(10));
 GO

 CREATE OR ALTER TRIGGER Sales.tr_shoporder_insert ON Sales.ShopOrder
 FOR INSERT
 AS
 BEGIN
	INSERT INTO dbo.app_log([TABLE], [OPERATION]) VALUES ('ShopOrder', 'INSERT');
 END;
 GO

 INSERT INTO Sales.ShopOrder(ClientId, OrderDate, OrderNote) VALUES (20, SYSDATETIME(), 'Test insert');
 SELECT * FROM Sales.ShopOrder;
 SELECT * FROM dbo.app_log;
 GO

 CREATE OR ALTER TRIGGER Sales.tr_shoporder_update ON Sales.ShopOrder
 FOR UPDATE
 AS
 BEGIN
	INSERT INTO dbo.app_log([TABLE], [OPERATION]) VALUES ('ShopOrder', 'UPDATE');
 END;
 GO

 UPDATE Sales.ShopOrder SET OrderDate=SYSDATETIME() WHERE Id = 1005;
 SELECT * FROM Sales.ShopOrder;
 SELECT * FROM dbo.app_log;
 GO

 CREATE TRIGGER Sales.tr_shoporder_delete ON Sales.ShopOrder
 FOR DELETE
 AS
 BEGIN
	INSERT INTO dbo.app_log([TABLE], [OPERATION]) VALUES ('ShopOrder', 'DELETE');
 END;
 GO

 DELETE FROM Sales.ShopOrder  WHERE Id = 1005;
 SELECT * FROM Sales.ShopOrder;
 SELECT * FROM dbo.app_log;
 GO

 DROP TRIGGER IF EXISTS Sales.tr_shoporder_insert;
 DROP TRIGGER IF EXISTS Sales.tr_shoporder_update;
 DROP TRIGGER IF EXISTS Sales.tr_shoporder_delete;