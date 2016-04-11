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
WHERE		len(main.city) = (SELECT Min(len(STATION.city)) FROM STATION)
GROUP BY 	len(main.City) 

UNION ALL

SELECT 		min(main.City), len(main.City)
FROM 		STATION as main
WHERE   	len(main.city) = (SELECT MAX(len(STATION.city)) FROM STATION)
GROUP BY 	len(main.City)
;

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
