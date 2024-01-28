CREATE OR ALTER FUNCTION dbo.HR_Rate(@BirthDate DATE, @HireDate DATE, @ReportDate DATE)
RETURNS DECIMAL(10,3)
AS
BEGIN
  DECLARE @DiffHireBirth DECIMAL(10,3);
  SET @DiffHireBirth = DATEDIFF(day, @HireDate, @BirthDate);
  DECLARE @DiffReportHire DECIMAL(10,3);
  SET @DiffReportHire = DATEDIFF(day, @ReportDate, @HireDate);
  RETURN @DiffReportHire / @DiffHireBirth;
END;
GO

SELECT BusinessEntityID,JobTitle,BirthDate,HireDate,GetDate() AS ReportDate, 
       dbo.HR_Rate(BirthDate, HireDate, GetDate())
FROM HumanResources.Employee;