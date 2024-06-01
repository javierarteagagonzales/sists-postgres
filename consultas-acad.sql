/*PARTE I: ACADÉMICO
1. Elabore una sentencia SELECT que permita capturar los datos principales
(nombre, apellido y teléfono) de todos los alumnos que viven en la ciudad de “LOS
ANGELES” y cuyo apellido contiene la letra “r”.*/
SELECT s.first_name, s.last_name, s.phone
FROM student s 
JOIN zipcode z ON s.zip = z.zip
WHERE z.city='LOS ANGELES' AND last_name LIKE '%r%';


/*2. Elabore una sentencia SELECT que permita imprimir un reporte con los docentes
(considere solamente nombre y apellido) y la cantidad de secciones que tiene asignado
cada uno de ellos. Muestre solamente información de los docentes que tengan más de
una sección.*/
SELECT i.first_name, i.last_name, COUNT(s.section_id) AS Secciones
FROM instructor i
JOIN section s ON i.instructor_id = s.instructor_id
GROUP BY first_name, last_name
HAVING COUNT(section_id) > 1

/*3. Elabore una sentencia SELECT que permita obtener una “boleta de matrícula”
para un alumno determinado. Debe mostrarse los cursos y secciones en los cuales se
encuentra matriculado, así como el profesor a cargo. Considere los campos que crea
conveniente.*/

SELECT s.student_id, se.section_no, c.description, i.first_name
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section se ON e.section_id = se.section_id
JOIN course c ON se.course_no = c.course_no
JOIN instructor i ON se.instructor_id = i.instructor_id


/*4. Muestre un reporte de disponibilidad de todas las secciones. Debe considerar el
nombre del curso, el nombre del docente a cargo, la capacidad de la sección y la cantidad
de vacantes disponibles.*/

SELECT section_id, c.description, i.first_name, se.capacity, 
	(se.capacity - (SELECT COUNT(*) FROM enrollment en
	WHERE se.section_id = en.section_id )) AS Vacant_disp
FROM section se
JOIN course c ON se.course_no = c.course_no
JOIN instructor i ON se.instructor_id = i.instructor_id


/*5. Muestre los datos de todos aquellos cursos que tengan 
	una cantidad total de alumnos matriculados menor 
	que el promedio general considerando todos los cursos.*/

SELECT C.COURSE_NO, C.DESCRIPTION, T.Total_Alumnos
FROM COURSE C
JOIN (-- matriculados en cada curso
    SELECT S.COURSE_NO, COUNT(E.STUDENT_ID) AS Total_Alumnos
    FROM SECTION S
    JOIN ENROLLMENT E ON S.SECTION_ID = E.SECTION_ID
    GROUP BY S.COURSE_NO
) AS T ON C.COURSE_NO = T.COURSE_NO
WHERE T.Total_Alumnos < (SELECT AVG(Total_Alumnos) -- Promedio en todos los cursos
    FROM ( SELECT S.COURSE_NO, COUNT(E.STUDENT_ID) AS Total_Alumnos
        FROM SECTION S
        JOIN ENROLLMENT E ON S.SECTION_ID = E.SECTION_ID
        GROUP BY S.COURSE_NO ) AS Subquery );



select * from section

