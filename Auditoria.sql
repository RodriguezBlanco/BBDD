USE master
GO

--crear ubicacion para la auditoria, debe continuar aunque se produzca un error

CREATE SERVER AUDIT Limpiezas_RBD_Audit
TO FILE (FILEPATH = 'C:\Auditorias')
WITH (ON_FAILURE = CONTINUE)
GO

--crear especificacion de auditoria, la mia en concreto 
--audita los eventos de seleccion,actualizacion e insercion de la tabla asignaciones
--hechos por el rol direccion
CREATE DATABASE AUDIT SPECIFICATION Limpiezas_RBD
FOR SERVER AUDIT Limpiezas_RBD_Audit
ADD (SELECT, UPDATE, INSERT ON Asignaciones BY direccion)
WITH (STATE = ON)
GO

--orden de auditoria

CREATE SERVER AUDIT Limpiezas_RBD_Audit_Order
TO FILE (FILEPATH = 'C:\Auditorias')
WITH (ON_FAILURE = CONTINUE)
GO

ALTER SERVER AUDIT Limpiezas_RBD_Audit_Order
WITH (STATE = ON)
GO

ALTER SERVER AUDIT SPECIFICATION Limpiezas_RBD_Spec
WITH (STATE = ON)
GO


