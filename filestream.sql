USE Limpiezas_RBD;

EXEC sp_configure 'filestream_access_level', 2;
RECONFIGURE;

ALTER DATABASE Limpiezas_RBD
ADD FILEGROUP logo_filestream CONTAINS FILESTREAM;

ALTER DATABASE Limpiezas_RBD
ADD FILE (
    NAME = 'logo_filestream',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\filestream'
) TO FILEGROUP logo_filestream;

DROP TABLE IF EXISTS logos;

CREATE TABLE logos
(
         id UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE,
       nombre varchar(255),
       imageFile VARBINARY(MAX) FILESTREAM
);


INSERT INTO logos (id, nombre, imageFile)
SELECT NEWID(), 'logo1', CONVERT(VARBINARY(MAX), BulkColumn) 
FROM OPENROWSET(BULK 'C:\RodriguezBlancoBBDD2\Logos\logo1.jpg', SINGLE_BLOB) AS document;

INSERT INTO logos (id, nombre, imageFile)
SELECT NEWID(), 'logo2', CONVERT(VARBINARY(MAX), BulkColumn)
FROM OPENROWSET(BULK 'C:\RodriguezBlancoBBDD2\Logos\logo2.jpg', SINGLE_BLOB) AS document;

INSERT INTO logos (id, nombre, imageFile)
SELECT NEWID(), 'logo3', CONVERT(VARBINARY(MAX), BulkColumn)
FROM OPENROWSET(BULK 'C:\RodriguezBlancoBBDD2\Logos\logo3.jpg', SINGLE_BLOB) AS document;


SELECT * FROM dbo.logos;
GO
