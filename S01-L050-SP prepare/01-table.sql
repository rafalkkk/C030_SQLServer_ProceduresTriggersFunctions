CREATE TABLE HumanResources.InOut
( Id INT IDENTITY PRIMARY KEY,
  BusinessEntityID INT  NOT NULL
    CONSTRAINT FK_InOut_Person_BusinessEntityID FOREIGN KEY REFERENCES Person.BusinessEntity(BusinessEntityID),
  RegIn DATETIME NULL,
  RegOut DATETIME NULL
);
GO

ALTER TABLE HumanResources.InOut ADD RegInDate AS CAST(RegIn AS DATE) PERSISTED;
GO

CREATE UNIQUE INDEX IX_HumanResources_InOut_BusinessEntityID_RegInDate 
ON HumanResources.InOut(BusinessEntityID, RegInDate);
GO
