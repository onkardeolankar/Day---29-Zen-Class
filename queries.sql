-- Exercise 1 — Tasks
-- Find the title of each film ✓
-- Find the director of each film ✓
-- Find the title and director of each film ✓
-- Find the title and year of each film ✓
-- Find all the information about each film ✓

select title from movies;
select director from movies;
select title,director from movies;
select title,year from movies;
select * from movies;


-- Exercise 2 — Tasks
-- Find the movie with a row id of 6 ✓
-- Find the movies released in the years between 2000 and 2010 ✓
-- Find the movies not released in the years between 2000 and 2010 ✓
-- Find the first 5 Pixar movies and their release year ✓

SELECT * FROM movies where id=6;
SELECT * FROM movies where year between 2000 and 2010;
SELECT * FROM movies where year not between 2000 and 2010;
SELECT * FROM movies where id in(1,2,3,4,5);

-- Exercise 3 — Tasks
-- Find all the Toy Story movies ✓
-- Find all the movies directed by John Lasseter ✓
-- Find all the movies (and director) not directed by John Lasseter ✓
-- Find all the WALL-* movies ✓

SELECT * FROM movies where title like "Toy Story%";
SELECT * FROM movies where director="John Lasseter";
SELECT * FROM movies where director !="John Lasseter";
SELECT * FROM movies where title like "WALL-_";


-- Exercise 4 — Tasks
-- List all directors of Pixar movies (alphabetically), without duplicates ✓
-- List the last four Pixar movies released (ordered from most recent to least) ✓
-- List the first five Pixar movies sorted alphabetically ✓
-- List the next five Pixar movies sorted alphabetically ✓

SELECT DISTINCT director FROM movies order by director asc;
SELECT distinct title FROM movies order by year desc limit 4;
SELECT * FROM movies order by title asc limit 5;
SELECT * FROM movies order by title asc limit 5 OFFSET 5;


-- Review 1 — Tasks
-- List all the Canadian cities and their populations ✓
-- Order all the cities in the United States by their latitude from north to south ✓
-- List all the cities west of Chicago, ordered from west to east ✓
-- List the two largest cities in Mexico (by population) ✓
-- List the third and fourth largest cities (by population) in the United States and their population ✓

SELECT * FROM north_american_cities where Country="Canada" and Population;
SELECT city FROM north_american_cities where Country="United States" order by latitude desc;
SELECT city FROM north_american_cities WHERE longitude < -87.629798 ORDER BY longitude;
SELECT * FROM north_american_cities where country="Mexico" order by population desc limit 2;
SELECT * FROM north_american_cities where country="United States" order by population desc limit 2 offset 2;


-- Exercise 6 — Tasks
-- Find the domestic and international sales for each movie ✓
-- Show the sales numbers for each movie that did better internationally rather than domestically ✓
-- List all the movies by their ratings in descending order ✓

SELECT Title,Domestic_sales,International_sales FROM movies INNER JOIN boxoffice ON movies.id = boxoffice.movie_id;
SELECT title, domestic_sales, international_sales FROM movies INNER JOIN boxoffice ON movies.id = boxoffice.movie_id WHERE international_sales > domestic_sales;
SELECT title, rating FROM movies INNER JOIN boxoffice ON movies.id = boxoffice.movie_id ORDER BY rating DESC;


-- Exercise 7 — Tasks
-- Find the list of all buildings that have employees ✓
-- Find the list of all buildings and their capacity ✓
-- List all buildings and the distinct employee roles in each building (including empty buildings) ✓

SELECT DISTINCT building FROM employees;
SELECT * FROM buildings;
SELECT DISTINCT building_name, role FROM buildings LEFT JOIN employees ON building_name = employees.building;


-- Exercise 8 — Tasks
-- Find the name and role of all employees who have not been assigned to a building ✓
-- Find the names of the buildings that hold no employees ✓

SELECT * FROM employees where Building is null;
SELECT * from Buildings left join Employees on Building_name= Building where building is null;


-- Exercise 9 — Tasks
-- List all movies and their combined sales in millions of dollars ✓
-- List all movies and their ratings in percent ✓
-- List all movies that were released on even number years ✓

SELECT *,(Domestic_sales+ International_sales)/1000000 as Total_Sales 
FROM movies
inner join BoxOffice
on id=movie_id;
SELECT DISTINCT
    title,
    (rating * 10) AS rate_percent
FROM movies
INNER JOIN boxoffice
    ON movies.id = boxoffice.movie_id;
    SELECT title FROM movies WHERE year % 2 = 0;


-- Exercise 10 — Tasks
-- Find the longest time that an employee has been at the studio ✓
-- For each role, find the average number of years employed by employees in that role ✓
-- Find the total number of employee years worked in each building ✓

SELECT Name, max(Years_employed) FROM employees;
SELECT * ,avg(Years_employed) FROM employees group by role;
SELECT Building, SUM(Years_Employed) 
FROM Employees
GROUP BY Building;

-- Exercise 11 — Tasks
-- Find the number of Artists in the studio (without a HAVING clause) ✓
-- Find the number of Employees of each role in the studio ✓
-- Find the total number of years employed by all Engineers ✓

SELECT Role,Count(Role) FROM employees where Role="Artist";
SELECT Role,Count(Role) FROM employees group by Role;
SELECT SUM(Years_employed) FROM employees where Role="Engineer";


-- Exercise 12 — Tasks
-- Find the number of movies each director has directed ✓
-- Find the total domestic and international sales that can be attributed to each director ✓

SELECT *, count(title)FROM movies group by Director;
SELECT *, sum(Domestic_sales+International_sales)FROM movies left join Boxoffice on id=movie_id group by Director;


-- Exercise 13 — Tasks
-- Add the studio's new production, Toy Story 4 to the list of movies (you can use any director) ✓
-- Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table. ✓

Insert into Movies(Id,Title,Director,Year,Length_minutes) values(4,"Toy Story 4","John Lasseter",2019,110);
Insert into Boxoffice(Movie_id,Rating,Domestic_sales,International_sales) values(4,8.7,340000000,270000000);


-- Exercise 14 — Tasks
-- The director for A Bug's Life is incorrect, it was actually directed by John Lasseter ✓
-- The year that Toy Story 2 was released is incorrect, it was actually released in 1999 ✓
-- Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich ✓

update Movies set Director="John Lasseter" where Title="A Bug's Life";
update Movies set Year=1999 where Title="Toy Story 2";
update Movies set Title="Toy Story 3",Director="Lee Unkrich" where Id=11;


-- Exercise 15 — Tasks
-- This database is getting too big, lets remove all movies that were released before 2005. ✓
-- Andrew Stanton has also left the studio, so please remove all movies directed by him. ✓

delete FROM movies where year<2005;
delete FROM movies where Director="Andrew Stanton";


-- Exercise 16 — Tasks
-- Create a new table named Database with the following columns:
-- – Name A string (text) describing the name of the database
-- – Version A number (floating point) of the latest version of this database
-- – Download_count An integer count of the number of times this database was downloaded
-- This table has no constraints. ✓

Create table Database(Name string,Version number,Download_count);


-- Exercise 17 — Tasks
-- Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in. ✓
-- Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English. ✓

alter table Movies add Aspect_ratio Float;
alter table Movies add Language TEXT default English;


-- Exercise 18 — Tasks
-- We've sadly reached the end of our lessons, lets clean up by removing the Movies table ✓
-- And drop the BoxOffice table as well ✓

Drop table movies;
Drop table BoxOffice;

-- ============================================End==================================================================


