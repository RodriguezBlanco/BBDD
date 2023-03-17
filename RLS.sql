Use Limpiezas_RBD
go

Create role Empleados
go

create role direccion
go

grant select , update on Asignaciones to direccion
grant select , update on Asignaciones to empleados
go

Create user axl without login
Alter role Empleados add member axl
insert into Empleados
values ('47377821P','Axl','mccormick','123456789','axl@tim.com')
go

select * from Empleados

Create user Mike without login
alter role direccion add member mike
insert into empleados
values ('47679822Z','Mike','Toreno','666555444','mike@toreno.com')
go

select * from empleados 

CREATE FUNCTION dbo.fn_cliente_security_predicate (@DNI_E varchar(20))
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS fn_security_predicate_result
WHERE @DNI_E = (SELECT DNI_E FROM dbo.clientes WHERE email = USER_NAME() + '@toreno.com')

CREATE SECURITY POLICY cliente_security_policy
ADD FILTER PREDICATE dbo.fn_cliente_security_predicate(cliente_id) ON dbo.clientes
WITH (STATE = ON)


SELECT * FROM dbo.clientes

--se supone que al ejecutar la select solo te devuelve filas donde la columna
--del email del usuario coincida con nombre de usuario + "@toreno.com"
-- pero no me ha funcionado y no tengo muy claro donde esta el error