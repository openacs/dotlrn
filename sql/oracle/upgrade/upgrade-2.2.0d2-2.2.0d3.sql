
-- Create auxiliary tables

create table apm_parameter_values_copy (
	value_id	        integer,	
	package_id		integer, 
	parameter_id		integer, 
	attr_value		varchar(4000)
);

insert into apm_parameter_values_copy (
	value_id,	
	package_id, 
	parameter_id, 
	attr_value 
) select * from apm_parameter_values;
