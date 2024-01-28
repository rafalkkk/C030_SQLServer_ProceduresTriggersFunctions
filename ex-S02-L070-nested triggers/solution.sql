CREATE TABLE dbo.OrderHeader
( Id INT PRIMARY KEY,
  ClientID INT,
  InvoiceDate DATE,
  ModifiedBy NVARCHAR(100),
  ModifiedDate DATETIME
);
GO

CREATE TABLE dbo.OrderDetail
( Id INT PRIMARY KEY,
  OrderHeaderId INT NOT NULL REFERENCES OrderHeader(Id),
  ProductID INT,
  Amount DECIMAL(10,2),
  Price DECIMAL(10,2),
  ModifiedBy NVARCHAR(100)
);
GO

CREATE OR ALTER TRIGGER dbo.tr_OrderHeader_ModifiedDate on dbo.OrderHeader FOR INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	PRINT 'Updating date';
	UPDATE oh
		SET ModifiedDate = GetDate()
	FROM dbo.OrderHeader AS oh
	JOIN inserted i ON oh.id = i.id;
END;
GO

INSERT INTO dbo.OrderHeader(Id, ClientID, InvoiceDate, ModifiedBy)
VALUES
  (1, 1, GetDate(), 'Marius'), (2, 2, GetDate(), 'Michael')
INSERT INTO dbo.OrderDetail(Id, OrderHeaderId, ProductID, Amount, Price, ModifiedBy)
VALUES
  (1, 1, 101, 10, 30, 'Marius'),  (2, 1, 102, 2, 89, 'Marius'),
  (3, 2, 101, 10, 30, 'Michael'), (4, 2, 102, 1, 89, 'Michael'); 
GO

SELECT * FROM dbo.OrderHeader;
SELECT * FROM dbo.OrderDetail;
GO

CREATE OR ALTER TRIGGER dbo.tr_propagate_ModifiedBy ON dbo.OrderDetail FOR INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	PRINT 'Updating OrderDetail';
	UPDATE oh 
		SET ModifiedBy = i.ModifiedBy
	FROM dbo.OrderHeader AS oh
	JOIN inserted AS i ON i.OrderHeaderId = oh.Id
END;
GO

UPDATE dbo.OrderDetail SET ModifiedBy = 'Anna' WHERE Id = 1;

SELECT * FROM dbo.OrderHeader;
SELECT * FROM dbo.OrderDetail;
GO
