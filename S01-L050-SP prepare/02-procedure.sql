CREATE OR ALTER PROCEDURE HumanResources.RegisterTime
	@BusinessEntityId INT,
	@RegIn DATETIME,
	@RegOut DATETIME
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM HumanResources.InOut 
				  WHERE BusinessEntityID=@BusinessEntityId AND RegInDate=CAST(@RegIn AS DATE))
	BEGIN
		-- insert a new row
		INSERT INTO HumanResources.InOut(BusinessEntityID, RegIn, RegOut)
		VALUES(@BusinessEntityId, @RegIn, @RegOut);
	END
	ELSE
	BEGIN
		-- update existing row
		UPDATE HumanResources.InOut SET
			RegIn = @RegIn,
			RegOut = @RegOut
		WHERE BusinessEntityID=@BusinessEntityId AND RegInDate=CAST(@RegIn AS DATE)
	END
END