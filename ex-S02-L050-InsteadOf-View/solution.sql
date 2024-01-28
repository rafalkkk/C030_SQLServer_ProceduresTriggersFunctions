CREATE TABLE dbo.Biedl(
  Id INT IDENTITY PRIMARY KEY,
  Name NVARCHAR(100),
  Price DECIMAL(10,2));
GO
CREATE TABLE dbo.Lidronka(
  Id INT IDENTITY PRIMARY KEY,
  Name NVARCHAR(100),
  Price DECIMAL(10,2));
GO

INSERT INTO dbo.Biedl(Name,Price) VALUES('Apples',3),('Oranges', 3),('Lemons', 3);
INSERT INTO dbo.Lidronka(Name,Price) VALUES('Apples',3),('Oranges', 3),('Lemons', 3);
GO

SELECT 'BIEDL' AS Shop, Name, Price FROM Biedl
UNION ALL
SELECT 'LIDRONKA' AS Shop, Name, Price FROM Lidronka;
GO

CREATE OR ALTER VIEW vShops
AS
SELECT 'BIEDL' AS Shop, Name, Price FROM Biedl
UNION ALL
SELECT 'LIDRONKA' AS Shop, Name, Price FROM Lidronka;
GO

SELECT * FROM vShops;
GO

CREATE OR ALTER TRIGGER tr_vShops_insert ON vShops INSTEAD OF INSERT 
AS
BEGIN
  SET NOCOUNT ON;

  INSERT INTO Biedl(Name, Price)
  SELECT Name, Price FROM inserted 
  WHERE Shop='BIEDL';

  INSERT INTO Lidronka(Name, Price)
  SELECT Name, Price FROM inserted 
  WHERE Shop='LIDRONKA';

END
GO

INSERT INTO vShops (Shop, Name, Price) 
VALUES
('BIEDL', 'Pears', 3),
('LIDRONKA', 'Bananas', 3);

SELECT * FROM Biedl;
SELECT * FROM Lidronka;