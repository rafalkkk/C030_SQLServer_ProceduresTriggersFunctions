DECLARE @RC INT

EXEC @RC = HumanResources.RegisterTime 
		@BusinessEntityID = 13,
		@RegIn = '2033-03-03 08:00',
		@RegOut = '2033-03-03 16:05';

SELECT @RC AS 'Return code';

SELECT * FROM HumanResources.InOut;