SELECT 
	a.AddressLine1, a.AddressLine2, a.City, a.PostalCode
	, sp.name AS StateProvinceName, sp.StateProvinceCode
	, cr.Name AS CountryName
	, st.Name AS TerritoryName
FROM Person.Address AS a
JOIN Person.StateProvince AS sp ON a.StateProvinceID = sp.StateProvinceID
JOIN Person.CountryRegion AS cr ON sp.CountryRegionCode = cr.CountryRegionCode
JOIN Sales.SalesTerritory AS st ON sp.TerritoryID = st.TerritoryID
GO

CREATE OR ALTER PROCEDURE Person.usp_getAddresses
	@CountryNameMask NVARCHAR(50),
	@TerritoryNameMask NVARCHAR(50)
AS
BEGIN
	SELECT 
		a.AddressLine1, a.AddressLine2, a.City, a.PostalCode
		, sp.name AS StateProvinceName, sp.StateProvinceCode
		, cr.Name AS CountryName
		, st.Name AS TerritoryName
	FROM Person.Address AS a
	JOIN Person.StateProvince AS sp ON a.StateProvinceID = sp.StateProvinceID
	JOIN Person.CountryRegion AS cr ON sp.CountryRegionCode = cr.CountryRegionCode
	JOIN Sales.SalesTerritory AS st ON sp.TerritoryID = st.TerritoryID
	WHERE
	   (cr.name IS NULL OR cr.Name LIKE @CountryNameMask)
	   AND
	   (st.Name IS NULL OR st.Name LIKE @TerritoryNameMask)
END
GO

EXEC Person.usp_getAddresses @CountryNameMask='%', @TerritoryNameMask='%';
GO

EXEC Person.usp_getAddresses @CountryNameMask='%', @TerritoryNameMask='Canada';
GO

EXEC Person.usp_getAddresses @CountryNameMask='United States', @TerritoryNameMask='%';
GO