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
	  RETURN -1
  END
  RETURN 0
END
GO

DECLARE @RC INT = 0;

DECLARE @date DATETIME2;
SET @date = SYSDATETIME();
EXEC @RC = Sales.usp_UpdateShopOrder @Id = 1, 
                  @ClientId = 16, 
                  @OrderDate = @date, 
				  @OrderNote = 'Please pack in a cardboard box';
SELECT @RC;
GO

DECLARE @RC INT = 0;

DECLARE @date DATETIME2;
SET @date = SYSDATETIME();
EXEC @RC = Sales.usp_UpdateShopOrder @Id = 1000, 
                  @ClientId = 16, 
                  @OrderDate = @date, 
				  @OrderNote = 'Please pack in a cardboard box';
SELECT @RC;
GO

