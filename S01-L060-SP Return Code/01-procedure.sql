CREATE OR ALTER PROCEDURE HumanResources.RegisterTime
	@BusinessEntityId INT,
	@RegIn DATETIME,
	@RegOut DATETIME
AS
BEGIN

	IF @RegIn IS NULL
	BEGIN
		RETURN -1
	END

	IF @RegOut IS NOT NULL AND @RegIn > @RegOut
	BEGIN
		RETURN -2
	END

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

	RETURN 0;
END