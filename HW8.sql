USE sakila;

-- 1a: 
SELECT first_name, last_name FROM sakila.actor;
-- 1b:
SELECT concat(first_name, " ", last_name) as `Actor Name` FROM sakila.actor;
-- 2a:
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';
-- 2b:
SELECT * FROM actor
WHERE last_name LIKE '%GEN%';
-- 2c:
SELECT last_name, first_name FROM actor
WHERE last_name LIKE '%LI%';
-- 2d:
SELECT * FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
-- 4a:
SELECT last_name, count(last_name) as count FROM actor
GROUP BY last_name;
-- 4b:
SELECT last_name, count(last_name) as count FROM actor
GROUP BY last_name HAVING count >= 2;
-- 4c:
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';
-- 4d:
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';
-- 5a:
SHOW CREATE TABLE address;
-- 6a:
SELECT first_name, last_name, address FROM actor
JOIN address ON actor.actor_id = address.address_id;
-- 6b:
SELECT staff_id, first_name, last_name, SUM(amount)  FROM staff
JOIN payment USING(staff_id)
WHERE payment_date LIKE '2005-08%'
GROUP BY staff_id;
-- 6c:
SELECT film.title, count(actor_id) as `actor_count` FROM film
JOIN film_actor USING (film_id)
GROUP BY film.title;
-- 6d:
SELECT title, count(inventory_id) as inventory_count FROM inventory
JOIN film USING (film_id)
WHERE title = 'Hunchback Impossible';
-- 6e:
SELECT customer_id, last_name, first_name, sum(amount) FROM payment
JOIN customer USING (customer_id)
GROUP BY customer_id
ORDER BY last_name;
-- 7a:
SELECT title, language_id FROM film
WHERE language_id IN
(
SELECT language_id FROM language 
WHERE name = 'English'
)
AND title LIKE 'K%'
OR title LIKE 'Q%';
 -- 7b:
 SELECT actor_id, first_name, last_name FROM actor
 WHERE actor.actor_id IN
 (
 SELECT actor_id FROM film_actor
 WHERE film_actor.film_id IN
 (
 SELECT film_id FROM film
 WHERE title = 'Alone Trip'
 ));
 -- 7c:
 SELECT first_name, last_name, email, country FROM customer
 LEFT JOIN address ON customer.address_id = address.address_id
 LEFT JOIN city ON address.city_id = city.city_id
 LEFT JOIN country ON city.country_id = country.country_id
 WHERE country = 'Canada';
 -- 7d:
 SELECT * FROM film
 WHERE film_id IN 
 ( 
 SELECT film_id FROM film_category
 WHERE category_id IN
 (
 SELECT category_id FROM category
 WHERE `name` = 'Family'
 ));
 -- 7e:
SELECT title, count(rental_id) as rental_count FROM rental
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
GROUP BY title
ORDER BY rental_count DESC;
-- 7f:
SELECT store_id, sum(amount) as total_rental_dollar_amount FROM store
JOIN staff USING (store_id)
JOIN rental USING (staff_id)
JOIN payment USING (rental_id)
GROUP BY store_id;
-- 7g:
SELECT store_id, city, country FROM store
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id);
-- 7h:
SELECT name category, sum(amount) gross_revenue FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
GROUP BY category
ORDER BY gross_revenue DESC;
-- 8a:
CREATE VIEW top_five_genre AS 
SELECT name category, sum(amount) gross_revenue FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
GROUP BY category
ORDER BY gross_revenue DESC LIMIT 5;
-- 8b:
SELECT * FROM top_five_genre;
-- 8c:
DROP VIEW top_five_genre;
