CREATE TABLE dbo.Products(
  Id INT IDENTITY PRIMARY KEY,
  Name NVARCHAR(100),
  TotalAmount INT DEFAULT 0);
GO
CREATE TABLE dbo.Transactions(
  Id INT IDENTITY PRIMARY KEY,
  ProductId INT NOT NULL REFERENCES dbo.Products(Id),
  RecordType CHAR(1),  -- 'S' - product Sold / 'B' - product Bought
  Amount INT NOT NULL DEFAULT 0,
  CONSTRAINT ProductId_Id UNIQUE(ProductId, Id));
GO
INSERT INTO dbo.Products(Name) VALUES('Apples'),('Oranges'),('Lemons');
GO

CREATE OR ALTER TRIGGER tr_insert_transaction ON dbo.Transactions FOR INSERT 
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT COUNT(*) FROM inserted GROUP BY ProductId HAVING COUNT(*) > 1)
		THROW 50001, 'ONE TRANSACTION CAN UPDATE A PRODUCT ONLY ONCE',1;

	-- add Amount to TotalAmount if the record type is B (Buy)
	UPDATE p
	  SET TotalAmount += i.Amount
	FROM dbo.Products AS p
	JOIN inserted i ON p.Id = i.ProductId
	WHERE i.RecordType = 'B';
	-- substract Amount from TotalAmount if the record type is S (Sell)
	UPDATE p
	  SET TotalAmount -= i.Amount
	FROM dbo.Products AS p
	JOIN inserted i ON p.Id = i.ProductId
	WHERE i.RecordType = 'S';
END;
GO

INSERT INTO dbo.Transactions(ProductId, RecordType, Amount) VALUES (1, 'B',  100),(2, 'B', 200),(3, 'B', 300);
SELECT * FROM dbo.Products

INSERT INTO dbo.Transactions(ProductId, RecordType, Amount) VALUES (1, 'S', 10), (2, 'S', 20), (3, 'B', 300);
SELECT * FROM dbo.Products
GO
