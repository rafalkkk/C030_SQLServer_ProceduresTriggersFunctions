CREATE TABLE Sales.ShopOrder
(
  Id INT IDENTITY PRIMARY KEY,
  ClientId INT NOT NULL REFERENCES Person.Person(BusinessEntityId),
  OrderDate DATETIME2 DEFAULT SYSDATETIME(),
  OrderNote NVARCHAR(MAX) NULL
)
GO

CREATE PROCEDURE Sales.usp_UpdateShopOrder
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
    UPDATE Sales.ShopOrder 
	  SET ClientId = @ClientID, OrderDate = @OrderDate, OrderNote = @OrderNote
	  WHERE Id = @Id
  END
END
GO

DECLARE @date DATETIME2;
SET @date = SYSDATETIME();
EXEC Sales.usp_UpdateShopOrder @Id = NULL, 
                  @ClientId = 16, 
                  @OrderDate = @date, 
				  @OrderNote = 'Please pack in a cardboard box';
GO

SELECT * FROM Sales.ShopOrder;
GO

DECLARE @date DATETIME2;
SET @date = SYSDATETIME();
EXEC Sales.usp_UpdateShopOrder @Id = 1, 
                  @ClientId = 16, 
                  @OrderDate = @date, 
				  @OrderNote = 'Please pack in a green cardboard box';
GO

SELECT * FROM Sales.ShopOrder;
GO