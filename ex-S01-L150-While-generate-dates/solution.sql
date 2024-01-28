SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'

DBCC CHECKTABLE ('Sales.SalesTaxRate')
GO

CREATE OR ALTER PROCEDURE dbo.TestTableOneByOne
AS
BEGIN
	DECLARE @tab TABLE (name SYSNAME)
	INSERT INTO @tab SELECT TABLE_SCHEMA + '.' + TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';
	
	WHILE EXISTS(SELECT * FROM @tab)
	BEGIN
		DECLARE @table_name SYSNAME;
		SELECT TOP 1 @table_name = name FROM @tab;
		DECLARE @command NVARCHAR(MAX) = 'DBCC CHECKTABLE(@table_name)';
		DECLARE @ParmDefinition NVARCHAR(500);  
		SET @ParmDefinition = N'@table_name SYSNAME';  
		EXECUTE sp_executesql @Command, @ParmDefinition, @table_name = @table_name;  
		DELETE FROM @tab WHERE name = @table_name;
	END
END;
GO

EXECUTE dbo.TestTableOneByOne