CREATE TABLE Production.ProductMissingInfo
(ProductID INT);
GO

CREATE OR ALTER PROCEDURE Production.FindMissingInfo
	@CheckColor BIT = 0,
	@CheckClass BIT = 0,
	@CheckStyle BIT = 0
AS
BEGIN
	DELETE FROM Production.ProductMissingInfo;
	
	INSERT INTO Production.ProductMissingInfo(ProductID)
	SELECT ProductId FROM Production.Product 
	WHERE 
		(@CheckColor=1 AND Color IS NULL) OR 
		(@CheckClass=1 AND Class IS NULL) OR 
		(@CheckStyle=1 AND Style IS NULL);
END;
GO

-- Checking only products with missing Color
EXEC Production.FindMissingInfo @CheckColor=1;

SELECT ProductID, Color, Class, Style FROM Production.Product AS p 
WHERE EXISTS (SELECT * FROM Production.ProductMissingInfo AS i WHERE i.ProductID = p.ProductID);

SELECT ProductID, Color, Class, Style FROM Production.Product AS p 
WHERE NOT EXISTS (SELECT * FROM Production.ProductMissingInfo AS i WHERE i.ProductID = p.ProductID);

-- Checking only products with missing Style
EXEC Production.FindMissingInfo @CheckStyle=1;

SELECT ProductID, Color, Class, Style FROM Production.Product AS p 
WHERE EXISTS (SELECT * FROM Production.ProductMissingInfo AS i WHERE i.ProductID = p.ProductID);

SELECT ProductID, Color, Class, Style FROM Production.Product AS p 
WHERE NOT EXISTS (SELECT * FROM Production.ProductMissingInfo AS i WHERE i.ProductID = p.ProductID);


-- Checking only products with missing Color or Class
EXEC Production.FindMissingInfo @CheckColor=1, @CheckClass=1;

SELECT ProductID, Color, Class, Style FROM Production.Product AS p 
WHERE EXISTS (SELECT * FROM Production.ProductMissingInfo AS i WHERE i.ProductID = p.ProductID);

SELECT ProductID, Color, Class, Style FROM Production.Product AS p 
WHERE NOT EXISTS (SELECT * FROM Production.ProductMissingInfo AS i WHERE i.ProductID = p.ProductID);
