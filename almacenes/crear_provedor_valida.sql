	
CREATE OR REPLACE FUNCTION public.crear_proveedor(codigo_p numeric , nombre_p varchar, telefono_p varchar,ciudad_p varchar)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
declare 

valida_codigo integer;
valida_nombre integer;

begin 
	
	select count(*) into valida_codigo from proveedor where codigo = codigo_p;
	if valida_codigo = 1 then
		return 'El proveedor ya existe,por lo tanto no se crea';
	end if;
	select count(*) into valida_nombre from proveedor where nombre = nombre_p;
	if valida_nombre = 1 then
		return 'El nombre ya existe , por lo tanto el proveedor no se crea';
	end if;
	insert into proveedor(codigo,nombre,telefono,ciudad) values (codigo_p,nombre_p,telefono_p,ciudad_p);
	return 'El proveedor se creo correctamente';
	
end;
$function$
;
