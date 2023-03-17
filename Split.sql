CREATE PARTITION FUNCTION Asignaciones_Estado (varchar(10))
AS RANGE LEFT FOR VALUES ('finalizado', 'en curso');

CREATE PARTITION SCHEME Asignaciones_Estado
AS PARTITION Asignaciones_Estado
TO ([PRIMARY], [finalizado], [en curso]);



INSERT INTO Asignaciones 
VALUES ('1','finalizado','44775566p','47377823P'), ('2','en curso','44775566p','47377823P'), ('3','finalizado','44775566p','47377823P');



CREATE PARTITION FUNCTION L_Asignaciones (varchar(10))
AS RANGE LEFT FOR VALUES ('en curso');

CREATE PARTITION SCHEME L_Asignaciones
AS PARTITION L_Asignaciones
TO ([PRIMARY], [Asignaciones_Finalizado], [Asignaciones_EnCurso], [Asignaciones_Finalizado2]);

ALTER TABLE Asignaciones
SWITCH PARTITION 1 TO Asignaciones_EnCurso;


DROP PARTITION SCHEME Asignaciones;
DROP PARTITION FUNCTION Asignaciones;

SELECT * FROM sys.partition_functions;

SELECT * FROM Asignaciones
WHERE $PARTITION.Asignaciones(estado) = 'finalizado';

