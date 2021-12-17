/* 
	Problem statement :- 
	   Write a database trigger on Library table. The System should keep track of the records that are 
	   being updated or deleted. The old value of updated or deleted records should be added in 
	   Library_Audit table.
*/
   
   
CREATE TABLE Library(stu_roll_no INT PRIMARY KEY, stu_name VARCHAR(20), book_name VARCHAR(20), 
	date_of_issue DATE, price INT);
CREATE TABLE Library_Audit(Action_Performed VARCHAR(20), DateAndTime DATETIME, stu_roll_no INT REFERENCES Library(stu_roll_no), 
	stu_name VARCHAR(20), book_name VARCHAR(20), date_of_issue DATE, price INT);
    
INSERT INTO Library VALUES
	(1, 'Vidyut', 'DBMS', '2021-07-21', 300),
	(2, 'Pratap', 'CNS', '2021-05-21', 500),
	(3, 'Kailash', 'SPOS', '2021-07-10', 400),
	(4, 'Mukund', 'OOP', '2021-08-16', 250),
	(5, 'Girish', 'DSA', '2021-06-26', 650),
	(6, 'Neeraj', 'OOP', '2021-01-01', 330),
	(7, 'Prashant', 'SPOS', '2021-02-18', 540),
	(8, 'Raj', 'CNS', '2021-01-31', 540),
	(9, 'Hari', 'DBMS', '2021-04-04', 820),
	(10, 'Aditya', 'PPL', '2021-03-07', 430);
  
DELIMITER $$
CREATE TRIGGER trig_library_insert AFTER INSERT ON library 
FOR EACH ROW
BEGIN
		INSERT INTO Library_Audit VALUES ("INSERT", NOW(), NEW.stu_roll_no, NEW.stu_name, NEW.book_name, NEW.date_of_issue, NEW.price);
END $$ 
  
DELIMITER $$
CREATE TRIGGER trig_library_update AFTER UPDATE ON library 
FOR EACH ROW
BEGIN
		INSERT INTO Library_Audit VALUES ("UPDATE", NOW(), OLD.stu_roll_no, OLD.stu_name, OLD.book_name, OLD.date_of_issue, OLD.price);
END $$

DELIMITER $$
CREATE TRIGGER trig_library_delete AFTER DELETE ON library 
FOR EACH ROW
BEGIN
		INSERT INTO Library_Audit VALUES ("DELETE", NOW(), OLD.stu_roll_no, OLD.stu_name, OLD.book_name, OLD.date_of_issue, OLD.price);
END $$

DELIMITER ;
SELECT * FROM Library;
SELECT * FROM Library_Audit;

UPDATE Library SET stu_name = "Tushar" WHERE stu_name = "Pratap";
UPDATE Library SET stu_name = "Tushar" WHERE stu_name = "Hari";
DELETE FROM Library WHERE stu_name = "Tushar";
DELETE FROM Library WHERE book_name = "OOP";
INSERT INTO Library VALUES(15, 'Ajay', 'PPS', '2021-08-26', 700);
INSERT INTO Library VALUES(20, 'Karan', 'DSA', '2021-02-11', 900);

DROP TABLE Library;
DROP TABLE Library_Audit;