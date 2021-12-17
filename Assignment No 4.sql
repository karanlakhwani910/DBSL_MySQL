/* Problem statement: 
	Consider Tables: 
	1. Borrower(Roll_no, Name, DateofIssue, NameofBook, Status) 
	2. Fine(Roll_no,Date,Amt) Accept Roll_no & NameofBook from user.
	  Check the number of days (from date of issue),
	  If days are between 15 to 30 then fine amount will be Rs 5per day.
      If no. of days>30, per day fine will be Rs 50 per day & for days less than 30, Rs. 5 per day. 
      After submitting the book, status will change from I to R.
      If condition of fine is true, then details will be stored into fine table.
      Also handles the exception by named exception handler or user define exception handler
*/


CREATE TABLE Borrower(RollNo INT PRIMARY KEY, Name VARCHAR(20), DateOfIssue DATE, NameOfBook VARCHAR(20) NOT NULL, BookStatus CHAR(1) );
INSERT INTO Borrower VALUES 
	(1, 'Mayur', '2021-08-31', 'DBMS', 'I'), 
    (2, 'Rushikesh', '2021-08-20', 'CNS', 'I'), 
	(3, 'Shubham', '2021-07-31', 'DSA', 'I'), 
    (4, 'Ajay', '2021-09-04', 'OOP', 'I'), 
    (5, 'karan', '2021-08-11', 'PPS', 'I');

CREATE TABLE fine(Roll_no INT NOT NULL REFERENCES Borrower(Roll_no), DateOfReturn DATE, TotalDays INT, Amount INT);

delimiter $
CREATE PROCEDURE ReturnBook( IN rno INT, IN Bname VARCHAR(30) )
PROC: BEGIN
	DECLARE i_date DATE;
    DECLARE Diff INT;
    DECLARE Stat CHAR(1);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'ENTRY NOT FOUND' AS EXCEPTION;
    
    SELECT DateOfIssue INTO i_date FROM Borrower WHERE RollNo = rno AND NameOfBook = Bname;
    SELECT BookStatus INTO stat FROM Borrower WHERE RollNo = rno AND NameOfBook = Bname;
    
    IF NOT EXISTS(SELECT * FROM Borrower WHERE RollNo = rno AND NameOfBook = Bname) THEN
		SIGNAL SQLSTATE '45000';
	END IF;
        
    IF Stat = 'R' THEN
		SELECT 'Book Already Returned !!' AS MESSAGE;
		LEAVE PROC;
	ELSE
		UPDATE Borrower SET BookStatus = 'R' WHERE RollNo = rno AND NameOfBook = Bname;
	END IF;
    
    SELECT DATEDIFF(CURDATE(), i_date) INTO Diff;
	IF(Diff > 15 AND Diff <= 30) THEN
		INSERT INTO fine VALUES(rno, CURDATE(), diff, (diff*5) );
	ELSEIF (Diff > 30) THEN
		INSERT INTO fine VALUES(rno, CURDATE(), diff, (diff*50) );
	ELSE
		INSERT INTO fine VALUES(rno, CURDATE(), diff, NULL);
	END IF;
    SELECT * FROM FINE;
END $

delimiter ;
CALL ReturnBook(1, 'DBMS');
CALL ReturnBook(2, 'CNS');
CALL ReturnBook(3, 'DSA');
CALL ReturnBook(4, 'OOP');
CALL ReturnBook(5, 'PPS');
CALL RETURNBOOK(6,'PPS');
CALL ReturnBook(NULL, 'DBMS');

SELECT * FROM fine;
SELECT * FROM borrower;

DROP TABLE borrower;
DROP TABLE  fine;
DROP PROCEDURE returnbook;




/* Problem statement:
   Write a PL/SQL code block to calculate the area of a circle for a value of radius varying from 5 to 9. 
   Store the radius and the corresponding values of calculated area in an empty table named areas, consisting 
   of two columns, radius and area. 

	Note: Instructor will frame the problem statement for writing PL/SQL block in line with above statement.
*/

CREATE TABLE Area_C(Radius INT PRIMARY KEY, AreaOfCircle FLOAT);

delimiter $$
CREATE PROCEDURE Circle_Area(IN r1 INT, IN r2 INT)
BEGIN
	DECLARE not_null INT DEFAULT 0;
BEGIN
	DECLARE rad INT;
    DECLARE EXIT HANDLER FOR 1048 SET not_null = 1; 
    SET rad = r1;
    st : LOOP
		IF rad = 0 then
			INSERT INTO Area_C VALUES(NULL, 3.14159*rad*rad);
        ELSE
			INSERT INTO Area_C VALUES(rad, 3.14159*rad*rad);
		END IF;
        IF rad = r2 THEN
			LEAVE st;
		END IF;
        SET rad = rad+1;
	END LOOP st;
    SELECT * FROM Area_C;
END;cart
	IF not_null = 1 THEN
		SELECT 'unsuccessful insert due to null value';
	END IF;
END $$

delimiter ;
CALL Circle_Area(5,9);
DROP PROCEDURE IF EXISTS Circle_Area;
DROP TABLE IF EXISTS Area_C;