CREATE TABLE Customers(
	Customer_No INT NOT NULL PRIMARY KEY, 
    Customer_FName VARCHAR(15) NOT NULL, 
    Customer_LName VARCHAR(15) NOT NULL, 
    Customer_Company VARCHAR(20), 
    Customer_Address VARCHAR(25), 
    Customer_City VARCHAR(20), 
    Customer_Phone LONG
    );
    
INSERT INTO Customers VALUES
	(100, 'Vidyut', 'Ambekar', 'Microsoft', 'Kothrud', 'Pune', 945612347),
	(200, 'Pratap', 'Deshmukh', 'Google', 'Nariman Point', 'Mumbai', 987425613),
	(300, 'Kailash', 'Chandekar', 'Oracle', 'Collector Office Area', 'Ahmednagar', 784562143),
	(400, 'Mukund', 'Bapat', 'Kimberly-Clark', 'Panchawati', 'Nashik', 887425631),
	(500, 'Girish', 'Deshpande', 'Tyson Foods', 'Cidco', 'Aurangabad', 914628746),
	(600, 'Neeraj', 'Kulkarni', 'SC Johnson', 'Kandivili West', 'Mumbai', 964782348),
	(700, 'Prashant', 'Gavaskar', 'Dole Foods', 'Gorepeth', 'Nagpur', 983214569),
	(800, 'Raj', 'Bhede', 'Flowers foods', 'Gangapur Road', 'Nashik', 964782555),
	(900, 'Hari', 'Holkar', 'Electronic Arts', 'Hadapsar', 'Pune', 904258371),
	(991, 'Aditya', 'Kamble', 'Starbucks', 'Shahgunj', 'Aurangabad', 952764813);
    

CREATE TABLE Authors(
	Author_no INT NOT NULL PRIMARY KEY, 
    Author_name VARCHAR(15) NOT NULL, 
    Author_Country VARCHAR(30) NOT NULL
    );
    
INSERT INTO Authors VALUES
	(1001, 'Singh', 'India'),
	(1103, 'Smith', 'Australia'),
	(1264, 'Kaur', 'India'),
	(1300, 'Patel', 'India'),
	(1311, 'Jones', 'Australia'),
	(1423, 'Kumar', 'India'),
	(1533, 'Wilson', 'England'),
	(1604, 'Johnson', 'Australia'),
	(1911, 'Kumar', 'India'),
	(1956, 'Narayan', 'India');

CREATE TABLE Publishers(
	Publisher_No INT NOT NULL PRIMARY KEY, 
    Publisher_Name VARCHAR(25) NOT NULL, 
    Publisher_Addr VARCHAR(50), 
    estab_year YEAR NOT NULL
    );
    
INSERT INTO Publishers VALUES
	(10486, 'Prime Publications', 'Brockton Avenue, Abington', 2004),
	(10524, 'Mercury Books', 'Memorial Drive, Avon', 2010),
	(10344, 'Best Progress', 'Hartford Avenue, Bellingham', 2016),
	(10444, 'Famous Publications', 'Oak Street, Brockton', 2011),
	(12664, 'Publishing Exports', 'Parkhurst Rd, Chelmsford', 2015),
	(13254, 'The Writing Gurus', 'Memorial Dr, Chicopee', 2017),
	(12964, '24 Hours Publishers', 'Brooksby Village Way, Danvers', 2018),
	(14256, 'Prospect Park Books', 'Teaticket Hwy, East Falmouth', 2015),
	(15332, 'Radical Publish Shop', 'Fairhaven Commons Way, Fairhaven', 2020),
	(16456, 'Rare Bird Books', 'William S Canning Blvd, Fall River', 2016);
    
    
CREATE TABLE Books(
	ISBN VARCHAR(15) NOT NULL PRIMARY KEY, 
    Title VARCHAR(30) NOT NULL, 
    Unit_Price FLOAT NOT NULL, 
    Author_no INT NOT NULL, 
    Publisher_no INT NOT NULL,  
    Pub_year YEAR NOT NULL, 
    FOREIGN KEY(Author_no) REFERENCES Authors(Author_no) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(Publisher_no) REFERENCES Publishers(Publisher_no) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT INTO Books VALUES
	('99134-64-11-3', 'The Lives of the Heart',	142.56,	1001, 10486, 2000),
	('99214-43-11-2', 'A Ring of Endless Light', 346.33, 1103, 10524, 2001),
	('924-295-266-0', 'The Radiance of Pigs', 255.00, 1264, 10344, 2003),
	('99134-64-11-2', 'Full Darks, No Stars', 425.50, 1300, 10444, 2004),
	('955-200-393-8', 'The Art of Drowning', 178.61, 1311, 12664, 2005),
	('9134-64-11-3', 'The October Country',	480.46, 1423, 13254, 2015),
	('960-245-156-0', 'Wuthering Heights', 333.24, 1533, 12964, 2010),
	('99144-66-21-9', 'Of Mice and Men', 150.00, 1604, 14256, 2015),
	('960-245-155-0', 'House of Leaves', 313.20, 1911, 15332, 2004),
	('98134-20-77-5', 'Wide Sargasso Sea', 220.40, 1956, 16456, 2006);

CREATE TABLE Orders(
	Order_No INT NOT NULL PRIMARY KEY, 
    Customer_No INT NOT NULL, 
    ISBN VARCHAR(15) NOT NULL, 
    Quantity INT, 
    Order_Date DATE, 
    FOREIGN KEY(Customer_No) REFERENCES Customers(Customer_No) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(ISBN) REFERENCES Books(ISBN) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
INSERT INTO Orders VALUES
	(01008,	700, '99134-64-11-3', 1, '2019-01-13'),
	(01009,	300, '99214-43-11-2', 2, '2019-04-05'),
	(01010,	100, '924-295-266-0', 1, '2019-10-25'),
	(01011,	991, '99134-64-11-2', 3, '2020-02-15'),
	(01012,	900, '955-200-393-8', 2, '2020-03-21'),
	(01013,	700, '9134-64-11-3',  1, '2020-06-15'),
	(01014,	200, '960-245-156-0', 4, '2020-09-11'),
	(01015,	800, '99144-66-21-9', 1, '2021-05-10'),
	(01016,	500, '960-245-156-0', 2, '2021-07-17'),
	(01017,	600, '98134-20-77-5', 1, '2021-08-10');
