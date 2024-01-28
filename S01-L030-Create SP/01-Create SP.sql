CREATE OR ALTER PROCEDURE uspGetCurrentEmployeeDepartment
AS
BEGIN
	SELECT FirstName, LastName, Department 
	FROM HumanResources.vEmployeeDepartmentHistory 
	WHERE EndDate IS NULL;
END;
GO

EXECUTE uspGetCurrentEmployeeDepartment;
GO

DROP PROCEDURE IF EXISTS dbo.uspGetCurrentEmployeeDepartment;
GO