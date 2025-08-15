/* 
by Ricardo Fabian
 */


--1. Vamos a seleccionar el nombre y apellido de los actores
SELECT a.first_name, a.last_name
FROM actor a
	


--2. Vamos a seleccionar el nombre completo del actor en una sola columna
SELECT a.first_name + ' ' + a.last_name AS NombreActores
FROM actor a
	


--3. Selecciona los actores que su nombre empieza con "D"
SELECT first_name
FROM actor 
WHERE first_name LIKE 'D%'
	


--4. ¿Tenemos algún actor con el mismo nombre?
SELECT first_name, COUNT(*) AS Repeticiones
FROM actor
GROUP BY first_name HAVING COUNT(*) > 1
	


--5. ¿Cuál es el costo máximo de renta de una película?
SELECT MAX(amount) AS PrecioMax
FROM payment

	

--6. ¿Cuáles son las peliculas que fueron rentadas con ese costo?	
SELECT	p.amount, f.title
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE p.amount = (SELECT MAX(amount) FROM payment)
	


--7. ¿Cuantás películas hay por el tipo de audencia (rating)?
SELECT rating, COUNT(*) AS total
FROM film
GROUP BY rating



--8. Selecciona las películas que no tienen un rating R o NC-17
SELECT title, rating
FROM film
WHERE rating NOT IN('R', 'NC-17')


	
--9. ¿Cuantos clientes hay en cada tienda?
SELECT store_id, COUNT(*) AS total
FROM customer
GROUP BY store_id

	

--10. ¿Cuál es la pelicula que mas veces se rento?
SELECT f.title, COUNT(*) AS totalCompra
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title 
ORDER BY totalCompra DESC 



--11. ¿Qué peliculas no se han rentado?
SELECT title
FROM film
WHERE title NOT IN (
					SELECT f.title
					FROM payment p
					JOIN rental r ON p.rental_id = r.rental_id
					JOIN inventory i ON r.inventory_id = i.inventory_id
					JOIN film f ON i.film_id = f.film_id
					GROUP BY f.title 
)
	
	
	
--12. ¿Qué clientes no han rentado ninguna película?
SELECT first_name
FROM customer
WHERE customer_id NOT IN (
						SELECT c.customer_id
						FROM customer c
						JOIN rental r ON c.customer_id = r.customer_id
						GROUP BY c.customer_id 
)
--Parece que no se tienen datos de clientes que no hallan rentado ninguna pelicula


	
--13. ¿Qué actores han actuado en más de 30 películas?
SELECT first_name +' '+ last_name AS ActorName
FROM actor
WHERE actor_id IN (
				SELECT f.actor_id--, COUNT(*) AS total
				FROM film_actor f
				GROUP BY f.actor_id 
				HAVING COUNT(*) > 30 
				--ORDER BY total
)



--14. Muestra las ventas totales por tienda
SELECT store_id, COUNT(*) AS totalVentas
FROM customer
GROUP BY store_id

	

--15. Muestra los clientes que rentaron una pelicula más de una vez
SELECT c.first_name +' '+ c.last_name AS CustomerName
FROM customer c
WHERE customer_id IN (
				SELECT customer_id
				FROM rental
				GROUP BY customer_id 
				HAVING COUNT(*) > 1

)
