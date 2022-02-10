### Instructions
USE sakila;
#1. Rank films by length (filter out the rows that have nulls or 0s in length column).
# In your output, only select the columns title, length, and the rank.  

SELECT title, length, RANK() OVER (ORDER BY length DESC) AS 'rank_film_length'
FROM 
	film
WHERE 
	length > 0 OR length != NULL;
    

#2. Rank films by length within the `rating` category 
# (filter out the rows that have nulls or 0s in length column). 
# In your output, only select the columns title, length, rating and the rank.  

SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS 'rank_film_length'
FROM 
	film
WHERE 
	length > 0 OR length != NULL;


#3. How many films are there for each of the categories in the category table. 
#Use appropriate join to write this query

SELECT
	category.name, COUNT(film_category.film_id) AS num_films
FROM
	category
JOIN
	film_category
ON 
	category.category_id = film_category.category_id
GROUP BY
	category.name;
    
#4. Which actor has appeared in the most films?

SELECT
	actor.actor_id, COUNT(film_actor.film_id) AS count_actor_in_film
FROM
	actor
JOIN
	film_actor
ON 
	actor.actor_id = film_actor.actor_id
GROUP BY
	film_actor.actor_id
ORDER BY 
	count_actor_in_film DESC
LIMIT 1;
    
#5. Most active customer (the customer that has rented the most number of films)
SELECT
	customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id) AS count_rentals
FROM
	customer
JOIN
	rental
ON 
	customer.customer_id = rental.customer_id
GROUP BY
	customer.customer_id, customer.first_name, customer.last_name
ORDER BY 
	count_rentals DESC
LIMIT 1;