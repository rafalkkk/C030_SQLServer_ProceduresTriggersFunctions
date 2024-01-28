CREATE OR ALTER PROCEDURE uspGetCurrentEmployeeDepartment
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50)
AS
BEGIN
	SELECT FirstName, LastName, Department 
	FROM HumanResources.vEmployeeDepartmentHistory 
	WHERE FirstName LIKE @FirstName AND LastName LIKE @LastName AND EndDate IS NULL;
END;
GO

EXECUTE uspGetCurrentEmployeeDepartment @LastName = '%W%', @FirstName = '%S%';
GO