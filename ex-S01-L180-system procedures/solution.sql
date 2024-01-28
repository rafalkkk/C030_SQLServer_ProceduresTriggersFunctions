EXEC sp_spaceused;

CREATE TABLE dbo.x (id int);

EXEC sp_rename 'dbo.x', 'y'

sp_help 'dbo.x'
sp_help 'dbo.y'

sp_helpindex 'Person.Person'

DROP TABLE dbo.y