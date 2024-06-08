CREATE OR REPLACE FUNCTION public.crea_tabla_temporal()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare

begin
	
	
	
	create temp table datos_temporales on commit drop as 
	select * from mock_data md ;
return true;

END;
$function$
;
