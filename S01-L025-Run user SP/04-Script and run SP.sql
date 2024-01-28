USE [AdventureWorks]
GO

DECLARE @BusinessEntityID int

-- TODO: Set parameter values here.
SET @BusinessEntityID = 13;

EXECUTE [dbo].[uspGetEmployeeManagers] 
   @BusinessEntityID
GO


