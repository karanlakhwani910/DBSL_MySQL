/*
	Problem statement :- 
		Write a PL/SQL block of code using parameterized Cursor that will merge the data available in the newly 
		created table N_RollCall with the data available in the table O_RollCall. If the data in the first table 
		already exist in the second table then that data should be skipped. 
*/

CREATE TABLE O_RollCall(RollNo INT PRIMARY KEY, Sname VARCHAR(20), Address VARCHAR(20) );
INSERT INTO O_RollCall VALUES
	(1, 'Vidyut', 'Nashik'),
	(2, 'Pratap', 'Pune'),
	(3, 'Kailash', 'Manmad'),
	(4, 'Mukund', 'Satara'),
	(5, 'Girish', 'Mumbai'),
	(6, 'Neeraj', 'Pune'),
	(7, 'Prashant', 'Akola'),
	(8, 'Raj', 'Mumbai'),
	(9, 'Hari', 'Jalna'),
	(10, 'Aditya', 'Aurangabad');
    
SELECT * FROM O_RollCall;

CREATE TABLE N_RollCall(RollNo INT PRIMARY KEY, Sname VARCHAR(20), Address VARCHAR(20) );

DELIMITER $$
CREATE PROCEDURE Copy( IN roll INT)
BEGIN
	DECLARE flag BOOLEAN;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'ENTRY NOT FOUND' AS EXCEPTION;
	SET flag = FALSE;
        
	IF NOT EXISTS(SELECT * FROM  O_RollCall WHERE RollNo = roll) THEN
		SIGNAL SQLSTATE '45000';
	END IF;
        
	IF NOT EXISTS(SELECT * FROM N_RollCall WHERE RollNo = roll) THEN
		SET flag = TRUE;
		INSERT INTO N_RollCall
			SELECT * FROM O_RollCall
			WHERE RollNo = roll;
	END IF;
        
	IF NOT flag THEN
		SELECT 'Record Already Exists' AS MESSAGE;
	ELSE
		SELECT * FROM N_RollCall;
	END IF;
END $$   
DELIMITER ;

CALL Copy(1);
CALL Copy(2);
CALL Copy(3);
CALL Copy(4);
CALL Copy(5);
CALL Copy(11);

DELIMITER $$
CREATE PROCEDURE NewCopy(
	IN Rno INT
)
	BEGIN
		DECLARE flag BOOLEAN;
		DECLARE C1 CURSOR FOR SELECT RollNo FROM O_RollCall WHERE RollNo = Rno;
        DECLARE EXIT HANDLER FOR NOT FOUND
			SELECT 'ENTRY NOT FOUND' AS EXCEPTION;
        OPEN C1;
        FETCH C1 INTO Rno;
        SET flag = FALSE;
        
		IF NOT EXISTS(SELECT * FROM N_RollCall WHERE RollNo = Rno ) THEN
			SET flag = TRUE;
			INSERT INTO N_RollCall
				SELECT * FROM O_RollCall
                WHERE RollNo = Rno;
		END IF;
        
        IF NOT flag THEN
			SELECT 'Record Already Exists' AS MESSAGE;
		ELSE
			SELECT * FROM N_RollCall;
		END IF;
        CLOSE C1;
        
    END $$
    
DELIMITER ;
CALL NewCopy(1);
CALL NewCopy(2);
CALL NewCopy(6);
CALL NewCopy(7);
CALL NewCopy(8);
CALL NewCopy(11);

DROP TABLE O_RollCall;
DROP TABLE N_RollCall;
DROP PROCEDURE Copy;
DROP PROCEDURE NewCopy;