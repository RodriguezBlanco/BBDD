Use MASTER;
GO

--Para que esto funcione, primero debe crearse la base de datos "Limpiezas_RBD_Contenida"

ALTER DATABASE Limpiezas_RBD_Contenida
SET RESTRICTED_USER
WITH ROLLBACK IMMEDIATE;

--Cuando una base de datos está en modo restricted, solo los usuarios con el permiso control en la base de datos pueden conectarse a ella.

sp_configure 'contained database authentication', 1;  
RECONFIGURE;  
GO  
--Utilizo este procedimiento almacenado para "activar" la autenticacion de bases de datos contenidas

ALTER DATABASE Limpiezas_RBD_Contenida
SET containment=partial;

ALTER DATABASE Limpiezas_RBD_Contenida
SET MULTI_USER;

--lo cambio a multiuser para que los usuarios puedan conectarse a ella

USE Limpiezas_RBD_Contenida;
GO


CREATE USER Diego
WITH PASSWORD='abcd1234'
go


SELECT containment_desc FROM sys.databases
WHERE name='Limpiezas_RBD_Contenida'

