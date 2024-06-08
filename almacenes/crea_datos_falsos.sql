CREATE OR REPLACE FUNCTION public.creadatosfalsos()
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare

begin
	
	for fecha in 1..100000 loop
	
		insert into datos (id, first_name, last_name, email, gender, ip_address) values (1, 'Raff', 'Elix', 'relix0@mayoclinic.com', 'Polygender', '215.233.209.243');
	end loop;
return true;

END;
$function$
;
