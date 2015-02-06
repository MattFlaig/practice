--JOINS

-- SELECT films.title, films.release_date, films.duration, films.description, directors.director_name, actors.actor_name, categories.category_name 
-- FROM films JOIN directors 
-- ON films.director_id = directors.directors_id 
-- JOIN actors_films
-- ON actors_films.actor_id = actors.actor_id 
-- JOIN categories_films
-- ON categories_films.category_id = categories.category_id\G; 



SELECT title, release_date, duration, description, director_name, actor_name, GROUP_CONCAT(DISTINCT category_name ORDER BY category_name AS categories)
FROM films,  
JOIN directors ON directors.director_id = films.director_id
JOIN actors_films ON actors_films.film_id = films.film_id 
JOIN actors ON actors.actor_id = actors_films.actor_id
JOIN categories_films ON categories_films.film_id = films.film_id 
JOIN categories ON categories.category_id = categories_films.category_id \G;


SELECT title, release_date, duration, description, director_name,
GROUP_CONCAT(DISTINCT actor_name ORDER BY actor_name) AS actors, GROUP_CONCAT(DISTINCT category_name ORDER BY category_name) AS categories 
FROM films f, directors d, actors_films af, actors a, categories_films cf, categories c 
WHERE f.director_id = d.director_id
AND f.film_id = af.film_id 
AND a.actor_id = af.actor_id
AND f.film_id = cf.film_id 
AND c.category_id = cf.category_id
GROUP BY f.title \G;



