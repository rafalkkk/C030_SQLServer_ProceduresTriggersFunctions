--1
SELECT 
    sp.[StateProvinceID] 
    ,sp.[StateProvinceCode] 
    ,sp.[IsOnlyStateProvinceFlag] 
    ,sp.[Name] AS [StateProvinceName] 
    ,sp.[TerritoryID] 
    ,cr.[CountryRegionCode] 
    ,cr.[Name] AS [CountryRegionName]
FROM [Person].[StateProvince] sp 
    INNER JOIN [Person].[CountryRegion] cr 
    ON sp.[CountryRegionCode] = cr.[CountryRegionCode];
GO

--2
CREATE OR ALTER PROCEDURE Person.usp_GeoInfo
AS
BEGIN
	SELECT 
		sp.[StateProvinceID] 
		,sp.[StateProvinceCode] 
		,sp.[IsOnlyStateProvinceFlag] 
		,sp.[Name] AS [StateProvinceName] 
		,sp.[TerritoryID] 
		,cr.[CountryRegionCode] 
		,cr.[Name] AS [CountryRegionName]
	FROM [Person].[StateProvince] sp 
		INNER JOIN [Person].[CountryRegion] cr 
		ON sp.[CountryRegionCode] = cr.[CountryRegionCode];
END
GO

--3 
EXEC Person.usp_GeoInfo
GO

--4
CREATE OR ALTER PROCEDURE Person.usp_GeoInfo
AS
BEGIN
	SELECT
	    sp.[StateProvinceCode] 
		,sp.[IsOnlyStateProvinceFlag] 
		,sp.[Name] AS [StateProvinceName] 
		,cr.[CountryRegionCode] 
		,cr.[Name] AS [CountryRegionName]
	FROM [Person].[StateProvince] sp 
		INNER JOIN [Person].[CountryRegion] cr 
		ON sp.[CountryRegionCode] = cr.[CountryRegionCode];
END
GO

--5
EXEC Person.usp_GeoInfo
GO

--6
DROP PROC IF EXISTS Person.usp_GeoInfo;
GO
