USE Limpiezas_RBD;

drop table if exists logo;

create table logo 
(
	logoid int,
	nombrelogo varchar(255),
	imagenlogo varbinary(max)
	);

insert into dbo.logo (logoid,nombrelogo,imagenlogo)

select 1,'opcion1',* from openrowset 
	(bulk 'C:\RodriguezBlancoBBDD2\Logos\logo1.jpg',single_blob) as imagefile;

  
insert into dbo.logo (logoid,nombrelogo,imagenlogo)

SELECT  2,'opcion2', * from openrowset 
	(bulk 'C:\RodriguezBlancoBBDD2\Logos\logo2.jpg',single_blob) as imagefile;

insert into dbo.logo (logoid,nombrelogo,imagenlogo)

SELECT  2,'opcion3', * from openrowset 
	(bulk 'C:\RodriguezBlancoBBDD2\Logos\logo3.jpg',single_blob) as imagefile;


SELECT * FROM logo
GO
