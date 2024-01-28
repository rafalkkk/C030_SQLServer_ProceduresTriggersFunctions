DECLARE @TimeAtWork INT

BEGIN TRY
	EXEC HumanResources.RegisterTime 
			@BusinessEntityID = 13,
			@RegIn = '2033-03-03 08:00',
			@RegOut = '2033-03-03 16:05',
			@TimeAtWork = @TimeAtWork OUTPUT;
	SELECT @TimeAtWork AS 'Time at work (min)';
END TRY
BEGIN CATCH
	PRINT 'Operation failed with error: ' + ERROR_MESSAGE();
END CATCH

SELECT * FROM HumanResources.InOut;