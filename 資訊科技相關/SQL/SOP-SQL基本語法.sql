-- <SQL SELECT Statement>
  SELECT CUSTOMERNAME, CITY 
  FROM CUSTOMERS;

  SELECT * 
  FROM CUSTOMERS;

-- SQL SELECT DISTINCT Statement
  SELECT DISTINCT COUNTRY
  FROM CUSTOMERS;

  SELECT COUNT(DISTINCT COUNTRY)
  FROM CUSTOMERS;

  SELECT COUNT(*) AS DISTINCT_COUNTRY
  FROM (SELECT DISTINCT COUNTRY
  FROM CUSTOMERS);

-- SQL WHERE Clause
  SELECT *
  FROM CUSTOMERS
  WHERE COUNTRY = 'MEXICO';

  SELECT *
  FROM CUSTOMERS
  WHERE COUNTRY_ID = 1;

  -- WHERE子句, 可以用的關鍵子
  --   =
  --   >
  --   <
  --   >=
  --   <=
  --   <> 
  --   !=
  --   between
  --   like
  --   in

-- SQL ORDER BY Keyword
  SELECT * FROM PRODUCTS
  ORDER BY PRICE; --預設是asc, 正向排序

  SELECT * FROM PRODUCTS
  ORDER BY PRICE DESC; --desc, 反向排序

  SELECT * FROM PRODUCTS
  ORDER BY PRODUCTNAME; --alphatbetically 

  SELECT * FROM PRODUCTS
  ORDER BY PRODUCTNAME DESC; --alphatbetically 反向

  SELECT * FROM CUSTOMERS
  ORDER BY  COUNTRY, CUSTOMERNAME;

  SELECT * FROM CUSTOMERS
  ORDER BY  COUNTRY ASC, CUSTOMERNAME DESC;

-- SQL AND Operator
  SELECT * FROM CUSTOMERS
  WHERE COUNTRY = 'SPAIN' AND
    CUSTOMERNAME LIKE 'g%';

-- SQL OR Operator
  SELECT * FROM CUSTOMERS
  WHERE COUNTRY = 'GERMANY' OR COUNTRY = 'SPAIN';

  -- Select all [Spanish] customers 
  -- that starts with either "G" or "R":
  SELECT * FROM Customers
  WHERE Country = 'Spain' 
    AND (CustomerName LIKE 'G%' OR CustomerName LIKE 'R%'); 
  
  -- Without parenthesis, 
  -- the select statement will 
  -- return all customers from Spain that starts with a "G", 
  -- plus all customers that starts with an "R", 
  --  regardless of the country value:
  SELECT * FROM Customers
  WHERE Country = 'Spain' 
  AND CustomerName LIKE 'G%' 
  OR CustomerName LIKE 'R%'; 
  -- AND 會先合併一次
  -- 再去 檢查 OR 條件

-- The NOT Operator
  SELECT * FROM CUSTOMERS
  WHERE NOT COUNTRY = 'SPAIN';
  SELECT * FROM Customers
  WHERE COUNTRY != 'SPAIN';

  SELECT * FROM CUSTOMERS
  WHERE CUSTOMERNAME NOT LIKE 'a%';

  SELECT * FROM Customers
  WHERE CUSTOMERID NOT between 10 AND 60;

  SELECT * FROM CUSTOMERS
  WHERE CITY NOT IN ('pARIS', 'LONDON')

  -- 相同結果
  SELECT * FROM CUSTOMERS
  WHERE NOT CUSTOMERID > 50;
  SELECT * FROM CUSTOMERS
  WHERE CUSTOMERID !> 50;

  -- 相同結果
  SELECT * FROM CUSTOMERS
  WHERE NOT CUSTOMERID < 50;
  SELECT * FROM CUSTOMERS
  WHERE NOT CUSTOMERID !< 50;

-- SQL INSERT INTO Statement
  --Syntax: INSERT INTO Table_Name (COLUMN_NAME...) VALUES(COLUMN_VALUE...);

  INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
  VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');

  -- If you are adding values for all the columns of the table, you do not need to specify the column names in the SQL query
  -- 全欄位資料新增, 可以不用加欄位名稱
  INSERT INTO Customers
  VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');

  -- 只新增特定欄位資料, 須加欄位名稱
  INSERT INTO Customers (CustomerName, City, Country)
  VALUES ('Cardinal', 'Stavanger', 'Norway');

  INSERT INTO CUSTOMERS(CustomerName, CITY, COUNTRY)
  VALUES('KINGCAR', 'ILAN', 'TAIWAN');

  -- 一次新增多筆資料, 每一組資料中間要以 [,] 隔開.
  INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
  VALUES ('7-11', 'Kevin', 'Skagen 21', 'Stavanger', '4006', 
            'TAIWAN'),
         ('全家', 'Sunny', 'Skagen 21', 'Stavanger', '4006', 
            'TAIWAN');

-- SQL NULL Values
  -- It is not possible to test for NULL values 
  -- with comparison operators, such as =, <, or <>.
  -- 只能用 is null , is not null 判斷 null 值.

  SELECT CustomerName, ContactName, Address
  FROM Customers
  WHERE Address IS NULL;

  SELECT CustomerName, ContactName, Address
  FROM Customers
  WHERE Address IS NOT NULL;

-- SQL UPDATE Statement
-- Syntax: UPDATE TABLE_NAME SET COLUMN_NAME = COLUMN_VALUE;
  UPDATE CUSTOMERS
  SET ContactName = 'kl', CITY = 'TAINAN'
  WHERE CUSTOMERID = 1;

  UPDATE CUSTOMERS
  SET ContactName = 'JUDY', CITY = 'TAINAN'
  WHERE COUNTRY = 'JAPAN';

  -- 所有聯絡人都改為 JAMES
  UPDATE CUSTOMERS
  SET ContactName = 'JAMES';

-- SQL DELETE Statement
  -- DELETE FROM tABLE_NAME WHERE [DELETE_cONTION]
  DELETE FROM CUSTOMERS
  WHERE CUSTOMERNAME = 'susui';

  -- DELETE ALL ROWS;
  DELETE FROM CUSTOMERS;

  -- Remove the Customers table:
  DROP TABLE CUSTOMERS;

-- SQL TOP(ms sql), LIMIT(mysql), FETCH FIRST(oracle) or ROWNUM(oracle) Clause
  -- The [SELECT TOP] clause is useful 
  -- on large tables with thousands of records. 
  -- Returning a large number of records can impact performance.
  -- 常用於大型資料表, 因為回傳大量資料會影響效能.
  SELECT TOP (5) * 
  FROM CUSTOMERS
  ORDER BY SignDate DESC;

  -- 5%的資料回傳(HumanResources.Employee 資料表有 290 名員工。 因為 290 的 5% 是含小數的值，所以此值會無條件進位到下一個整數。)
  SELECT TOP (5) PERCENT * 
  FROM CUSTOMERS
  ORDER BY SignDate DESC;

  -- 最佳做法
  -- 在 SELECT 陳述式中，永遠搭配 TOP 子句使用 ORDER BY 子句。 因為它是以預測方式來指示哪些資料列受到 TOP 影響的唯一方法。

-- SQL MIN() and MAX() Functions
  SELECT MIN(Price) FROM Products;
  SELECT MAX(Price) FROM Products; 
  SELECT MIN(Price) AS SmallestPrice FROM Products;

-- SQL COUNT() Function
  -- NULL欄位個數會一併計入
  SELECT COUNT(*) FROM Products;
  
  -- If you specify a column instead of (*), NULL values will not be counted.
  -- 指定欄位計數時, 欄位中的NULL個數不會被計入
  SELECT COUNT(ProductName) FROM Products;

  -- Ignore Duplicates
  -- 忽略重複項目(不計)
  SELECT COUNT(DISTINCT ProductName) FROM Products;

-- SQL SUM() Function
  SELECT SUM(Quantity) FROM OrderDetails; 

  SELECT SUM(Quantity) FROM OrderDetails
  WHERE ProdictId = 11;

  SELECT SUM(Quantity) AS total
  FROM OrderDetails;

  -- Use an expression inside the SUM() parenthesis:
  SELECT SUM(Quantity * 10) --1個10元
  FROM OrderDetails; 

  -- 計算總金額
  SELECT SUM(Price * Quantity)
  FROM OrderDetails
  LEFT JOIN Products 
    ON OrderDetails.ProductID = Products.ProductID; 

-- SQL AVG() Function
  -- 注意: 放入'欄位名稱'時, null值會被忽略.
  SELECT AVG(Price) FROM Products;

  SELECT AVG(Price)
  FROM Products
  WHERE CategoryID = 1;

  SELECT AVG(Price) AS [average price]
  FROM Products;

  -- Higher Than Average
  SELECT * FROM Products
  WHERE price > (SELECT AVG(price) FROM Products); 

-- SQL LIKE Operator, 可搭配兩種 % 及 _
  -- The percent sign [%] represents (0-多個字元)
      -- zero, one, or multiple characters
  -- The underscore sign [_] represents (1個字元)
      -- one, single character

  SELECT * FROM Customers
  WHERE CustomerName LIKE 'a%'; 

  SELECT * FROM Customers
  WHERE city LIKE 'L_nd__'; 

  SELECT * FROM Customers
  WHERE city LIKE '%L%'; 

  SELECT * FROM Customers
  WHERE CustomerName LIKE 'La%'; 

  -- Tip: You can also combine 
  -- [any number of conditions] using AND or OR operators.
  SELECT * FROM Customers
  WHERE CustomerName LIKE 'a%' 
    OR CustomerName LIKE 'b%'; 

  SELECT * FROM Customers
  WHERE CustomerName LIKE '%a'; 

  -- Tip: You can also combine 
    -- "starts with" and "ends with":
  SELECT * FROM Customers
  WHERE CustomerName LIKE 'b%s'; 

  -- Contains(字串中包含, '%kl%')
  SELECT * FROM Customers
  WHERE CustomerName LIKE '%or%';

  -- Combine Wildcards(兩者結合)
  SELECT * FROM Customers
  WHERE CustomerName LIKE 'a__%'; 

  SELECT * FROM Customers
  WHERE CustomerName LIKE '_r%';

  --Without Wildcard
  SELECT * FROM Customers
  WHERE Country LIKE 'Spain';

  -- Using the [] Wildcard
  SELECT * FROM Customers
  WHERE CustomerName LIKE '[bsp]%';
  -- boy or sos or pig

  -- Using the - Wildcard
  -- The - wildcard allows you to specify a range of characters 
  -- inside the [] wildcard.
  -- - 它是和 [] 併用的
  SELECT * FROM Customers
  WHERE CustomerName LIKE '[a-f]%';

-- SQL IN Operator
  SELECT * FROM Customers
  WHERE Country IN ('Germany', 'France', 'UK');

  SELECT * FROM Customers
  WHERE Country NOT IN ('Germany', 'France', 'UK');

  SELECT * FROM Customers
  WHERE CustomerID IN (SELECT CustomerID FROM Orders);

  SELECT * FROM Customers
  WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- SQL BETWEEN Operator
  -- The BETWEEN operator selects values within a given range. 
  -- The values can be numbers, text, or dates.
  -- The BETWEEN operator is inclusive: 
  --   begin and end values are included. 
  -- 數值, 字串, 日期 都適用
  -- 起始及結尾 都包含在內
  SELECT * FROM Products
  WHERE Price BETWEEN 10 AND 20;

  SELECT * FROM Products
  WHERE Price NOT BETWEEN 10 AND 20;

  -- BETWEEN with IN
  SELECT * FROM Products
  WHERE Price BETWEEN 10 AND 20
  AND CategoryID IN (1,2,3);

  -- BETWEEN Text Values
  SELECT * FROM Products
  WHERE ProductName 
  BETWEEN 'Carnarvon Tigers' 
      AND 'Mozzarella di Giovanni'
  ORDER BY ProductName;

  SELECT * FROM Products
  WHERE ProductName 
  NOT BETWEEN 'Carnarvon Tigers' 
      AND 'Mozzarella di Giovanni'
  ORDER BY ProductName;

  -- BETWEEN Dates
  SELECT * FROM Orders
  WHERE OrderDate 
  BETWEEN #07/01/1996# AND #07/31/1996#;

  SELECT * FROM Orders
  WHERE OrderDate 
  BETWEEN '1996-07-01' AND '1996-07-31';

-- SQL Aliases
  -- SQL aliases are used to give a table, (資料表名)
  -- or a column in a table, (欄位名)
  -- a temporary name. 

  -- An alias only exists for the duration of that query.
  -- An alias is created with the [AS] keyword.
  -- [AS] keyword 可省略, 但會看得很吃力.
  -- XXX AS 別名
  SELECT CustomerID AS ID
  FROM Customers; 

  SELECT CustomerID AS ID, CustomerName AS Customer
  FROM Customers; 

  -- Using Aliases With a Space Character
  -- 兩種標註方式
  SELECT ProductName AS [My Great Products]
  FROM Products; 

  SELECT ProductName AS "My Great Products"
  FROM Products; 

  -- Concatenate Columns
  SELECT CustomerName, 
  Address + ', ' + PostalCode 
    + ' ' + City + ', ' + Country AS Address
  FROM Customers; 

  -- Alias for Tables
  SELECT * FROM Customers AS Persons; 

  SELECT o.OrderID, o.OrderDate, c.CustomerName
  FROM Customers AS c, Orders AS o
  WHERE c.CustomerName='Around the Horn' 
    AND c.CustomerID=o.CustomerID;

  -- 使用別名的好處
  -- Aliases can be useful when:  
    -- 1.There are more than one table involved in a query
    -- 2.Functions are used in the query
    -- 3.Column names are big or not very readable
    -- 4.Two or more columns are combined together
  
