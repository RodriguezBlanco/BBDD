USE msdb
GO

--Es necesario cambiar a esta DB por que es en la que se guardan los planes de mantenimiento



EXEC sp_add_job @job_name = 'Mantenimiento Limpiezas_RBD';


--utilizamos este procedimiento almacenado para crear la tarea

EXEC sp_update_job 
    @job_name = 'Mantenimiento Limpiezas_RBD', 
    @description = 'Copia de seguridad diferencial y de registro de transacciones semanal para la DB Limpiezas_RBD';


--Se utiliza este otro procedimiento almacenado para actualizar la tarea y añadirle la descripción.


EXEC sp_add_schedule 
    @schedule_name = 'Mantenimiento semanal Limpiezas_RBD',
    @freq_type = 8, -- Weekly
    @freq_interval = 1, -- Sunday
    @active_start_time = '00:00:00',
    @active_end_time = '23:59:59',
    @start_date = '20230316',
    @end_date = '20230330';

-- Con este procedimiento almacenado creamos el horario del mantenimiento

EXEC sp_attach_schedule 
    @job_name = 'Mantenimiento semanal Limpiezas_RBD',
    @schedule_name = 'Mantenimiento semanal Limpiezas_RBD';

-- Con este procedimiento almacenado lo que hago es asociar el horario o calendario al plan de mantenimiento creado anteriormente

DECLARE @backup_path NVARCHAR(500);
SET @backup_path = 'C:\Program Files\Microsoft SQL Server\MSSQL15.RBD\MSSQL\Backup\Limpiezas_RBD';

EXEC sp_add_jobstep 
    @job_name = 'Mantenimiento Limpiezas_RBD',
    @step_name = 'Copia de seguridad diferencial',
    @subsystem = 'TSQL',
    @command = 'BACKUP DATABASE Limpiezas_RBD 
        TO DISK = ''' @backup_path + '\Limpiezas_RBD_diferencial' + 
        CONVERT(NVARCHAR(10), GETDATE(), 112) + '_' + 
        REPLACE(CONVERT(NVARCHAR(8), GETDATE(), 108), ':', '') + '.bak'' 
        WITH DIFFERENTIAL;',
    @retry_attempts = 5,
    @retry_interval = 5;


--con el procedimiento almacenado add_jobstep se añade la tarea de backup diferencial, indicandole el comando,la ruta,la extension y la cantidad de reintentos posibles y el intervalo entre ellos.
--Se declara una variable @backup_path, para indicar la ruta a donde ira el backup realizado cada semana
--con "getdate" lo que hago es que al nombre del archivo se le añada la fecha en la que fue ralizado el backup


EXEC sp_add_jobstep 
    @job_name = 'Mantenimiento Limpiezas_RBD',
    @step_name = 'Copia de seguridad del registro de transacciones',
    @subsystem = 'TSQL',
    @command = 'BACKUP LOG Limpiezas_RBD 
        TO DISK = ''' + @backup_path + '\Limpiezas_RBD_log_' + 
        CONVERT(NVARCHAR(10), GETDATE(), 112) + '_' + 
        REPLACE(CONVERT(NVARCHAR(8), GETDATE(), 108), ':', '') + '.trn'';',
    @retry_attempts = 5,
    @retry_interval = 5;

--Esto hace lo mismo que la anterior parte del script, pero para el registro de transacciones