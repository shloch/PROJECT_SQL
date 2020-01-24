/** ------------ <movie> table ---------------------------------------------
 id	    title	                    yr	    director	budget  	gross
10003	"Crocodile" Dundee II	    1988	38	        15800000	239606210
10004	'Til There Was You	        1997	49	        10000000

------------ <actor> table ---------------------------------------------
 id	    name
20	    Paul Hogan
50	    Jeanne Tripplehorn

------------ <casting> table ---------------------------------------------
movieid	    actorid	    ord
10003	    20	        4
10004	    50	        1


This tutorial introduces the notion of a join. The database consists of 
three tables movie , actor and casting 
------------------------------------------------------------------------**/

/*
  1 - List the films where the yr is 1962 [Show id, title]
*/

SELECT id, title
FROM movie
WHERE yr=1962


/*
  2 - Give year of 'Citizen Kane'.
*/

SELECT yr
FROM movie
WHERE title='Citizen Kane'


/*
  3 - List all of the Star Trek movies, include the id, title and yr 
  (all of these movies include the words Star Trek in the title). 
  Order results by year.
*/

SELECT id, title,yr
FROM movie
WHERE title like '%Star Trek%'
ORDER BY yr

/*
  4 - What id number does the actor 'Glenn Close' have?
*/

SELECT id
FROM actor
WHERE name = 'Glenn Close' 

/*
  5 - What is the id of the film 'Casablanca'
*/

SELECT id
FROM movie
WHERE title = 'Casablanca' 

/*
  6 - Obtain the cast list for 'Casablanca'.

what is a cast list?
Use movieid=11768, (or whatever value you got from the previous question)
*/


SELECT name 
FROM casting c
INNER JOIN movie m ON  m.id = c.movieid
INNER JOIN actor a ON  a.id = c.actorid
WHERE title = 'Casablanca'

/*
  7 - Obtain the cast list for the film 'Alien'
*/

SELECT name 
FROM casting c
INNER JOIN movie m ON  m.id = c.movieid
INNER JOIN actor a ON  a.id = c.actorid
WHERE title = 'Alien'

/*
  8 - List the films in which 'Harrison Ford' has appeared
*/

SELECT title 
FROM casting c
INNER JOIN movie m ON  m.id = c.movieid
INNER JOIN actor a ON  a.id = c.actorid
WHERE a.name = 'Harrison Ford' 

/*
  9 - List the films where 'Harrison Ford' has appeared - but not 
  in the starring role. [Note: the ord field of casting gives the
   position of the actor. If ord=1 then this actor is in the starring role]
*/

SELECT DISTINCT(title) 
FROM casting c
INNER JOIN movie m ON  m.id = c.movieid
INNER JOIN actor a ON  a.id = c.actorid
WHERE c.ord != '1' 
AND a.name = 'Harrison Ford' 

/*
  10 - List the films together with the leading star for all 1962 films.
*/

SELECT (title), name
FROM casting c
INNER JOIN movie m ON  m.id = c.movieid
INNER JOIN actor a ON  a.id = c.actorid
WHERE m.yr = '1962' 
AND c.ord = '1' 

/*
  11 - Which were the busiest years for 'John Travolta', show the year and the
  number of movies he made each year for any year in which he made more than 2 movies.

*/

SELECT yr,COUNT(title) FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=

        (SELECT MAX(c) FROM
                (SELECT yr,COUNT(title) AS c FROM
                 movie JOIN casting ON movie.id=movieid
                JOIN actor   ON actorid=actor.id
                WHERE name='John Travolta'
                GROUP BY yr) AS t
        )


/*
  12 - List the film title and the leading actor for all of the films 'Julie Andrews'
   played in.

    Did you get "Little Miss Marker twice"?
    Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original
    (1934).

    Title is not a unique field, create a table of IDs in your subquery
*/

SELECT title, name
FROM casting c
INNER JOIN movie m ON  (m.id = c.movieid)
INNER JOIN actor a ON  a.id = c.actorid
WHERE   ord = 1 AND m.id in
                        (SELECT m.id
                        FROM casting c
                        INNER JOIN movie m ON  (m.id = c.movieid)
                        INNER JOIN actor a ON  a.id = c.actorid
                        WHERE  a.name ='Julie Andrews' )



/*
  13 - Obtain a list, in alphabetical order, of actors who've had at 
  least 30 starring roles.
*/

SELECT name FROM actor WHERE id in 
(
    SELECT (actorid)
    FROM casting c
    INNER JOIN movie m ON  (m.id = c.movieid)
    INNER JOIN actor a ON  a.id = c.actorid
    WHERE ord =1 
    GROUP BY actorid
    HAVING COUNT(actorid) in
    (
        SELECT COUNT(actorid) from casting 
        GROUP BY movieid
        HAVING COUNT(actorid) >= 30
    )
)

/*
  14 - List the films released in the year 1978 ordered by the number \
  of actors in the cast, then by title.
*/

SELECT title, COUNT(actorid) AS cast
FROM movie 
JOIN casting ON id = movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC,title


/*
  15 - List all the people who have worked with 'Art Garfunkel'.
*/

SELECT DISTINCT name 
FROM actor 
JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting 
JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
GROUP BY name
