/**

name	    continent   	area	    population  	gdp
Afghanistan	Asia	    652230  	25500100	    20343000000
Albania	    Europe	    28748	    2831741	        12960000000
Algeria	    Africa	    2381741	    37100000	    188681000000
Andorra	    Europe	    468	78115	3712000000
Angola	    Africa	    1246700	    20609294	1   00990000000
**/


/*
  Shows the population for Germany
*/

SELECT population FROM world
WHERE name = 'Germany';

/*
  Shows the name and the population for 'Sweden', 'Norway' and 'Denmark'.
*/

SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway','Denmark');

/*
  Shows the name and the area between a range
*/

SELECT name, area FROM world
WHERE area BETWEEN 200000 AND 250000;