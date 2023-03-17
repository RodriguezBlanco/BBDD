create table #TempAsignaciones
(
  AsignacionID int,
  FechaAsignacion varchar(50),
  EmpleadoID int,
  ProyectoID int,
  HorasAsignadas float
);

insert into #TempAsignaciones (AsignacionID, FechaAsignacion, EmpleadoID, ProyectoID, HorasAsignadas)
values ('01','16/03/2023','03','01','12')
go

select * from #TempAsignaciones

-- esta tabla no deberia estar disponible una vez reinicie el servidor