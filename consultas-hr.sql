/* 
PARTE II: HR
6. Muestre el nombre, fecha de contratación, salario, nombre de 
departamento y nombre del rol de todos los empleados cuyo salario 
se encuentre en el intervalo [4500, 15000>.*/
SELECT e.first_name, jh.start_date, e.salary, d.department_name,
	jo.job_title
FROM employees e
JOIN job_history jh ON e.employee_id = jh.employee_id
JOIN departments d ON jh.department_id = d.department_id
JOIN jobs jo ON jh.job_id = jo.job_id
WHERE e.salary BETWEEN '4500' AND '15000'

/* 7. Muestre el código de empleado, el nombre del empleado y el
país donde laboran aquellos empleados que desempeñen el rol de 
Contador (Accountant).*/
SELECT e.employee_id, e.first_name, c.country_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN job_history jh ON e.employee_id = jh.employee_id
JOIN jobs jo ON jh.job_id = jo.job_id
WHERE jo.job_title = 'Accountant'

/* 8. Muestre las tuplas correspondientes a todos los empleados que 
se encuentran en la oficina (location) de Ciudad de México 
(Mexico City) o trabajan en Estados Unidos (United States). */
SELECT *
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
WHERE l.city = 'Mexico City' OR c.country_name = 'United States of America'

/* 9. Muestre las tuplas correspondientes a todos los empleados del 
	área de ventas que se encuentren laborando en Reino Unido 
	(United Kingdom).*/
SELECT *
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
WHERE d.department_name='Sales' AND c.country_name='United Kingdom'

/* 10. Muestre los datos de nombre y apellido de todos los empleados 
que se encuentren en la región “Americas” y tengan un salario menor 
que el promedio de su rol.*/
SELECT e.first_name, e.last_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id=r.region_id
WHERE r.region_name='Americas' AND e.salary < (SELECT AVG(salary)
	FROM employees
	WHERE job_id=e.job_id)

/* 11. Muestre los datos de región, país y la cantidad de empleados 
	por cada país. Dicho reporte debe considerar solamente aquellos 
	países que tengan más de 3 empleados registrados.*/
SELECT r.region_name, c.country_name, COUNT(employee_id) AS cant_empl
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id=r.region_id
GROUP BY r.region_name, c.country_name
HAVING COUNT(employee_id) > 3


/* 12. Muestre la diferencia en días entre la fecha de contratación 
del empleado más antiguo y del empleado más reciente. 
Excluya de este cálculo a aquellos empleados que pertenecen al 
área “Executive”.*/
SELECT MAX(jh.start_date)-MIN(jh.start_date)
FROM employees e
JOIN job_history jh ON e.employee_id = jh.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE NOT d.department_name='Executive'

/* 13. Muestre el código, nombre, apellido y cantidad de subordinados
de todos los empleados (debe mostrar cero para aquellos empleados 
que no tengan subordinados). Considere solamente a aquellos empleados
con menos de 8 empleados a cargo.*/
SELECT e.employee_id AS codigo,e.first_name AS nombre,e.last_name AS apellido,
    COALESCE(subordinate_count.count, 0) AS cantidad_subordinados
FROM employees e
LEFT JOIN (SELECT manager_id, COUNT(*) AS count
    FROM employees
    GROUP BY manager_id ) AS subordinate_count
ON e.employee_id = subordinate_count.manager_id
WHERE  COALESCE(subordinate_count.count, 0) < 8;

/*	14. Muestre el siguiente texto por cada uno de los empleados: 
“El empleado <NOMBRE> <APELLIDO> ha trabajado por <X> anios, <Y> meses 
y <Z> días”. Excluya de este cálculo a los empleados contratados a 
partir de 1997 y a aquellos que estén en la región Europa (Europe).*/
SELECT CONCAT('El empleado ',e.first_name,' ',e.last_name,' ha trabajado por ',
	 EXTRACT(YEAR FROM jh.end_date) - EXTRACT(YEAR FROM jh.start_date), ' años ',
	 EXTRACT(MONTH FROM jh.end_date) - EXTRACT(MONTH FROM jh.start_date), ' meses y ',
	EXTRACT(DAY FROM jh.end_date) - EXTRACT(DAY FROM jh.start_date), ' días.')
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id=r.region_id
JOIN job_history jh ON e.employee_id = jh.employee_id
JOIN jobs jo ON jh.job_id = jo.job_id
WHERE NOT (EXTRACT(YEAR FROM jh.start_date) = 1997 AND r.region_name='Europe')


/*
15. Por cada empleado muestre la descripción de su rol, la fecha de inicio y la fecha
de fin. Considere todos los roles que ha desempeñado en la empresa (incluyendo su rol
actual).*/



/*
16. Cree una nueva tabla denominada emp001, con las siguientes especificaciones:
a. Debe considerarse solamente a aquellos empleados con un salario
superior al promedio de la empresa.
b. Tanto los datos de nombre y apellido del empleado deben aparecer en
letras mayúsculas.
c. El código de empleado debe ser de 8 caracteres (completados por ceros
por el lado izquierdo).
3
d. Finalmente, la tabla debe contener el nombre del departamento
asociado al empleado (en lugar del ID) y el nombre del supervisor directo del
empleado (en vez del ID).
Sobre la nueva tabla creada realice las siguientes operaciones:
17. Incremente en 10% el salario de los empleados cuya remuneración se
encuentra por debajo del promedio de su departamento.
18. Incremente en 100 el salario de aquellos empleados que tengan el rol
“Programmer”.
19. Agregue 2 campos nuevos a la tabla creada: COMMISSION y TOTAL_SALARY.
Considere los mismos tipos de datos del campo SALARY.
20. Actualice los valores de los campos COMMISSION y TOTAL_SALARY. El primero
debe almacenar el monto de la comisión (porcentaje * salario) y el segundo debe
considerar la suma del salario y la comisión total.
21. Trabaje sobre la tabla creada en el paso anterior y elimine aquellos registros de
empleado que se encuentren asociados a la región “Americas”.
22. Elimine todos los registros de la tabla (solamente puede utilizar sentencias
DDL).
23. Utilice el script de creación de la tabla emp001 y modifíquelo de manera que
considere los campos COMISSION y TOTAL_SALARY y se puedan llenar con valores
adecuadamente en la ejecución.


*/