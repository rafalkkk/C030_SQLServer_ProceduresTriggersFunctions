USE [AdventureWorks]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[uspGetEmployeeManagers]
		@BusinessEntityID = 13

SELECT	'Return Value' = @return_value

GO
