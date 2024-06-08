create or replace function public.arreglos()
	returns varchar
	language plpgsql
as $function$

declare 


ciudades varchar ARRAY;
texto text;
texto2 text;
arreglo varchar array;
begin 
	
	ciudades[0]='Cali';
	ciudades[1]='Bogota';
	ciudades[2]='Medellin';
	
	raise notice ' Arreglo[0] = %',ciudades[0];
	raise notice ' Arreglo = %',ciudades;

	-- Añadir elementos al final de un arreglo
	ciudades = array_append(ciudades,'Barranquilla');
	
	raise notice ' Arreglo nuevo = %',ciudades;

	-- Añadir elementos al inicio de un arreglo
	ciudades = array_prepend('Soacha',ciudades);
	raise notice ' Arreglo nuevo2  = %',ciudades;
	

	-- Array to string 
	texto = array_to_string(ciudades,'{{{');
	raise notice ' texto  = %',texto;
	
	texto2 = 'Hola Mundo desde pl/pgsql';
	
	arreglo = string_to_array(texto2,' ');
	raise notice ' arreglo     = %',arreglo;
	raise notice ' arreglo[3]     = %',arreglo[3];

	return 'Proceso finalizado';
end;
$function$
;