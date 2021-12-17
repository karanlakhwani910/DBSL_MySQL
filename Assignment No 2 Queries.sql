SHOW TABLES;
DESC Customers;
DESC Authors;
DESC Publishers;
DESC Books;
DESC Orders;


DROP TABLE Orders;
DROP TABLE Books;
DROP TABLE Publishers;
DROP TABLE Authors;
DROP TABLE Customers;


SELECT * FROM Customers;
SELECT * FROM Authors;
SELECT * FROM Books;
SELECT * FROM Orders;
SELECT * FROM Publishers;


-- 1. Insert at least 10 records in customer table and insert other tables accordingly


-- 2. Display all customer details with city pune or mumbai and customer first name 
-- starting with 'p' or 'h'.
SELECT * FROM Customers 
	WHERE Customer_City IN('Pune', 'Mumbai') 
    AND Customer_FName LIKE 'P%' OR Customer_FName LIKE 'H%';


-- 3. lists the number of different customer cities.(use of distinct)
SELECT DISTINCT Customer_City FROM Customers;


-- 4. Give 5% increase in price of the books with publishing year 2015.(use of update)
UPDATE Books 
	SET Unit_Price =  (Unit_Price + 0.05*Unit_Price) WHERE Pub_year = 2015;

-- SELECT ISBN, Title, Unit_Price, (Unit_Price + 0.05*Unit_Price) AS New_Price
-- 	FROM Books 
-- 	WHERE Pub_year = 2015;
    
-- 5. Delete customer details living in pune.
DELETE FROM Customers WHERE Customer_City = 'Pune';


-- 6. Find the names of authors living in India or Australia (use of UNION)
SELECT Author_name, Author_Country FROM Authors
	WHERE Author_Country = 'India'
	UNION ALL 
	SELECT Author_name, Author_Country FROM Authors 
	WHERE Author_Country = 'Australia';
    
    
-- 7. Find the publishers who are established in year 2015 as well as in 2016
SELECT Publisher_Name, estab_year FROM Publishers 
	WHERE estab_year IN (2015, 2016);
    
    
-- 8. Find the book having maximum price and find titles of book having price between
-- 300 and 400.(use of max and between)
SELECT Title, MAX(Unit_Price) AS Max_Price FROM Books;

SELECT Title, Unit_Price FROM Books 
	WHERE Unit_Price BETWEEN 300 AND 400;
    

-- 9. Display all titles of books with price and published year in decreasing order of
-- publishing year.
SELECT Title, Unit_Price, Pub_year FROM Books
	ORDER BY Pub_year DESC;

-- 10. Display title,author_no and publisher_no of all books published in 2000, 2004,
-- 2006. (use of IN)
SELECT Title, Author_no, Publisher_no, Pub_year FROM Books
	WHERE Pub_year IN (2000, 2004, 2006);
    
    
-- 11.Create view showing the books and authors details. (COMPLEX VIEW)
CREATE VIEW Title_Authors
	AS SELECT B.Title, A.Author_name
	FROM Books B , Authors A 
    WHERE B.Author_no = A.Author_no;

SELECT * FROM Title_Authors;

DROP VIEW Title_Authors;
 
 