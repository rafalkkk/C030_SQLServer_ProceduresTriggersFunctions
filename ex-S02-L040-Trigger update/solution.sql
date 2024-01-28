
CREATE OR ALTER TRIGGER tr_update_transaction ON dbo.Transactions FOR UPDATE 
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT COUNT(*) FROM inserted GROUP BY ProductId HAVING COUNT(*) > 1)
		THROW 50001, 'ONE TRANSACTION CAN UPDATE A PRODUCT ONLY ONCE',1;

	-- REMOVE OLD VERSION OF RECORDS
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

	-- ADD NEW VERSION OF RECORDS
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

SELECT * FROM dbo.Transactions;
SELECT * FROM dbo.Products;

UPDATE dbo.Transactions
	SET Amount +=1
WHERE id IN (4,5);
