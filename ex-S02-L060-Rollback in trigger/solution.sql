DROP TABLE IF EXISTS dbo.Promotions;
DROP TABLE IF EXISTS dbo.Invoices
GO

CREATE TABLE dbo.Promotions
( DayOfWeek NVARCHAR(20) PRIMARY KEY,
  MaxPromotionPercent DECIMAL(3,1));
GO

-- 2222-01-02 is Wednesday
INSERT INTO dbo.Promotions (DayOfWeek, MaxPromotionPercent) VALUES (DATENAME(WEEKDAY,'2222-01-02'),10);
GO

CREATE TABLE dbo.Invoices
( Id INT IDENTITY NOT NULL,
  ClientID INT,
  InvoiceDate DATE,
  PromotionPercent DECIMAL(3,1));
GO

CREATE OR ALTER TRIGGER dbo.tr_Invoices_insert_update ON dbo.Invoices FOR INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT * FROM inserted i 
	           JOIN dbo.Promotions p ON DATENAME(WEEKDAY, i.InvoiceDate)=p.DayOfWeek
			   WHERE i.PromotionPercent > p.MaxPromotionPercent)
	BEGIN
		DECLARE @Message NVARCHAR(MAX);
		SET @Message = 'Promotion exceeds the max promotion rate for selected days';
		THROW 500001, @Message, 0
	END
END
GO

-- 2033-12-14 is Wednesday - this should FAIL
INSERT INTO dbo.Invoices(ClientID, InvoiceDate, PromotionPercent)
VALUES (1, '2033-12-14', 5), (1, '2033-12-14', 15);

-- 2033-12-14 is Wednesday - this should SUCCEED
INSERT INTO dbo.Invoices(ClientID, InvoiceDate, PromotionPercent)
VALUES (1, '2033-12-14', 5), (1, '2033-12-14', 5);

-- 2033-12-14 is NOT Wednesday - this should SUCCEED
INSERT INTO dbo.Invoices(ClientID, InvoiceDate, PromotionPercent)
VALUES (1, '2033-12-13', 5), (1, '2033-12-13', 15);

SELECT * FROM dbo.Invoices