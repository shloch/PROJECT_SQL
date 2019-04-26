/** ------------ <world> table ---------------------------------------------
 name	        continent
Afghanistan	    Asia
Albania	        Europe
Algeria	        Africa
Andorra	        Europe
Angola	        Africa
------------------------------------------------------------------------**/

/*
  1 - Find the country that start with Y
*/

SELECT name FROM world
WHERE name LIKE 'Y%'

/*
  2 - Find the countries that end with y
*/

SELECT name FROM world
WHERE name LIKE '%y'

/*
  3 - Luxembourg has an x - so does one other country. List them both.
        Find the countries that contain the letter x
*/

SELECT name FROM world
WHERE name LIKE '%x%'

/*
  4 - Iceland, Switzerland end with land - but are there others?
        Find the countries that end with land
*/

SELECT name FROM world
WHERE name LIKE '%land'

/*
  5 - Columbia starts with a C and ends with ia - there are two more like this.
        Find the countries that start with C and end with ia
*/

SELECT name FROM world
WHERE name LIKE 'C%ia'

/*
  6 - Greece has a double e - who has a double o?
        Find the country that has oo in the name
*/

SELECT name FROM world
WHERE name LIKE '%oo%'

/*
  7 - Bahamas has three a - who else?
        Find the countries that have three or more a in the name
*/

SELECT name FROM world
WHERE name LIKE '%a%a%a%'

/*
  8 - India and Angola have an n as the second character. You can use the underscore as a single character wildcard.

SELECT name FROM world
 WHERE name LIKE '_n%'
ORDER BY name
Find the countries that have "t" as the second character.
*/

SELECT name FROM world
WHERE name LIKE '_t%'
ORDER BY name

/*
  9 - Lesotho and Moldova both have two o characters separated
   by two other characters.

    Find the countries that have two "o" characters separated by
     two others.
*/

SELECT name FROM world
WHERE name LIKE '%o__o%'

/*
  10 - Cuba and Togo have four characters names.
    Find the countries that have exactly four characters.
*/

SELECT name FROM world
WHERE name LIKE '____'


/*
  11 - The capital of Luxembourg is Luxembourg. Show all the 
  countries where the capital is the same as the name of the country
    Find the country where the name is the capital city.
*/

SELECT name
FROM world
WHERE name LIKE capital

/*
  12 - The capital of Mexico is Mexico City. Show all the countries
   where the capital has the country together with the word "City".
    Find the country where the capital is the country plus "City".
    (use concat function)
*/

SELECT name 
FROM world
WHERE capital LIKE concat(name,' City')

/*
  13 - Find the capital and the name where the capital includes the name of the country.
*/

SELECT capital, name
FROM world
WHERE capital LIKE concat('%',name,'%')