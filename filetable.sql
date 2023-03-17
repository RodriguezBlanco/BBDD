use master;

alter database Limpiezas_RBD
	set filestream (directory_name = N'Limpiezas_RBD') 
	with rollback immediate;

alter database Limpiezas_RBD
	set filestream (non_transacted_access = full,
				directory_name = N'Limpiezas_RBD')
	with rollback immediate;

drop table if exists logos;

create table logos as filetable with (
		filetable_directory = 'Limpiezas_RBD_logo',
		filetable_collate_filename = database_default,
		filetable_streamid_unique_constraint_name=uq_logo_id);
