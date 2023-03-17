USE Limpiezas__RBD

OPEN SYMMETRIC KEY clave_tlf_symmetric 
DECRYPTION BY ASYMMETRIC KEY clave_tlf_passphrase
WITH PASSWORD = 'contraseña'
GO

UPDATE Clientes
SET Email = ENCRYPTBYKEY(KEY_GUID('clave_simetrica'), Email);
GO

CLOSE SYMMETRIC KEY clave_tlf_symmetric;
GO

SELECT * FROM Clientes