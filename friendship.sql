USE amigos;

SELECT * FROM users ;
SELECT * FROM friendships ;

/*Crea una base de datos llamada "amigos" y luego importe friends.sql. Esto creará dos nuevas tablas: usuarios y amistades.
Usando el siguiente ERD como referencia, escribe una consulta SQL que devuelva una lista de usuarios junto con los nombres de sus amigos. */

SELECT fr.user_id, us.first_name, us.last_name, fr.friend_id, amigo.first_name nombre_amigo, amigo.last_name apellido_amigo
FROM users us
JOIN friendships fr ON us.id= fr.user_id
JOIN users as amigo ON amigo.id= fr.friend_id;

/*1.Devuelva a todos los usuarios que son amigos de Kermit, asegúrese de que sus nombres se muestren en los resultados. */

SELECT fr.user_id, us.first_name, us.last_name, fr.friend_id, amigo.first_name nombre_amigo, amigo.last_name apellido_amigo
FROM users us
JOIN friendships fr ON us.id= fr.user_id
JOIN users as amigo ON amigo.id= fr.friend_id
WHERE us.first_name='Kermit' ;

/*2.Devuelve el recuento de todas las amistades.*/
SELECT COUNT(*) cantidad_amistades
FROM users us
JOIN friendships fr ON us.id= fr.user_id
JOIN users as amigo ON amigo.id= fr.friend_id;

/*3.Descubre quién tiene más amigos y devuelve el recuento de sus amigos.*/
SELECT us.first_name, us.last_name, COUNT(us.id) cant_amistades
FROM users us
JOIN friendships fr ON us.id= fr.user_id
JOIN users as amigo ON amigo.id= fr.friend_id
GROUP BY us.id, us.first_name, us.last_name ;

/*4.Crea un nuevo usuario y hazlos amigos de Eli Byers , Kermit The Frog  y Marky Mark . */

INSERT INTO users (first_name, last_name, created_at) VALUES ('Eliza', 'Thornberry', '2021-07-24 11:48:00');

/*5.Devuelve a los amigos de Eli en orden alfabético.*/
SELECT fr.friend_id, amigo.first_name nombre_amigo, amigo.last_name apellido_amigo
FROM users us
JOIN friendships fr ON us.id= fr.user_id
JOIN users as amigo ON amigo.id= fr.friend_id
WHERE us.first_name='Eli' 
ORDER BY us.first_name ASC;

/*6.Eliminar a Marky Mark de los amigos de Eli. */

DELETE FROM friendships
WHERE id=5 ;

/*7.Devuelve todas las amistades, mostrando solo el nombre y apellido de ambos amigos*/
SELECT CONCAT(us.first_name,' ', us.last_name) usuario, CONCAT(amigo.first_name,' ', amigo.last_name) amigo
FROM users us
JOIN friendships fr ON us.id= fr.user_id
JOIN users as amigo ON amigo.id= fr.friend_id;