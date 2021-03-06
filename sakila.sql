USE sakila ;

/*1. ¿Qué consulta ejecutarías para obtener todos los clientes dentro de city_id = 312? Su consulta debe devolver el nombre, 
apellido, correo electrónico y dirección del cliente. */
SELECT cit.city_id, cit.city, cus.first_name, cus.last_name, cus.email, ads.address
FROM customer cus
JOIN address ads ON ads.address_id=cus.address_id
JOIN city cit ON ads.city_id=cit.city_id
WHERE cit.city_id= 312 ;

/*2. ¿Qué consulta harías para obtener todas las películas de comedia? Su consulta debe devolver el título de la 
película, la descripción, el año de estreno, la calificación, las características especiales y el género (categoría). */

SELECT f.film_id, f.title , f.description, f.release_year, f.rating, f.special_features ,cat.name
FROM film f
JOIN film_category fcat ON fcat.film_id= f.film_id
JOIN category cat ON cat.category_id=fcat.category_id
WHERE cat.name= 'Comedy' ;

/*3. ¿Qué consulta harías para obtener todas las películas unidas por actor_id = 5? Su consulta debe devolver 
la identificación del actor, el nombre del actor, el título de la película, la descripción y el año de lanzamiento. */

SELECT act.actor_id, CONCAT(act.first_name,' ', act.last_name) actor_name, f.title, f.description, f.release_year
FROM film f
JOIN film_actor fact ON fact.film_id= f.film_id
JOIN actor act ON act.actor_id=fact.actor_id
WHERE act.actor_id=5 ;

/*4. ¿Qué consulta ejecutaría para obtener todos los clientes en store_id = 1 y dentro de estas ciudades 
(1, 42, 312 y 459)? Su consulta debe devolver el nombre, apellido, correo electrónico y dirección del cliente. */

SELECT str.store_id, cit.city_id , cus.first_name, cus.last_name, cus.email, ads.address
FROM customer cus
JOIN address ads ON ads.address_id=cus.address_id
JOIN city cit ON ads.city_id=cit.city_id
JOIN store str ON str.store_id=cus.store_id
WHERE str.store_id=1
AND cit.city_id IN (1, 42, 312, 459) ;

/*5. ¿Qué consulta realizarías para obtener todas las películas con una "calificación = G" y 
"característica especial = detrás de escena", unidas por actor_id = 15? Su consulta debe devolver el título de la película, 
la descripción, el año de lanzamiento, la calificación y la función especial. Sugerencia: puede usar la 
función LIKE para obtener la parte 'detrás de escena'. */

SELECT f.film_id, act.actor_id, f.title , f.description, f.release_year, f.rating, f.special_features 
FROM film f
JOIN film_actor fact ON fact.film_id= f.film_id
JOIN actor act ON act.actor_id=fact.actor_id
WHERE f.rating= 'G'
AND f.special_features LIKE '%Behind%'
AND act.actor_id=15 ;

/*6. ¿Qué consulta harías para obtener todos los actores que se unieron en el film_id = 369? Su consulta debe devolver film_id, title, 
actor_id y actor_name. */

SELECT f.film_id, act.actor_id, f.title , CONCAT(act.first_name,' ', act.last_name) actor_name
FROM film f
JOIN film_actor fact ON fact.film_id= f.film_id
JOIN actor act ON act.actor_id=fact.actor_id
WHERE f.film_id= 369 ;

/*7. ¿Qué consulta harías para obtener todas las películas dramáticas con una tarifa de alquiler de 2.99? Su consulta debe devolver 
el título de la película, la descripción, el año de estreno, la calificación, las características especiales y el género (categoría). */

SELECT f.film_id, f.title , f.description, f.release_year, f.rating, f.special_features, cat.name categoria, f.rental_rate
FROM film f
JOIN film_category fcat ON fcat.film_id= f.film_id
JOIN category cat ON cat.category_id=fcat.category_id
WHERE f.rental_rate=2.99
AND cat.name= 'Drama' ;

/*8. ¿Qué consulta harías para obtener todas las películas de acción a las que se une SANDRA KILMER? Su consulta debe devolver el 
título de la película, la descripción, el año de estreno, la calificación, las características especiales, el género (categoría) 
y el nombre y apellido del actor.*/

SELECT f.film_id, act.actor_id, f.title , f.description, f.release_year, f.rating, f.special_features, cat.name categoria, CONCAT(act.first_name,' ', act.last_name) actor_name
FROM film f
JOIN film_category fcat ON fcat.film_id= f.film_id
JOIN category cat ON cat.category_id=fcat.category_id
JOIN film_actor fact ON fact.film_id= f.film_id
JOIN actor act ON act.actor_id=fact.actor_id
WHERE cat.name= 'Action' 
and act.first_name= 'Sandra'
and act.last_name='Kilmer' ;