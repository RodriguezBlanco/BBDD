MERGE Empleados AS destino
USING Clientes AS fuente
ON destino.DNI_E = fuente.[DNI/CIF]
WHEN MATCHED THEN
    UPDATE SET
        destino.Nombre = fuente.calle,
        destino.Email = fuente.Email,
        destino.Telefono = fuente.Telefono
WHEN NOT MATCHED BY TARGET THEN
    INSERT (DNI_E, Nombre, Email, Telefono)
    VALUES (fuente.[DNI/CIF], fuente.calle, fuente.Email, fuente.Telefono)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
