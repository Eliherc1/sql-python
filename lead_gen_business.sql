USE lead_gen_business;	

SELECT * FROM billing;
SELECT * FROM clients;
SELECT * FROM leads ;
SELECT * FROM sites;

/*1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012? */
SELECT  MONTHNAME(charged_datetime) MES, SUM(amount) AS MONTO
FROM billing
WHERE charged_datetime BETWEEN '2012-03-01' AND '2012-03-31' 
GROUP BY MES;

/* 2. ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados del cliente con una identificación de 2?*/
SELECT SUM(amount) TOTAL, client_id
FROM billing
WHERE client_id=2 ;

/*3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?*/
SELECT sit.domain_name, cli.client_id
FROM sites sit
JOIN clients cli ON sit.client_id=cli.client_id
WHERE cli.client_id= 10 ;

/*4. ¿Qué consulta ejecutaría para obtener el número total de sitios creados por mes por año para el cliente con una identificación de 1? 
¿Qué pasa con el cliente = 20? */
SELECT cli.client_id, COUNT(sit.domain_name) cant_sitios, MONTHNAME(sit.created_datetime) mes, YEAR(sit.created_datetime) año
FROM sites sit
JOIN clients cli ON sit.client_id=cli.client_id
WHERE cli.client_id= 1 
GROUP BY cli.client_id, mes, año ;
SELECT cli.client_id, COUNT(sit.domain_name) cant_sitios, MONTHNAME(sit.created_datetime) mes, YEAR(sit.created_datetime) año
FROM sites sit
JOIN clients cli ON sit.client_id=cli.client_id
WHERE cli.client_id= 20 
GROUP BY cli.client_id, mes, año ;

/*5. ¿Qué consulta ejecutaría para obtener el número total de clientes potenciales generados para cada uno de los sitios entre el 
	1 de enero de 2011 y el 15 de febrero de 2011? */
SELECT sit.domain_name Sitio, COUNT(lea.leads_id) cantidad, lea.registered_datetime
FROM leads lea
JOIN sites sit ON sit.site_id=lea.site_id
WHERE lea.registered_datetime BETWEEN '2011-01-01' AND '2011-02-15' 
GROUP BY sit.domain_name, lea.registered_datetime ;

/*6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que 
hemos generado para cada uno de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? */

SELECT COUNT(lea.leads_id) AS Clientes_potenciales, CONCAT(cli.first_name,' ',cli.last_name) as Nombre
FROM leads lea
JOIN sites sit ON sit.site_id=lea.site_id
JOIN clients cli ON sit.client_id=cli.client_id
WHERE lea.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31' 
GROUP BY NOMBRE ;

/*7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que 
hemos generado para cada cliente cada mes entre los meses 1 y 6 del año 2011? */

SELECT CONCAT(cli.first_name,' ',cli.last_name) as nombre, COUNT(lea.leads_id) AS Clientes_potenciales, MONTHNAME(lea.registered_datetime) AS mes
FROM leads lea
JOIN sites sit ON sit.site_id=lea.site_id
JOIN clients cli ON sit.client_id=cli.client_id
WHERE lea.registered_datetime BETWEEN '2011-01-01' AND '2011-06-30' 
GROUP BY nombre, mes 
ORDER BY mes;

/*8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales 
que hemos generado para cada uno de los sitios de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? 
Solicite esta consulta por ID de cliente. Presente una segunda consulta que muestre todos los clientes, los nombres del sitio y 
el número total de clientes potenciales generados en cada sitio en todo momento. */

SELECT 
CONCAT(cli.first_name,' ',cli.last_name) as NOMBRE,
sit.domain_name SITIO,
count(lea.leads_id) CLI_POTENCIALES,
min(lea.registered_datetime) FECHA
FROM clients cli
JOIN sites sit ON sit.client_id=cli.client_id
JOIN leads lea ON lea.site_id=sit.site_id
WHERE 
lea.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31' 
GROUP BY NOMBRE, SITIO
ORDER BY NOMBRE ;

SELECT 
CONCAT(cli.first_name,' ',cli.last_name) as NOMBRE,
sit.domain_name SITIO,
COUNT(lea.leads_id) CLI_POTENCIALES,
MIN(CONCAT(MONTHNAME(lea.registered_datetime), ' ',DAY(lea.registered_datetime), ', ' ,YEAR(lea.registered_datetime))) FECHA
FROM clients cli
JOIN sites sit ON sit.client_id=cli.client_id
JOIN leads lea ON lea.site_id=sit.site_id
WHERE 
lea.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31' 
GROUP BY NOMBRE, SITIO
ORDER BY NOMBRE ;

SELECT 
CONCAT(cli.first_name,' ',cli.last_name) as NOMBRE,
sit.domain_name SITIO,
count(lea.leads_id) CLI_POTENCIALES
FROM clients cli
LEFT JOIN sites sit ON sit.client_id=cli.client_id
LEFT JOIN leads lea ON lea.site_id=sit.site_id 
GROUP BY NOMBRE, SITIO
ORDER BY NOMBRE ;

/*9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente para cada mes del año. 
Pídalo por ID de cliente. */

SELECT cli.client_id ID_CLI, 
CONCAT(cli.first_name,' ',cli.last_name) as NOMBRE, 
SUM(bil.amount) TOTAL, 
MONTHNAME(bil.charged_datetime) AS MES, 
YEAR(bil.charged_datetime) AS AÑO
FROM billing bil
JOIN clients cli ON bil.client_id=cli.client_id
GROUP BY cli.client_id, NOMBRE, MES, AÑO ;


/*10. Escriba una sola consulta que recupere todos los sitios que posee cada cliente. Agrupe los resultados para que cada fila muestre 
un nuevo cliente. Se volverá más claro cuando agregue un nuevo campo llamado 'sitios' que tiene todos los sitios que posee 
el cliente. (SUGERENCIA: use GROUP_CONCAT) */


SELECT 
CONCAT(cli.first_name,' ',cli.last_name) as NOMBRE_CLIENTE , 
GROUP_CONCAT(
    DISTINCT(COALESCE(NULL,sit.domain_name,'Sin Información'))
    ORDER BY sit.domain_name
    SEPARATOR ' / '
) SITIOS
FROM sites sit
RIGHT JOIN clients cli ON sit.client_id=cli.client_id
GROUP BY  NOMBRE_CLIENTE ;
