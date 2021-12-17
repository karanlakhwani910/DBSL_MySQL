/*
	Problem statement :- 
		Write a Stored Procedure namely proc_Grade for the categorization of student.
        If marks scored by students in examination is <=1500 and marks>=990 then 
        student will be placed in distinction category,
        if marks scored are between 989 and 900 category is first class, 
        if marks 899 and 825 category is Higher Second Class.
        Write a PL/SQL block to use procedure created with above requirement. 
			Stud_Marks(name, total_marks) 
			Result(Roll,Name, Class)
*/

CREATE TABLE Stud_Marks(
	RollNo INT PRIMARY KEY,
    Sname VARCHAR(20),
    Total_Marks INT
    );
    
INSERT INTO Stud_Marks VALUES 
	(1, 'Vidyut', 995),
	(2, 'Pratap', 828),
	(3, 'Kailash', 945),
	(4, 'Mukund', 1500),
	(5, 'Girish', 900),
	(6, 'Neeraj', 850),
	(7, 'Prashant', 800),
	(8, 'Raj', 899),
	(9, 'Hari', 1300),
	(10, 'Aditya', 920);
    
CREATE TABLE Result(
	RollNo INT REFERENCES Stud_Marks(RollNo),
    Sname VARCHAR(20),
    Marks INT,
    Grade VARCHAR(20)
    );

DELIMITER $$
CREATE PROCEDURE proc_Grade(
	IN roll INT, 
    IN marks INT
)
	BEGIN
		DECLARE student VARCHAR(20);
		DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'ENTRY NOT FOUND' AS EXCEPTION;
        
        IF NOT EXISTS(SELECT * FROM  Stud_Marks WHERE RollNo = roll AND Total_Marks = marks) THEN
			SIGNAL SQLSTATE '45000';
		END IF;
        
		SELECT Sname INTO student 
			FROM Stud_Marks 
            WHERE RollNo = roll AND Total_Marks = marks;
            
		IF marks >= 990 AND marks <= 1500 THEN
			INSERT INTO Result 
				VALUES(roll, student, marks, "Distinction");
		ELSEIF marks >= 900 AND marks <= 989 THEN
			INSERT INTO Result 
				VALUES(roll, student, marks, "First Class");
		ELSEIF marks >= 825 AND marks <= 899 THEN
			INSERT INTO Result 
				VALUES(roll, student, marks, "Higher Second Class");
		ELSE
			INSERT INTO Result VALUES(roll, student, marks, NULL);
		END IF;
        
		SELECT * FROM Result;
	END $$

DELIMITER ;
CALL proc_Grade(1, 995);
CALL proc_Grade(2, 828);
CALL proc_Grade(3, 945);
CALL proc_Grade(4, 1500);
CALL proc_Grade(5, 900);
CALL proc_Grade(6, 850);
CALL proc_Grade(7, 800);
CALL proc_Grade(8, 899);
CALL proc_Grade(9, 1300);
CALL proc_Grade(10, 920);
CALL proc_Grade(11, 828);

DELIMITER $$  
CREATE FUNCTION fun_Grade(  
	marks INT 
)
	RETURNS VARCHAR(20)  
	DETERMINISTIC  
	BEGIN  
		DECLARE grade VARCHAR(20);  
			IF marks >= 990 AND marks <= 1500 THEN
				SET grade = 'Distinction';
                
			ELSEIF marks >= 900 AND marks <= 989 THEN
				SET grade = 'First Class';
                
			ELSEIF marks >= 825 AND marks <= 899 THEN
				SET grade = 'Higher Second Class';
                
			ELSE
				SET grade = NULL;
			END IF;
		RETURN (grade);  
	END$$  
    
DELIMITER ;

SELECT RollNo, Sname, Total_Marks, fun_Grade(Total_Marks) AS GRADE  
FROM Stud_marks ORDER BY RollNo;

CREATE TABLE Result2(
	RollNo INT REFERENCES Stud_Marks(RollNo),
    Sname VARCHAR(20),
    Marks INT,
    Grade VARCHAR(20)
    );

DELIMITER $$
CREATE PROCEDURE NewGrade_Proc()
	BEGIN
		DECLARE roll INT;
        DECLARE m INT;
		DECLARE student VARCHAR(20);
		DECLARE exit_loop BOOLEAN;
		DECLARE C1 CURSOR FOR SELECT * FROM Stud_Marks;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
        
        OPEN C1;
		L1: LOOP
			FETCH C1 INTO roll,student,m;
                        
			IF exit_loop THEN
				CLOSE c1;
				LEAVE L1;
			END IF;
            
			IF m >= 990 AND m <= 1500 THEN
				INSERT INTO Result2 
					VALUES(roll, student, m, "Distinction");
			ELSEIF m >= 900 AND m <= 989 THEN
				INSERT INTO Result2 
					VALUES(roll, student, m, "First Class");
			ELSEIF m >= 825 AND m <= 899 THEN
				INSERT INTO Result2
					VALUES(roll, student, m, "Higher Second Class");
			ELSE
				INSERT INTO Result2 VALUES(roll, student, m, NULL);
			END IF;
            
		END LOOP L1;
    END $$
   
delimiter ;
CALL NewGrade_Proc();

SELECT * FROM Result2;

DROP TABLE Stud_Marks;
DROP FUNCTION fun_Grade;
DROP TABLE Result;
DROP PROCEDURE proc_Grade;
DROP PROCEDURE NewGrade_Proc;
DROP TABLE result2;

