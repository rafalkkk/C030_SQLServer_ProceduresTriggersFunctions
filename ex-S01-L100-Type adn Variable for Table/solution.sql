CREATE TYPE OrderNote FROM NVARCHAR(MAX);

DECLARE @tab TABLE
(ClientId INT,
 OrderDate DATETIME2,
 OrderNote OrderNote
 );

INSERT INTO @tab(ClientId, OrderDate, OrderNote) 
VALUES  (20, SYSDATETIME(), 'black and white please'),
        (21, SYSDATETIME(), '');

UPDATE @tab SET OrderNote = 'only black and white please' WHERE ClientId = 20;

INSERT INTO @tab(ClientId, OrderDate, OrderNote) 
VALUES  (22, SYSDATETIME(), 'Leave the package in the bakery shop, I''m on a trip.');

SELECT * FROM @tab;
