
SHOW TABLES;
DESC Departments;
DESC Professors;
DESC Works;
DESC Shift;

DROP TABLE Works;
DROP TABLE Shift;
DROP TABLE Professors;
DROP TABLE Departments;

SELECT * FROM Departments;
SELECT * FROM Professors;
SELECT * FROM Works;
SELECT * FROM Shift;


-- 1. Find the professor details and department details using NATURAL JOIN.
SELECT Prof_id, Prof_fname, Prof_lname, Dept_id, Dept_name 
	FROM Professors
    NATURAL JOIN Departments;

-- 2. Find the prof_id, prof_name and shift. (INNER JOIN)
SELECT P.Prof_id, P.Prof_fname, P.Prof_lname, S.Shift 
	FROM Professors P 
	INNER JOIN  Shift S 
    ON P.Prof_id = S.Prof_id;

-- 3. List all the department details and the corresponding names of professors in the same department.(left outer join)
SELECT D.Dept_name, P.Prof_fname, P.Prof_lname 
	FROM Departments D
    LEFT JOIN Professors P
    ON D.Dept_id = P.Dept_id;
    
-- 4. List all the professors and the corresponding names of department. (right outer join)
SELECT P.Prof_fname, P.Prof_lname, D.Dept_name
	FROM Departments D
    RIGHT JOIN Professors P
    ON P.Dept_id = D.Dept_id ;
    
-- 5. Display professor name, dept_name, shift, salary where prof_id = 101;(multitable join)
SELECT P.Prof_fname, P.Prof_lname, D.Dept_name, S.Shift, P.salary
	FROM Departments D
    JOIN Professors P ON P.prof_id = 101 AND D.Dept_id = P.Dept_id
    JOIN Shift S ON S.prof_id = 101 AND P.prof_id = S.prof_id;

-- 6. list the total number of professor in each department.(count and any join,groupby)
SELECT D.Dept_name, COUNT(P.Prof_id) AS NoOfProf
	FROM Professors P
    INNER JOIN Departments D ON P.Dept_id = D.Dept_id
    GROUP BY Dept_name;
    
-- 7. List the prof_id associated department and the dept_name having name ‘computer’;(subquery)
 SELECT Prof_id, Prof_fname, Prof_lname
	FROM Professors  
    WHERE Dept_id IN
    (
		SELECT Dept_id 
        FROM Departments
        WHERE Dept_name = 'Computer'
    );
    
--  8. Find the names of all departments where the professors joined in year 2015 (or date of joining is 1-1-2015).(subquery)
 SELECT Dept_name
	FROM Departments 
    WHERE Dept_id IN 
    ( 
		SELECT Dept_id
		FROM professors
		WHERE Date_of_join = '2015-01-01'
    );

    

