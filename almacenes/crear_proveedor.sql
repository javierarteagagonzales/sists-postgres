CREATE OR REPLACE FUNCTION public.crear_proveedor(codigo_p numeric , nombre_p varchar, telefono_p varchar,ciudad_p varchar)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
declare 


begin 
	
	
	insert into proveedor(codigo,nombre,telefono,ciudad) values (codigo_p,nombre_p,telefono_p,ciudad_p);
	return 'El proveedor se creo correctamente';
	
end;
$function$
;