use Limpiezas__RBD
go

declare @pruebahash nvarchar(max) = 'datos de prueba'
select HASHBYTES ('SHA2_512', @pruebahash) AS [Hash value]
go

declare @pruebahash2 NVARCHAR(MAX) = 'prueba hash2'
select HASHBYTES ('MD2', @pruebahash2) AS [Hash value], DATALENGTH(HASHBYTES ('MD2', @pruebahash2)) AS [Data lenght];
select HASHBYTES ('MD4', @pruebahash2) AS [Hash value], DATALENGTH(HASHBYTES ('MD4', @pruebahash2)) AS [Data lenght];
select HASHBYTES ('MD5', @pruebahash2) AS [Hash value], DATALENGTH(HASHBYTES ('MD5', @pruebahash2)) AS [Data lenght];
select HASHBYTES ('SHA', @pruebahash2) AS [Hash value], DATALENGTH(HASHBYTES ('SHA', @pruebahash2)) AS [Data lenght];
select HASHBYTES ('SHA1', @pruebahash2) AS [Hash value], DATALENGTH(HASHBYTES ('SHA1', @pruebahash2)) AS [Data lenght];
select HASHBYTES ('SHA2_256', @pruebahash2) AS [Hash value], DATALENGTH(HASHBYTES ('SHA2_256', @pruebahash2)) AS [Data lenght];
select HASHBYTES ('SHA2_512', @pruebahash2) AS [Hash value], DATALENGTH(HASHBYTES ('SHA2_512', @pruebahash2)) AS [Data lenght];
go

declare @pruebahash3 NVARCHAR(MAX) = 'prueba3'
select HASHBYTES ('SHA2_512', @pruebahash3) AS [Hash value 1];
select HASHBYTES ('SHA2_512', @pruebahash3) AS [Hash value 2]
go

select HASHBYTES ('SHA2_512', N'Limpieza_RBD') AS [Hash value 3];
select HASHBYTES ('SHA2_512', 'limpieza rbd') AS [Hash value 4];
go

use Limpiezas__RBD
go

SELECT HASHBYTES('SHA2_512', 'CIF/NIF') AS [CIFNIF hash]
FROM dbo.clientes;

SELECT HASHBYTES('MD2', Estado) AS [state_hash]
FROM dbo.Asignaciones;

SELECT HASHBYTES('SHA', dni_e) AS [dni_e hash]
FROM dbo.empleados;

