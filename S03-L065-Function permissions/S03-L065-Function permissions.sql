CREATE OR ALTER FUNCTION dbo.scalar_square(@x INT)
RETURNS INT
AS
BEGIN
	DECLARE @result INT;
	SET @result = @x * @x;
	RETURN @result;
END
GO

CREATE USER test_user WITHOUT LOGIN; 

EXECUTE AS USER = 'test_user';
SELECT USER_NAME();
SELECT dbo.scalar_square(4);
REVERT;

GRANT EXECUTE ON dbo.scalar_square TO test_user;
GO

CREATE OR ALTER FUNCTION dbo.tvf_5() RETURNS @tab TABLE(i INT) 
AS
BEGIN
  DECLARE @i INT = 0;
  WHILE @i < 5
  BEGIN
	SET @i+=1;
	INSERT INTO @tab VALUES(@i)
  END
  RETURN
END
GO

EXECUTE AS USER = 'test_user';
SELECT USER_NAME();
SELECT * from dbo.tvf_5();
REVERT;

GRANT SELECT ON dbo.tvf_5 TO test_user;

GRANT EXECUTE ON SCHEMA::dbo TO test_user;
GRANT SELECT ON DATABASE::AdventureWorks TO test_user;

DROP FUNCTION IF EXISTS dbo.scalar_square;
DROP FUNCTION IF EXISTS dbo.tvf_5