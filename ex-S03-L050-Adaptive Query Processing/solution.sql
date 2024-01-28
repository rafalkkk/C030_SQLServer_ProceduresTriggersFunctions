SET STATISTICS TIME ON;

SELECT COUNT(*) FROM Person.Person AS p 
WHERE EXISTS(SELECT * FROM dbo.GetPersonAddress_MSTVF(p.BusinessEntityId));

SELECT COUNT(*) FROM Person.Person AS p 
WHERE EXISTS(SELECT * FROM dbo.GetPersonAddress(p.BusinessEntityId));

SET STATISTICS TIME OFF;
GO