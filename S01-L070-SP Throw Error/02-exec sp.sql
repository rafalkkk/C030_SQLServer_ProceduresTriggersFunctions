BEGIN TRY
	EXEC HumanResources.RegisterTime 
			@BusinessEntityID = 13,
			@RegIn = '2033-03-03 08:00',
			@RegOut = '2033-03-04 16:05';
END TRY
BEGIN CATCH
	PRINT 'Operation failed with error: ' + ERROR_MESSAGE();
END CATCH

SELECT * FROM HumanResources.InOut;