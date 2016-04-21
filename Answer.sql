-- Revising the Select Query - 1
SELECT *
FROM CITY
WHERE POPULATION > 100000 AND COUNTRYCODE = "USA"

-- Revising the Select Query - 2
SELECT NAME
FROM CITY
WHERE POPULATION > 120000 AND COUNTRYCODE = "USA";

-- Select All
SELECT *
FROM CITY;

-- Select by ID
SELECT *
FROM CITY
WHERE ID = 1661;

-- Japanese Cities' Detail
SELECT *
FROM CITY
WHERE COUNTRYCODE = "JPN";

-- Japanese Cities' Name
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = "JPN";

-- Weather Observation Station 1
SELECT CITY, STATE
FROM STATION;

-- Weather Observation Station 3
SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0;

-- Weather Observation Station 4
SELECT count(city)-count(distinct city)
FROM STATION;

-- Weather Observation Station 5
SELECT 		min(main.City), len(main.City)
FROM 		STATION as main
WHERE		len(main.city) = (SELECT Min(len(STATION.city)) FROM STATION) OR 
		len(main.city) = (SELECT MAX(len(STATION.city)) FROM STATION)
GROUP BY 	len(main.City) ;

-- Weather Observation Station 6
SELECT DISTINCT CITY
FROM STATION
WHERE 
LEFT(CITY,1) = "a" OR
LEFT(CITY,1) = "e" OR
LEFT(CITY,1) = "i" OR
LEFT(CITY,1) = "o" OR
LEFT(CITY,1) = "u" 
;

-- Weather Observation Station 7
SELECT DISTINCT CITY
FROM STATION
WHERE 
RIGHT(CITY,1) = "a" OR
RIGHT(CITY,1) = "e" OR
RIGHT(CITY,1) = "i" OR
RIGHT(CITY,1) = "o" OR
RIGHT(CITY,1) = "u" 
;

-- Weather Observation Station 8
SELECT DISTINCT CITY
FROM STATION
WHERE 
(LEFT(CITY,1) = "a" OR
LEFT(CITY,1) = "e" OR
LEFT(CITY,1) = "i" OR
LEFT(CITY,1) = "o" OR
LEFT(CITY,1) = "u") 
AND
(RIGHT(CITY,1) = "a" OR
RIGHT(CITY,1) = "e" OR
RIGHT(CITY,1) = "i" OR
RIGHT(CITY,1) = "o" OR
RIGHT(CITY,1) = "u")
;

-- Weather Observation Station 9
SELECT DISTINCT CITY
FROM STATION
WHERE 
LEFT(CITY,1) <> "A" AND
LEFT(CITY,1) <> "E" AND
LEFT(CITY,1) <> "I" AND
LEFT(CITY,1) <> "O" AND
LEFT(CITY,1) <> "U" 
;

-- Weather Observation Station 10
SELECT DISTINCT CITY
FROM STATION
WHERE 
RIGHT(CITY,1) <> "A" AND
RIGHT(CITY,1) <> "E" AND
RIGHT(CITY,1) <> "I" AND
RIGHT(CITY,1) <> "O" AND
RIGHT(CITY,1) <> "U" 
;

-- Weather Observation Station 11
SELECT DISTINCT CITY
FROM STATION
WHERE 
(RIGHT(CITY,1) <> "A" AND
RIGHT(CITY,1) <> "E" AND
RIGHT(CITY,1) <> "I" AND
RIGHT(CITY,1) <> "O" AND
RIGHT(CITY,1) <> "U") OR
(LEFT(CITY,1) <> "A" AND
LEFT(CITY,1) <> "E" AND
LEFT(CITY,1) <> "I" AND
LEFT(CITY,1) <> "O" AND
LEFT(CITY,1) <> "U")
;

-- Weather Observation Station 12
SELECT DISTINCT CITY
FROM STATION
WHERE 
(RIGHT(CITY,1) <> "A" AND
RIGHT(CITY,1) <> "E" AND
RIGHT(CITY,1) <> "I" AND
RIGHT(CITY,1) <> "O" AND
RIGHT(CITY,1) <> "U") AND
(LEFT(CITY,1) <> "A" AND
LEFT(CITY,1) <> "E" AND
LEFT(CITY,1) <> "I" AND
LEFT(CITY,1) <> "O" AND
LEFT(CITY,1) <> "U")
;

-- Revising Aggregations - The Count Function
SELECT COUNT(name) FROM CITY WHERE POPULATION > 100000;

-- Revising Aggregations - The Sum Function
SELECT SUM(population) FROM CITY WHERE district = "California";

-- Revising Aggregations - Averages
SELECT avg(population) FROM CITY WHERE district = "California";

-- Average Population
SELECT round(avg(population),0) FROM CITY;

-- Japan Population
SELECT SUM(population) FROM CITY WHERE COUNTRYCODE = "JPN";

-- Population Density Difference
SELECT Max(population)-min(population) FROM CITY;

-- Weather Observation Station 2
SELECT FORMAT(SUM(LAT_N),"#.##"),"",format(SUM(LONG_W),"#.##") FROM STATION;

-- Weather Observation Station 13
SELECT FORMAT(sum(LAT_N),"#.####") FROM STATION WHERE LAT_N > 38.7880 AND LAT_N < 137.2345;

-- Weather Observation Station 14
SELECT FORMAT(MAX(LAT_N),"#.####") FROM STATION WHERE LAT_N < 137.2345;

-- Weather Observation Station 15
SELECT FORMAT(LONG_W,"#.####") 
FROM STATION 
WHERE LAT_N = (
		SELECT max(LAT_N) 
		FROM STATION 
		WHERE LAT_N < 137.2345)
;

-- Weather Observation Station 16
SELECT FORMAT(MIN(LAT_N),"#.####") FROM STATION WHERE LAT_N > 38.7780;

-- Weather Observation Station 17
SELECT FORMAT(LONG_W,"#.####") 
FROM STATION 
WHERE LAT_N = (
		SELECT min(LAT_N) 
		FROM STATION 
		WHERE LAT_N > 38.7780)
;

-- Weather Observation Station 18
SELECT FORMAT(sqrt(POWER(min(LAT_N)-min(LONG_W),2))+sqrt(POWER(MAX(LAT_N)-Max(LONG_W),2)),"#.####") FROM STATION;

-- Weather Observation Station 19
SELECT FORMAT(sqrt(POWER(min(LAT_N)-min(LONG_W),2)+POWER(MAX(LAT_N)-Max(LONG_W),2)),"#.###0") FROM STATION;

-- Weather Observation Station 20
SELECT DISTINCT FORMAT(PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY LAT_N) OVER (),"#.####") FROM STATION;

-- The Blunder
SELECT cast(ceiling(avg(CAST(SALARY AS FLOAT))-avg(cast(REPLACE(salary,"0","") AS float))) as INT) FROM EMPLOYEES;

-- PADS
SELECT main.Name + "(" + left(main.occupation,1) + ")" as NameOccup
FROM OCCUPATIONS as 

UNION ALL

SELECT "There are total " + CAST(count(second.occupation) AS VARCHAR ) + " " + LOWER(second.occupation) + "s."
FROM OCCUPATIONS as second
GROUP BY second.occupation
ORDER BY main.Name + "(" + left(main.occupation,1) + ")"
;
-- Type of Triangle
SELECT 
IIF( a = b AND a = c, 
	"Equilateral", 
    IIF((a+b)<=c OR (a+c)<=b OR (c+b)<=a, 
        "Not A Triangle", 
        IIF(a = b OR a = c, 
        	"Isosceles",  
            "Scalene"
           )
        )
   )
FROM TRIANGLES;

-- Binary Search Tree
SELECT base.N, "Root" as P
FROM BST as base
WHERE base.P IS NULL

UNION

SELECT base.N, "Inner" as Parent
FROM BST as base INNER JOIN BST as Parent on base.n = Parent.p
WHERE base.P IS NOT NULL

UNION

SELECT DISTINCT base.N, "Leaf" as Parent
FROM BST as base LEFT JOIN BST as Parent on base.n = Parent.p
WHERE Parent.p IS NULL AND base.p IS NOT NULL;

-- Asian Population
SELECT sum(city.population)
FROM City INNER JOIN Country ON CITY.CountryCode = COUNTRY.Code
WHERE country.continent LIKE 'Asia';

-- African Cities
SELECT city.name
FROM City INNER JOIN Country ON CITY.CountryCode = COUNTRY.Code
WHERE country.continent LIKE 'Africa';

-- Average Population of Each Continent
SELECT COUNTRY.Continent,TRUNC(avg(CITY.Population))
FROM City INNER JOIN Country ON CITY.CountryCode = COUNTRY.Code
GROUP BY country.continent;

-- The Report
SELECT 
	IIF(Grades.grade<8, NULL,Students.name),
	Grades.grade, 
	Students.marks
FROM Students INNER JOIN Grades ON floor(IIF(Students.marks=100,students.marks-1,students.marks)/10)*10 = grades.min_mark
ORDER BY Grades.grade DESC, Students.name, Students.marks ASC;

-- Draw The Triangle 1
DECLARE @i INT = 20
WHILE (@i > 0) 
BEGIN
   PRINT REPLICATE('* ', @i) 
   SET @i = @i - 1
END

-- Draw The Triangle 2
DECLARE @i INT = 20
DECLARE @y INT = 0
WHILE (@i > @y) 
BEGIN
    SET @y = @y + 1   
    PRINT REPLICATE('* ', @y) 
END

-- Placements
SELECT main.name
FROM (
SELECT main.name, main.salary, friends.friend_id
FROM (SELECT students.id, students.name, packages.salary FROM students inner join packages on students.id = packages.id) as main INNER JOIN friends on main.id = friends.id) as main inner join packages as friend on main.friend_id = friend.id
WHERE main.salary < friend.salary ORDER BY friend.salary

-- Print Prime Numbers
DECLARE @pdiv INT = 2; 
DECLARE @pnum INT = 2; 
DECLARE @printout nvarchar(1000); 
DECLARE @i int= 0;

set @printout = "";

WHILE @pnum <= 1000
BEGIN 
    set @i=0;
    set @pdiv=2; 
    WHILE @pdiv < @pnum 
    BEGIN 
        if(@pnum%@pdiv=0) set @i=@i+1; 
        SET @pdiv = @pdiv + 1; 
    END; 
    if(@i=0) set @printout=@printout+concat(@pnum,'&'); 
    SET @pnum = @pnum + 1; 
END;
print substring(@printout,1, len(@printout)-1);
