CREATE OR REPLACE FUNCTION public.script_python()
 RETURNS text
 LANGUAGE plpython3u
AS $function$
	
	lista = []
	for i in range(10):
		lista.append(i)
	
	return (lista);


$function$
;