USE Limpiezas__RBD;
GO

CREATE ASYMMETRIC KEY clave_tlf_passphrase 
WITH ALGORITHM = RSA_2048 
ENCRYPTION BY PASSWORD = 'contraseña';

CREATE SYMMETRIC KEY clave_tlf_symmetric
WITH ALGORITHM = AES_256
ENCRYPTION BY ASYMMETRIC KEY clave_tlf_passphrase;

OPEN SYMMETRIC KEY clave_tlf_symmetric 
DECRYPTION BY ASYMMETRIC KEY clave_tlf_passphrase;

UPDATE dbo.Empleados 
SET Telefono = ENCRYPTBYKEY(KEY_GUID('clave_tlf_symmetric'), [Telefono]);

CLOSE SYMMETRIC KEY clave_tlf_symmetric;

Select * from Empleados
