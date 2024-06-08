--- Actualizar el iva en valor_domicilio de la tabla pedidos

CREATE OR REPLACE FUNCTION public.actualiza_pedidos_iva()
 RETURNS text
 LANGUAGE plpgsql
AS $function$
declare 

iva numeric(8,2);

valor_iva numeric;
cursor_pedidos cursor is 
select * from pedidos;

begin 
	
	iva = 0.19;
	
	for rec in cursor_pedidos loop 
		valor_iva = rec.valor_domicilio + (rec.valor_domicilio * iva);
		update pedidos set valor_domicilio = valor_iva where num_pedido = rec.num_pedido;
	end loop;
	
	return 'Pedidos actualizados';
	
end;
$function$
;

select * from public.actualiza_pedidos_iva();