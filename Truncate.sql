USE [Limpiezas__RBD]
GO

CREATE TABLE Pruebatruncate(
	[ID_Asig] [int] NOT NULL,
	[Estado] [varchar](15) NULL,
	[Empleados_DNI_E] [char](9) NOT NULL,
	[Clientes_DNI/CIF] [char](9) NOT NULL,
)

Insert into Pruebatruncate
Values ('1','finalizado','55446677P','11223344O')


select * from Asignaciones
GO

TRUNCATE TABLE PruebaTruncate 
go

select * from Pruebatruncate
GO