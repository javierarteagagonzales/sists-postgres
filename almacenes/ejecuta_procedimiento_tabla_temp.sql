CREATE OR REPLACE FUNCTION public.ejecuta_procedimiento_tabla_temp()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare

rec record;
begin
	
	perform public.crea_tabla_temporal();
	for rec in (select * from datos_temporales) loop 
		raise notice '%',rec;
	end loop;
return true;

END;
$function$
;
