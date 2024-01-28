SELECT 
 p.BusinessEntityId, p.FirstName, p.LastName
 , at.Name AS 'Address Type'
 , a.PostalCode, a.City, a.AddressLine1, a.AddressLine2
FROM Person.Person AS p
JOIN Person.BusinessEntityAddress AS bea ON bea.BusinessEntityID=p.BusinessEntityID
JOIN Person.AddressType AS at ON at.AddressTypeID = bea.AddressTypeID
JOIN Person.Address AS a ON a.AddressID = bea.AddressID
WHERE p.BusinessEntityID = 4045;
GO

CREATE OR ALTER FUNCTION dbo.GetPersonAddress(@BusinessEntityId INT)
RETURNS TABLE 
AS
RETURN
	SELECT 
	 p.BusinessEntityId, p.FirstName, p.LastName
	 , at.Name AS 'Address Type'
	 , a.PostalCode, a.City, a.AddressLine1, a.AddressLine2
	FROM Person.Person AS p
	JOIN Person.BusinessEntityAddress AS bea ON bea.BusinessEntityID=p.BusinessEntityID
	JOIN Person.AddressType AS at ON at.AddressTypeID = bea.AddressTypeID
	JOIN Person.Address AS a ON a.AddressID = bea.AddressID
	WHERE p.BusinessEntityID = @BusinessEntityId;
GO

SELECT * FROM dbo.GetPersonAddress(4045);
