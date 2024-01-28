CREATE TYPE MemShopOrders AS TABLE (
 ClientId INT,
 OrderDate DATETIME2,
 OrderNote OrderNote
 );
 GO

 CREATE OR ALTER  PROCEDURE Sales.InsertMultiOrders @OrdersTab MemShopOrders READONLY
 AS
 BEGIN
   INSERT INTO Sales.ShopOrder (ClientId, OrderDate, OrderNote)
   SELECT ClientId, OrderDate, OrderNote FROM @OrdersTab;
 END;
 GO

 DECLARE @tab MemShopOrders;
 INSERT INTO @tab(ClientId, OrderDate, OrderNote) 
   VALUES  (20, SYSDATETIME(), 'black and white please'),
         (21, SYSDATETIME(), '');
 UPDATE @tab SET OrderNote = 'only black and white please' WHERE ClientId = 20;
 INSERT INTO @tab(ClientId, OrderDate, OrderNote) 
   VALUES  (22, SYSDATETIME(), 'Leave the package in the bakery shop, I''m on a trip.');

EXEC SAles.InsertMultiOrders @tab;

SELECT * FROM Sales.ShopOrder;
