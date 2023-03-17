-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-03-15 21:50:36 CET
--   sitio:      SQL Server 2012
--   tipo:      SQL Server 2012

USE master
GO

DROP DATABASE IF EXISTS Limpiezas_RBD
GO

CREATE DATABASE Limpiezas_RBD
GO

USE Limpiezas_RBD
GO



CREATE TABLE Asignaciones 
    (
     ID_Asig INTEGER NOT NULL , 
     Estado VARCHAR (15) , 
     Empleados_DNI_E CHAR (9) NOT NULL , 
     "Clientes_DNI/CIF" CHAR (9) NOT NULL 
    )
GO

ALTER TABLE Asignaciones ADD CONSTRAINT Asignaciones_PK PRIMARY KEY CLUSTERED (ID_Asig)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Clientes 
    (
     "DNI/CIF" CHAR (9) NOT NULL , 
     Telefono CHAR (9) , 
     Email VARCHAR (20) , 
     Calle VARCHAR (50) , 
     Numero INTEGER , 
     CP CHAR (5) 
    )
GO

ALTER TABLE Clientes ADD CONSTRAINT Clientes_PK PRIMARY KEY CLUSTERED ("DNI/CIF")
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE DetalleAsignacion 
    (
     Duracion VARCHAR (15) , 
     Asignaciones_ID_Asig INTEGER NOT NULL , 
     Servicios_ID_Serv INTEGER NOT NULL 
    )
GO

CREATE TABLE DetalleFactura 
    (
     TotalFactura NUMERIC (7,2) , 
     Facturas_ID_factura INTEGER NOT NULL , 
     Servicios_ID_Serv INTEGER NOT NULL 
    )
GO

ALTER TABLE DetalleFactura ADD CONSTRAINT DetalleFactura_PK PRIMARY KEY CLUSTERED (Facturas_ID_factura, Servicios_ID_Serv)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Empleados 
    (
     DNI_E CHAR (9) NOT NULL , 
     Nombre VARCHAR (20) , 
     Apellido VARCHAR (30) , 
     Telefono CHAR (9) , 
     Email VARCHAR (50) 
    )
GO

ALTER TABLE Empleados ADD CONSTRAINT Empleados_PK PRIMARY KEY CLUSTERED (DNI_E)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Empresa 
    (
     "DNI/CIF" CHAR (9) NOT NULL , 
     Nombre VARCHAR (50) 
    )
GO

ALTER TABLE Empresa ADD CONSTRAINT Empresa_PK PRIMARY KEY CLUSTERED ("DNI/CIF")
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Facturas 
    (
     ID_factura INTEGER NOT NULL , 
     Num_Factura VARCHAR (10) , 
     Asignaciones_ID_Asig INTEGER NOT NULL 
    )
GO 

    


CREATE UNIQUE NONCLUSTERED INDEX 
    Facturas__IDX ON Facturas 
    ( 
     Asignaciones_ID_Asig 
    ) 
GO

ALTER TABLE Facturas ADD CONSTRAINT Facturas_PK PRIMARY KEY CLUSTERED (ID_factura)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Particular 
    (
     "DNI/CIF" CHAR (9) NOT NULL , 
     Nombre VARCHAR (20) , 
     Apellido VARCHAR (20) 
    )
GO

ALTER TABLE Particular ADD CONSTRAINT Particular_PK PRIMARY KEY CLUSTERED ("DNI/CIF")
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Servicios 
    (
     ID_Serv INTEGER NOT NULL , 
     Tipo VARCHAR (30) , 
     Descripcion VARCHAR (100) , 
     TarifaHora NUMERIC (4,2) 
    )
GO

ALTER TABLE Servicios ADD CONSTRAINT Servicios_PK PRIMARY KEY CLUSTERED (ID_Serv)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE Asignaciones 
    ADD CONSTRAINT Asignaciones_Clientes_FK FOREIGN KEY 
    ( 
     "Clientes_DNI/CIF"
    ) 
    REFERENCES Clientes 
    ( 
     "DNI/CIF" 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Asignaciones 
    ADD CONSTRAINT Asignaciones_Empleados_FK FOREIGN KEY 
    ( 
     Empleados_DNI_E
    ) 
    REFERENCES Empleados 
    ( 
     DNI_E 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE DetalleAsignacion 
    ADD CONSTRAINT DetalleAsignacion_Asignaciones_FK FOREIGN KEY 
    ( 
     Asignaciones_ID_Asig
    ) 
    REFERENCES Asignaciones 
    ( 
     ID_Asig 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE DetalleAsignacion 
    ADD CONSTRAINT DetalleAsignacion_Servicios_FK FOREIGN KEY 
    ( 
     Servicios_ID_Serv
    ) 
    REFERENCES Servicios 
    ( 
     ID_Serv 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE DetalleFactura 
    ADD CONSTRAINT DetalleFactura_Facturas_FK FOREIGN KEY 
    ( 
     Facturas_ID_factura
    ) 
    REFERENCES Facturas 
    ( 
     ID_factura 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE DetalleFactura 
    ADD CONSTRAINT DetalleFactura_Servicios_FK FOREIGN KEY 
    ( 
     Servicios_ID_Serv
    ) 
    REFERENCES Servicios 
    ( 
     ID_Serv 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Empresa 
    ADD CONSTRAINT Empresa_Clientes_FK FOREIGN KEY 
    ( 
     "DNI/CIF"
    ) 
    REFERENCES Clientes 
    ( 
     "DNI/CIF" 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Facturas 
    ADD CONSTRAINT Facturas_Asignaciones_FK FOREIGN KEY 
    ( 
     Asignaciones_ID_Asig
    ) 
    REFERENCES Asignaciones 
    ( 
     ID_Asig 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Particular 
    ADD CONSTRAINT Particular_Clientes_FK FOREIGN KEY 
    ( 
     "DNI/CIF"
    ) 
    REFERENCES Clientes 
    ( 
     "DNI/CIF" 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             1
-- ALTER TABLE                             17
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE DATABASE                          0
-- CREATE DEFAULT                           0
-- CREATE INDEX ON VIEW                     0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE ROLE                              0
-- CREATE RULE                              0
-- CREATE SCHEMA                            0
-- CREATE SEQUENCE                          0
-- CREATE PARTITION FUNCTION                0
-- CREATE PARTITION SCHEME                  0
-- 
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
