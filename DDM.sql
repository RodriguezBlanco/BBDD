USE Limpiezas_RBD
GO

DROP SCHEMA IF EXISTS pruebaddm
GO
CREATE SCHEMA pruebaddm
GO

DROP TABLE IF EXISTS pruebaddm.clientes
GO
CREATE TABLE pruebaddm.clientes (
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	nombre varchar(100) MASKED WITH (FUNCTION = 'partial(1, "xxxxx", 1)')
	NULL,
	telefono varchar(9) MASKED WITH (FUNCTION = 'default()') NULL,
	Email varchar(100) MASKED WITH (FUNCTION = 'email()') NOT NULL,
	numero smallint MASKED WITH (FUNCTION = 'random(1, 100)') NULL,
);
GO

Insert into pruebaddm.clientes
values ('Diego','111222333','diegorb1933@gmail.com',12),
		('norberto','555666333','norberto@gmail.com',16),
		('Axl','111666777','Awesome@gmail.com',5)
go

select * from pruebaddm.clientes
go

create schema pruebaddm2


CREATE TABLE pruebaddm2.estado (
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	estado varchar(100) MASKED WITH (FUNCTION = 'default()') NULL,
);
GO

insert into pruebaddm2.estado
values 
('finalizado'),('en curso')
go

select * from pruebaddm2.estado
go

--hasta este momento lo unico que he hecho ha sido crear los esquemas,las tablas e insertar datos de prueba.

--creacion de usuario 

create user empleado1 without login
go

create user empleado2 without login
go

create user empleado3 without login
go

create user empleado4 without login
go

-- dar permisos de lectura a los usuarios

alter role db_datareader add member empleado1;
alter role db_datareader add member empleado2;
alter role db_datareader add member empleado3;
alter role db_datareader add member empleado4;
go

--permisos a nivel de columna,tabla,schema y DB
GRANT UNMASK ON pruebaddm.clientes(nombre) TO empleado1 
GRANT UNMASK ON pruebaddm.clientes TO empleado2;
GRANT UNMASK ON SCHEMA::pruebaddm TO empleado3;
GRANT UNMASK ON SCHEMA::pruebaddm2 TO empleado3;
GRANT UNMASK TO empleado4;
GO

execute as user = 'empleado4'
select * from pruebaddm.clientes
select * from pruebaddm2.estado
go
revert
go
execute as user = 'empleado2'
select nombre from pruebaddm.clientes
select * from pruebaddm2.estado
go
revert
go
execute as user = 'empleado1'
select nombre from pruebaddm.clientes
select * from pruebaddm2.estado
go
revert
go
execute as user = 'empleado3'
select nombre from pruebaddm.clientes
select * from pruebaddm2.estado
go
revert

--quitar permisos
REVOKE UNMASK ON pruebaddm.clientes(nombre) TO empleado1 
REVOKE UNMASK ON pruebaddm.clientes TO empleado2;
REVOKE UNMASK ON SCHEMA::pruebaddm TO empleado3;
REVOKE UNMASK ON SCHEMA::pruebaddm2 TO empleado3;
REVOKE UNMASK TO empleado4;
GO