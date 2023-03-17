USE master;
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Abcd1234.';
CREATE CERTIFICATE CertificadoBackup
WITH SUBJECT = 'certificado de prueba';
GO

BACKUP DATABASE Limpiezas__RBD
TO DISK = 'C:\Backups\Limpiezas__RBD_encrypted.bak'
WITH COMPRESSION, STATS = 10,
ENCRYPTION(ALGORITHM = AES_256, 
    SERVER CERTIFICATE = CertificadoBackup) 
GO
    