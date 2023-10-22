-- Query all columns for all American cities 
  -- in the CITY table with populations larger than 100000. 
  -- The CountryCode for America is USA. 

SELECT * FROM CITY WHERE population > 100000 AND CountryCode = 'USA';

-- Query the NAME field for all American cities in the CITY table with populations larger than 120000. 
-- The CountryCode for America is USA. 

SELECT NAME FROM CITY WHERE population > 120000 AND CountryCode = 'USA';

-- Query all columns (attributes) for every row in the CITY table.
SELECT * FROM CITY;

-- Query all columns for a city in CITY with the ID 1661.
SELECT * FROM CITY WHERE ID = 1661;

-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN. 
SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN. 
SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN';

SELECT CITY , STATE FROM STATION;

-- Query a list of CITY [names] from STATION for cities that have an [even ID number]. 偶數
-- Print the results in any order, but [exclude duplicates] from the answer. 
SELECT DISTINCT CITY FROM STATION WHERE (ID % 2 ) = 0;

-- Find the difference between the total number of CITY entries in the table 
-- and the number of distinct CITY entries in the table. 
-- For example, if there are three records in the table with CITY values 'New York', 'New York', 'Bengalaru', 
-- there are 2 different city names: 'New York' and 'Bengalaru'. The query returns , because .
-- 計算結果: total number OF records - number OF UNIQUE CITY NAMES = 3-2 = 1;
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION;

-- Query the two cities in STATION with the shortest(最短) and longest(最長) CITY names, 
-- as well as their respective lengths(各自的長度) (i.e.: number of characters in the name). 
-- If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically. (ASC)
-- 誤區: 要用(城市名稱 [長度] 排序), 而不是單純用(城市名稱排序)
SELECT TOP(1) CITY, LEN(CITY) FROM STATION ORDER BY LEN(CITY) , CITY ;
SELECT TOP(1) CITY, LEN(CITY) FROM STATION ORDER BY LEN(CITY) DESC , CITY;

-- 正確答案
-- shortest 
SELECT TOP 1 CITY, LEN(CITY) AS LENGTH FROM STATION ORDER BY LEN(CITY), CITY; 
--- Longest 
SELECT TOP 1 CITY, LEN(CITY) AS LENGTH FROM STATION ORDER BY LEN(CITY) DESC, CITY;


-- Query the list of CITY names [starting with vowels] (i.e., a, e, i, o, or u) from STATION. (城市名稱以aeiou開頭, LIKE [aeiou]%)
-- Your result cannot contain duplicates.(不能重覆, distinct)
SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE '[aeiou]%';

-- Query the list of CITY names [ending with vowels] (a, e, i, o, u) from STATION. (城市名稱以aeiou結尾, LIKE %[aeiou])
-- Your result cannot contain duplicates.(不能重覆, distinct)
SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE '%[aeiou]';

-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as 
-- both their first and last characters. (城市名稱以aeiou開頭及結尾)
-- Your result cannot contain duplicates. (不能重覆, distinct)
SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE '[aeiou]%[aeiou]';

-- Query the list of CITY names from STATION that [do not start with vowels]. (城市名稱 [不能] 以 aeiou 開頭)
-- Your result cannot contain duplicates.(不能重覆, distinct)
SELECT DISTINCT CITY FROM STATION WHERE NOT CITY LIKE '[aeiou]%';

-- Query the list of CITY names from STATION that [do not end with vowels]. (城市名稱 [不能] 以 aeiou 結尾)
-- Your result cannot contain duplicates.(不能重覆, distinct)
SELECT DISTINCT CITY FROM STATION WHERE NOT CITY LIKE '%[aeiou]';

-- Query the list of CITY names from STATION that [either] do not start with vowels or do not end with vowels. 
-- Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE (NOT CITY LIKE '[aeiou]%') OR (NOT CITY LIKE '%[aeiou]');

-- Query the list of CITY names from STATION that [do not start with vowels and do not end with vowels]. 
-- Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION WHERE (NOT CITY LIKE '[aeiou]%') AND (NOT CITY LIKE '%[aeiou]');

-- Query the [Name] of any student in [STUDENTS] who scored higher than 75 Marks. (where marks > 75)
-- Order your output by the last three characters of each name. (以name末3碼排序, order by right(name,3))
-- If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), 
-- secondary sort them by ascending ID.(第1排序相同時, 第2排序為 ID ASC)
SELECT NAME FROM STUDENTS WHERE Marks > 75 ORDER BY RIGHT(NAME,3), ID ASC;

-- Write a query that prints a list of employee names (i.e.: the [name] attribute) 
-- from the [Employee] table in [alphabetical order].
SELECT NAME FROM Employee ORDER BY NAME;

-- Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee 
-- having a salary greater than 2000 per month who have been employees for less than 10 months. 
-- Sort your result by ascending employee_id.
SELECT NAME FROM Employee WHERE salary > 2000 AND months < 10 ORDER BY employee_id ASC;

-- Write a query to print all [prime numbers](質數) less than or equal to 1000 . 
-- Print your result on a single line, 
-- and use the ampersand (&) character as your separator (instead of a space).
DECLARE @COUNT INT; SET @COUNT = 0;
WHILE (@COUNT < 11)
BEGIN
  SET @COUNT = @COUNT +1;
  SELECT @COUNT;
  IF (@COUNT = 11)
    BREAK --停止執行
  ELSE 
    CONTINUE --往下一個run
END

select 1 as n
into #temp;
select * from #temp;

-- 網友寫的, 原來SQL可以這麼寫!!(未解開)
with t as ( select 1 as n union all select n + 1 from t where n < 1000 ) , 
    tb1 as ( select t1.n as n1, t2.n as n2, t1.n % t2.n as n3 from t as t1, t as t2 where t1.n > t2.n and t2.n > 1 ) , 
    tb2 as ( select n1 from tb1 where n3 = 0 group by n1 ) , 
    prime as ( select n from t where n not in (select n1 from tb2) and n > 1 ) 
SELECT STRING_AGG(n,'&') From prime OPTION (MAXRECURSION 1000);

-- Query a count of the number of cities in CITY having a Population larger than 100,000. 
SELECT COUNT(1) FROM CITY WHERE Population > 100000;

-- Query the [total population] of all cities in CITY where District is California. 
SELECT SUM(Population) FROM CITY WHERE District = 'California';

-- Query the [average population] of all cities in CITY where [District is California]. 
SELECT AVG(Population) FROM CITY WHERE District = 'California';

-- Query the [average population] for all cities in CITY, [rounded down to the nearest integer].
SELECT ROUND(AVG(Population), 0) FROM CITY;

-- Query the [sum of the populations] for all Japanese cities in CITY. 
-- The COUNTRYCODE for Japan is JPN.
SELECT SUM(Population) FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Query the difference between the maximum and minimum populations in CITY.
SELECT MAX(Population) - MIN(Population) FROM CITY;

-- Write a query calculating the amount of error (i.e.: average monthly salaries), 
-- and [round it up to the next integer].(CEIL => 此函式會傳回大於或等於所指定數值運算式的最小整數)

SELECT CEIL(AVG(Salary) - AVG(CAST(REPLACE(CAST(salary AS VARCHAR(4)), '', '0') AS INT) ))
FROM EMPLOYEES;

SELECT CEIL(AVG(Salary) - AVG(CAST(REPLACE(Salary, '0', '') AS DECIMAL))) AS diff
FROM EMPLOYEES;
