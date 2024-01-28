EXEC HumanResources.RegisterTime 
		@BusinessEntityID = 13,
		@RegIn = '2033-03-04 8:00',
		@RegOut = '2033-03-03 16:05';

SELECT * FROM HumanResources.InOut;