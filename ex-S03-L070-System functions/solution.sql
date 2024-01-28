SELECT 
  FirstName, LastName, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Person.Person;
GO

SELECT 
  UPPER(SUBSTRING(City, 3, 2))
FROM Person.Address;
GO

SELECT 
  AddressLine1, REPLACE(AddressLine1, ' St.', ' Street') 
FROM Person.Address
WHERE AddressLine1 LIKE '% St.%';
GO

SELECT 
  JobTitle, CHECKSUM(JobTitle) 
FROM HumanResources.Employee;
GO

SELECT 
  LOGINPROPERTY(name, 'BadPasswordCount'), * 
FROM sys.server_principals;
Go
