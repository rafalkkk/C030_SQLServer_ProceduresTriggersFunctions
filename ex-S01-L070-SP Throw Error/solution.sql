CREATE OR ALTER PROCEDURE Sales.usp_UpdateShopOrder
  @Id INT NULL,
  @ClientID INT NULL,
  @OrderDate DATETIME2 NULL,
  @OrderNote NVARCHAR(MAX) NULL
AS
BEGIN
  IF @Id IS NULL
  BEGIN
	INSERT INTO Sales.ShopOrder(ClientID, OrderDate, OrderNote)
	  VALUES (@ClientID, @OrderDate, @OrderNote)
  END
  ELSE
  BEGIN
    IF EXISTS(SELECT * FROM Sales.ShopOrder WHERE Id=@id)
	BEGIN
      UPDATE Sales.ShopOrder 
	    SET ClientId = @ClientID, OrderDate = @OrderDate, OrderNote = @OrderNote
	    WHERE Id = @Id
	END
	ELSE
	  THROW 50001, 'Modification of non-existing order', 1;
  END
END
GO

DECLARE @date DATETIME2;
SET @date = SYSDATETIME();
BEGIN TRY
   EXEC Sales.usp_UpdateShopOrder @Id = 1111, 
                  @ClientId = 16, 
                  @OrderDate = @date, 
				  @OrderNote = 'Please pack in a cardboard box';
END TRY
BEGIN CATCH
   PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH
GO

