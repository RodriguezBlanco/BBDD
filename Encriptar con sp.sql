use Limpiezas__RBD;
go

CREATE PROCEDURE dbo.telefonoencriptado
as
begin
	set nocount on;
	declare @key_name nvarchar(128) = N'clavetlf';
	declare @encrypted_table varbinary(max) = null;

--comprobar si la clave simetrica existe, si no hay que crearla

if not exists (select * from sys.symmetric_keys where name = @key_name)
begin
	create symmetric key [clavetlf] with algorithm =
	aes_256 encryption by password = '1234'
end;

set @encrypted_table = ENCRYPTBYKEY(key_guid(@key_name), [Telefono])
from [dbo].[empleados];

update dbo.Empleados set Telefono = @encrypted_table;
end
go

SP_HELP [empleados]
GO
SP_HELPTEXT [empleados]
GO




