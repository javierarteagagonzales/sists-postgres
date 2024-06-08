CREATE OR REPLACE FUNCTION public.ejecuta_string()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$

declare 
string_sql varchar;
begin 
	
	string_sql = '
		INSERT INTO public.data_aleatoria(id,nombre) values (1,''Andres'');
	';
	
	EXECUTE string_sql;
	return true;
end;
$function$
;
