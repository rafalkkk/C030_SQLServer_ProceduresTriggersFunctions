CREATE OR ALTER PROCEDURE Person.UpdatePersonEmail @BusinessEntityID INT, @Promotion BIT =0, @Email NVARCHAR(50) = NULL
AS
BEGIN
    SET XACT_ABORT ON;
    SET NOCOUNT ON;

	IF (@Promotion=1 AND @Email IS NULL)
	BEGIN;
		THROW 50010, 'When enabling promotion, you must send a new email address', 1;
	END

    BEGIN TRY
        BEGIN TRANSACTION;
			UPDATE Person.Person
			SET EmailPromotion = @Promotion
			WHERE BusinessEntityID= @BusinessEntityID;

			IF @Promotion=1
			BEGIN
				DELETE FROM Person.EmailAddress WHERE BusinessEntityID = @BusinessEntityID
				INSERT INTO Person.EmailAddress(BusinessEntityID,EmailAddress)
					VALUES(@BusinessEntityID, @Email);
			END
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW 50020, 'Error when updating email preferences', 1
    END CATCH;
END;
GO



SELECT p.BusinessEntityID, p.EmailPromotion, e.EmailAddress  
FROM Person.Person AS p 
LEFT JOIN Person.EmailAddress AS e ON e.BusinessEntityID=p.BusinessEntityID
WHERE p.BusinessEntityID IN (3,4);



EXEC Person.UpdatePersonEmail @BusinessEntityID = 3, @Promotion = 0

SELECT p.BusinessEntityID, p.EmailPromotion, e.EmailAddress  
FROM Person.Person AS p 
LEFT JOIN Person.EmailAddress AS e ON e.BusinessEntityID=p.BusinessEntityID
WHERE p.BusinessEntityID IN (3,4);



EXEC Person.UpdatePersonEmail @BusinessEntityID = 4, @Promotion = 1

SELECT p.BusinessEntityID, p.EmailPromotion, e.EmailAddress  
FROM Person.Person AS p 
LEFT JOIN Person.EmailAddress AS e ON e.BusinessEntityID=p.BusinessEntityID
WHERE p.BusinessEntityID IN (3,4);



EXEC Person.UpdatePersonEmail @BusinessEntityID = 4, @Promotion = 1, @Email = 'noreply@nodomain.com'

SELECT p.BusinessEntityID, p.EmailPromotion, e.EmailAddress  
FROM Person.Person AS p 
LEFT JOIN Person.EmailAddress AS e ON e.BusinessEntityID=p.BusinessEntityID
WHERE p.BusinessEntityID IN (3,4);