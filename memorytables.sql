alter database Limpiezas__RBD 
add filegroup Prueba_Memory CONTAINS MEMORY_OPTIMIZED_DATA;

alter database Limpiezas__RBD 
add file (name = memory_container, 
FILENAME = 'C:\memoryfiles\memorycontainer') 
TO FILEGROUP Prueba_Memory;

CREATE TABLE prueba_memorytable
(
  columna1 varchar(30),
  columna2 varchar(30),
  CONSTRAINT PK_prueba_memorytable PRIMARY KEY NONCLUSTERED (columna1)
) WITH (MEMORY_OPTIMIZED=ON, DURABILITY=SCHEMA_AND_DATA);

select * from prueba_memorytable