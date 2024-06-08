CREATE OR REPLACE FUNCTION public.insertar_registro()
 RETURNS text
 LANGUAGE plpython3u
AS $function$
	
	query = plpy.prepare("INSERT INTO data_aleatoria(nombre) values($1)",["text"])
	plpy.execute(query,["Andres"])
	return ('OK');

$function$
;