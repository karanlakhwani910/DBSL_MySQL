CREATE TABLE Departments(
	Dept_id  INT NOT NULL PRIMARY KEY, 
    Dept_name VARCHAR(15) NOT NULL
    );

INSERT INTO Departments VALUES
	(10, 'Computer'),
    (20,'IT'),
    (30, 'E&TC'),
    (40,'Mechanical'),
    (50,'Civil'),
    (60, 'Instrumentation');
    
CREATE TABLE Professors(
	Prof_id  INT NOT NULL PRIMARY KEY, 
    Prof_fname VARCHAR(15) NOT NULL,
    Prof_lname VARCHAR(15) NOT NULL,
    Dept_id  INT NOT NULL,
    Designation VARCHAR(25) NOT NULL,
    Salary INT,
    Date_of_join DATE NOT NULL,
    Email VARCHAR(25),
    Phone LONG,
    City VARCHAR(15),
	FOREIGN KEY(Dept_id) REFERENCES Departments(Dept_id) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
INSERT INTO Professors VALUES
	(101, 'TONY', 'STARK', 10, 'Assistant Professor', 65000, '2014-02-20', 'tstark@gmail.com', 945612348, 'Pune'),
    (102, 'TIM', 'ADOLF', 10, 'Associate Professor', 55000, '2015-04-01', 'tadolf@gmail.com', 987425614, 'Mumbai'),
    (103, 'KIM', 'JARVIS', 20, 'Professor', 70000, '2016-03-25', 'kjarvis@gmail.com', 784562144, 'Ahmednagar'),
    (104, 'SAM', 'MILES', 30, 'Associate Professor', 50000, '2015-01-01', 'smiles@gmail.com', 887425632, 'Nagpur'),
    (105, 'KEVIN', 'HILL', 50, 'Assistant Professor', 750000, '2012-07-06', 'khill@gmail.com', 914628747, 'Nashik'),
    (106, 'CONNIE', 'SMITH', 40, 'Professor', 60000, '2015-01-01', 'csmith@gmail.com', 964782349, 'Aurangabad'),
    (107, 'ALFRED', 'KINSLEY', 20, 'Professor', 63000, '2017-05-05', 'akinsley@gmail.com', 983214568, 'Pune'),
    (108, 'PAUL', 'TIMOTHY', 10, 'Associate Professor', 45000, '2017-04-08', 'ptimothy@gmail.com', 964782556, 'Mumbai'),
    (109, 'JOHN', 'ASGHAR', 30, 'Assistant Professor', 59000, '2018-07-01', 'jasghar@gmail.com', 904258372, 'Ahmednagar'),
    (110, 'ROSE', 'SUMMERS', 50, 'Associate Professor', 61000, '2018-08-01', 'rsummers@gmail.com', 952764814, 'Nashik');
    
CREATE TABLE Works(
	Prof_id  INT NOT NULL,
	Dept_id  INT NOT NULL,
    Duration INT NOT NULL,
    FOREIGN KEY(Prof_id) REFERENCES Professors(Prof_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(Dept_id) REFERENCES Departments(Dept_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO Works VALUES
	(101, 10, 7),
	(102, 10, 6),
	(103, 20, 5),
	(104, 30, 6),
	(105, 50, 9),
	(106, 40, 6),
	(107, 20, 4),
	(108, 10, 4),
	(109, 30, 3),
	(110, 50, 3);
    
CREATE TABLE Shift(
	Prof_id  INT NOT NULL,
    Shift VARCHAR(15) NOT NULL,
    Working_hours INT NOT NULL,
	FOREIGN KEY(Prof_id) REFERENCES Professors(Prof_id) ON DELETE CASCADE ON UPDATE CASCADE
	);

INSERT INTO Shift VALUES
	(101, 'Morning', 3),
	(102, 'Evening', 4),
	(103, 'Morning', 5),
	(104, 'Morning', 4),
	(105, 'Evening', 4),
	(106, 'Morning', 3),
	(107, 'Evening', 4),
	(108, 'Morning', 4),
	(109, 'Morning', 5),
	(110, 'Evening', 3);