CREATE OR ALTER PROCEDURE Sales.usp_UpdateShopOrder
  @Id INT NULL OUT,
  @ClientID INT NULL,
  @OrderDate DATETIME2 NULL,
  @OrderNote NVARCHAR(MAX) NULL
AS
BEGIN
  IF @Id IS NULL
  BEGIN
	INSERT INTO Sales.ShopOrder(ClientID, OrderDate, OrderNote)
	  VALUES (@ClientID, @OrderDate, @OrderNote)
	SET @Id = SCOPE_IDENTITY()
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
DECLARE @Id INT = NULL;

BEGIN TRY
   EXEC Sales.usp_UpdateShopOrder @Id = @Id OUT, 
                  @ClientId = 16, 
                  @OrderDate = @date, 
				  @OrderNote = 'Please pack in a cardboard box';

				  SELECT @Id AS 'Id of newly created record';
END TRY
BEGIN CATCH
   PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH
GO

