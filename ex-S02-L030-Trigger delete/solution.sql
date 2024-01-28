
CREATE OR ALTER TRIGGER tr_delete_transaction ON dbo.Transactions FOR DELETE 
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT COUNT(*) FROM deleted GROUP BY ProductId HAVING COUNT(*) > 1)
		THROW 50001, 'ONE TRANSACTION CAN UPDATE A PRODUCT ONLY ONCE',1;
	-- substract Amount from TotalAmount if the record type is B (Buy)
	UPDATE p
	  SET TotalAmount -= d.Amount
	FROM dbo.Products AS p
	JOIN deleted d ON p.Id = d.ProductId
	WHERE d.RecordType = 'B';
	-- add Amount to TotalAmount if the record type is S (Sell)
	UPDATE p
	  SET TotalAmount += d.Amount
	FROM dbo.Products AS p
	JOIN deleted d ON p.Id = d.ProductId
	WHERE d.RecordType = 'S';
END;
GO

SELECT * FROM dbo.Transactions;
SELECT * FROM dbo.Products;

DELETE FROM dbo.Transactions WHERE Id IN (3,6)
SELECT * FROM dbo.Products;