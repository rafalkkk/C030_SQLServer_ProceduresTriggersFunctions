USE tempdb;
GO

DROP TABLE IF EXISTS tab_city;
DROP TABLE IF EXISTS tab_country;
DROP TABLE IF EXISTS tab_alliance;
GO

CREATE TABLE tab_alliance ( 
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) UNIQUE,
	units INT DEFAULT 0);
GO

CREATE TABLE tab_country (
	id INT IDENTITY PRIMARY KEY,
	alliance_id INT REFERENCES tab_alliance(id),
	name NVARCHAR(100) UNIQUE,
	units INT DEFAULT 0);
GO

CREATE TABLE tab_city (
	id INT IDENTITY PRIMARY KEY,
	country_id INT REFERENCES tab_country(id),
	name NVARCHAR(100) UNIQUE,
	units INT DEFAULT 0);
GO

CREATE OR ALTER TRIGGER tr_tab_city ON tab_city FOR INSERT, UPDATE, DELETE 
AS
BEGIN
	IF (ROWCOUNT_BIG() = 0)
		RETURN;

	SET NOCOUNT ON;

    DECLARE @Operation CHAR(1);
	SELECT @Operation = CASE
            WHEN NOT EXISTS (SELECT * FROM deleted)  THEN 'I'
            WHEN NOT EXISTS (SELECT * FROM inserted) THEN 'D'
            ELSE 'U'
    END;

	PRINT 'Trigger for table tab_city, operation: ' + @Operation;

--	IF UPDATE(units)
	BEGIN
		UPDATE country
		SET units += agg.units
		FROM tab_country AS country
		JOIN (
			SELECT city.country_id, SUM(city.units) as units 
			FROM inserted as city
			GROUP BY city.country_id ) AS agg ON agg.country_id = country.id;

		UPDATE country
		SET units -= agg.units
		FROM tab_country AS country
		JOIN (
			SELECT city.country_id, SUM(city.units) as units 
			FROM deleted as city
			GROUP BY city.country_id ) AS agg ON agg.country_id = country.id;
	END;
END;
GO

CREATE OR ALTER TRIGGER tr_tab_country ON tab_country FOR INSERT, UPDATE, DELETE 
AS
BEGIN
	IF (ROWCOUNT_BIG() = 0)
		RETURN;
	SET NOCOUNT ON;

    DECLARE @Operation CHAR(1);
	SELECT @Operation = CASE
            WHEN NOT EXISTS (SELECT * FROM deleted)  THEN 'I'
            WHEN NOT EXISTS (SELECT * FROM inserted) THEN 'D'
            ELSE 'U'
    END;

	PRINT 'Trigger for table tab_country, operation: ' + @Operation;

--	IF UPDATE(units)
	BEGIN
		UPDATE alliance
		SET units += agg.units
		FROM tab_alliance AS alliance
		JOIN (
			SELECT country.alliance_id, SUM(units) as units 
			FROM inserted as country 
			GROUP BY country.alliance_id ) AS agg ON agg.alliance_id = alliance.id;

		UPDATE alliance
		SET units -= agg.units
		FROM tab_alliance AS alliance
		JOIN (
			SELECT country.alliance_id, SUM(units) as units 
			FROM deleted as country 
			GROUP BY country.alliance_id ) AS agg ON agg.alliance_id = alliance.id;
	END;
END;
GO

CREATE OR ALTER TRIGGER tr_tab_alliance ON tab_alliance FOR INSERT, UPDATE, DELETE 
AS
BEGIN
	IF (ROWCOUNT_BIG() = 0)
		RETURN;
	SET NOCOUNT ON;

    DECLARE @Operation CHAR(1);
	SELECT @Operation = CASE
            WHEN NOT EXISTS (SELECT * FROM deleted)  THEN 'I'
            WHEN NOT EXISTS (SELECT * FROM inserted) THEN 'D'
            ELSE 'U'
    END;

	PRINT 'Trigger for table tab_alliance, operation: ' + @Operation;
END;
GO

INSERT INTO tab_alliance(name) VALUES ('Olives'), ('Bananas');
INSERT INTO tab_country (name, alliance_id) VALUES('Italy', 1), ('Greece', 1), ('Spain', 1);
INSERT INTO tab_country (name, alliance_id) VALUES('Brazil', 2), ('Ecuador', 2);
INSERT INTO tab_city (name, country_id) VALUES('Rome', 1), ('Athens', 2), ('Barcelona', 3);
INSERT INTO tab_city (name, country_id, units) VALUES('Rio de Janeiro', 4, 1), ('Quito', 5, 2);

UPDATE tab_city SET units += 10 WHERE name = 'Rome';
UPDATE tab_city SET units += 15 WHERE name = 'Athens';
UPDATE tab_city SET units -= 5 WHERE name = 'Athens';

UPDATE tab_city SET units += 20 WHERE name = 'Rio de Janeiro';
DELETE FROM tab_city WHERE name = 'Rio de Janeiro';

SELECT * FROM tab_alliance;
SELECT * FROM tab_country;
SELECT * FROM tab_city;













