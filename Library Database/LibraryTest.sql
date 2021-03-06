CREATE DATABASE LibraryTest

USE LibraryTest
GO


--Creating tables for the database.
CREATE TABLE Library_Branch (
	BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	BranchName VARCHAR(50) NOT NULL,
	Address VARCHAR(75) NOT NULL
);

CREATE TABLE Books (
	BookID INT PRIMARY KEY NOT NULL IDENTITY (100,1),
	Title VARCHAR(50) NOT NULL,
	PublisherName VARCHAR(50) NOT NULL,
	CONSTRAINT fk_PublisherName FOREIGN KEY (PublisherName) REFERENCES Publisher(PublisherName)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
 
--Some tables didn't have a primary key since it was actually the foreign key to references others.
--Note to self: review how to set up a foreign key
CREATE TABLE Book_Copies (
	BookID INT NOT NULL,
	BranchID INT NOT NULL,
	Number_Of_Copies INT NOT NULL,
	CONSTRAINT fk_Books2 FOREIGN KEY (BookID) REFERENCES Books(BookID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT fk_Library_Branch1 FOREIGN KEY (BranchID) REFERENCES Library_Branch(BranchID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE Book_Loans (
	BookID INT NOT NULL,
	BranchID INT NOT NULL,
	CardNo INT NOT NULL,
	DateOut DATE NOT NULL,
	DateDue DATE NOT NULL,
	CONSTRAINT fk_Books1 FOREIGN KEY (BookID) REFERENCES Books(BookID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT fk_Library_Branch FOREIGN KEY (BranchID) REFERENCES Library_Branch(BranchID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT fk_Borrower FOREIGN KEY (CardNo) REFERENCES Borrower(CardNo)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE Borrower (
	CardNo INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	Name VARCHAR(50) NOT NULL,
	Address VARCHAR(75) NOT NULL,
	Phone INT NOT NULL
);

CREATE TABLE Publisher (
	PublisherName VARCHAR(50) PRIMARY KEY NOT NULL,
	Address VARCHAR(75) NOT NULL,
	Phone INT NOT NULL
);

CREATE TABLE Book_Authors (
	BookID INT NOT NULL,
	AuthorName VARCHAR(50) NOT NULL,
	CONSTRAINT fk_Books FOREIGN KEY (BookID) REFERENCES Books(BookID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Inserting data in the tables

INSERT INTO Library_Branch
	(BranchName, Address)
	VALUES
	('Central', '123 Main Street'),
	('Sharpstown', '678 Cutting Court'),
	('Mountain', '459 Rocky Road'),
	('Grassburg', '260 Country Lane')
SELECT * FROM Library_Branch --Just checking to make sure it populated properly.

INSERT INTO Books
	(Title, PublisherName)
	VALUES
	('The Lost Tribe', 'Henry Holt & Co.'),
	('A Tale of Two Cities','Chapman & Hall'),
	('The Lord of the Rings','Iron Crown Enterprises'),
	('The Adventures of Alice in Wonderland','Macmillan Publishers'),
	('The Catcher in the Rye','Little, Brown & Company'),
	('The Adventures of Sherlock Holmes','George Newnes'),
	('Cujo','Viking Press'),
	('Anne of Green Gables','L.C. Page & Co.'),
	('Eat, Pray, Love', 'Penguin Books'),
	('The Shining', 'Anchor Books'),
	('Harry Potter & the Sorcerer''s Stone', 'Bloomsbury Publishing'),
	('Charlotte''s Web', 'HarperCollins'),
	('To Kill A Mockingbird', 'J.B. Lippincott & Co.'),
	('The Hunger Games', 'Scholastic Co.'),
	('Things Fall Apart', 'William Heinemann'),
	('Where The Wild Things Are', 'Harper & Row'),
	('The Very Hungry Caterpillar','Penguin Putnam'),
	('The Old Man and the Sea', 'Schribner'),
	('The Cat in the Hat', 'Random House'),
	('Pride and Predjudice','Simon & Schuster')
;


--INSERTs were failing because the BookID (foreign key) value was null - I thought it would pull it over
--from the table it was linked to but it did not. Have to manually input.
INSERT INTO Book_Authors
	(BookID, AuthorName)
	VALUES
	(104, 'Edward Marriot'),
	(105, 'Charles Dickens'),
	(106, 'JRR Tolkien'),
	(107, 'Lewis Carroll'),
	(108, 'J.D. Salinger'),
	(109, 'Sir Arthur Conan Doyle'),
	(110, 'Stephen King'),
	(111, 'Lucy Maud Montgomery'),
	(112, 'Elizabeth Gilbert'),
	(113, 'Stephen King'),
	(114, 'JK Rowling'),
	(115, 'E.B.White'),
	(116, 'Harper Lee'),
	(117, 'Suzanne Collins'),
	(118, 'Chinua Achebe'),
	(119, 'Maurice Sendak'),
	(120, 'Eric Carle'),
	(121, 'Ernest Hemmingway'),
	(122, 'Dr. Seuss'),
	(123, 'Jane Austen')
;

INSERT INTO Publisher
	(PublisherName, Address, Phone)
	VALUES
	('Henry Holt & Co.','175 Fifth Avenue, New York, NY 10010', 888-330-8477),
	('Chapman & Hall','115 5th Avenue Floor 4, New York, NY 10003', 212-564-1060),
	('Iron Crown Enterprises','37 Fulbourn Road, Cambridge, United Kingdom', 123-456-7890),
	('Macmillan Publishers','16365 James Madison Highway, Gordonsville, VA 22942',888-330-8477),
	('Little, Brown & Company','1290 Avenue Of The Americas, New York, NY 10104', 212-364-1100),
	('George Newnes','123 Oldstown Road, London, England', 541-379-6394),
	('Viking Press','375 Hudson Street, New York, NY 10014', 212-366-2000),
	('L.C. Page & Co.','245 Peachtree Center Avenue, Atlanta, GA 30303, USA', 404-669-9400),
	('Penguin Books','375 Hudson Street, New York, NY 10014', 212-366-2000),
	('Anchor Books','1745 Broadway, New York, NY 10019', 212-940-7390),
	('Bloomsbury Publishing', '1385 Broadway, New York, NY 10018', 212-419-5300),
	('HarperCollins','195 Broadway, New York, NY 10007', 212-207-7000),
	('J.B. Lippincott & Co.','2001 Market Street, Philadelphia, PA 19103',215-521-8300),
	('Scholastic Co.', '557 Broadway, New York City, New York 10012',1-800-724-6527),
	('William Heinemann', 'P. O. Box 6926, Portsmouth, NH 03802-6926', 603-431-7894 ),
	('Harper & Row', '195 Broadway, New York, NY 10007', 212-207-7000),
	('Penguin Putnam', '375 Hudson Street, New York, NY 10014', 212-366-2000),
	('Schribner','153-157 Fifth Avenue, New York City', 212-632-4915),
	('Random House','1745 Broadway, New York, NY 10019', 212-940-7390),
	('Simon & Schuster','1230 Avenue of the Americas, New York, NY 10020',212-698-7000)
;

INSERT INTO Book_Copies
	(BookID, BranchID, Number_Of_Copies)
	VALUES
	(104, 2, 2), 
	(105, 2, 3),
	(106, 3, 5),
	(107, 4, 2),
	(108, 1, 7),
	(109, 2, 8),
	(110, 1, 4),
	(111, 4, 2),
	(112, 1, 2),
	(113, 1, 3),
	(114, 3, 6),
	(115, 4, 8),
	(116, 1, 3),
	(117, 2, 4),
	(118, 3, 2),
	(119, 4, 5),
	(120, 1, 3),
	(121, 2, 2),
	(122, 3, 5),
	(123, 4, 4),
	(104, 1, 3),
	(105, 3, 2),
	(106, 4, 4),
	(107, 1, 2),
	(112, 2, 3),
	(108, 3, 2),
	(109, 4, 2),
	(110, 2, 3),
	(111, 3, 4),
	(113, 4, 5),
	(114, 1, 2),
	(115, 2, 3),
	(116, 3, 4),
	(117, 4, 1),
	(118, 1, 3),
	(119, 2, 2),
	(120, 3, 4),
	(121, 4, 5),
	(122, 1, 5),
	(123, 2, 4)
;

INSERT INTO Book_Loans
	(BookID, BranchID, CardNo, DateOut, DateDue)
	VALUES
	(108, 1, 1,'2018-10-04', '2018-10-18'),
	(112, 1, 1,'2018-10-04', '2018-10-18'),
	(116, 1, 1,'2018-10-04', '2018-10-18'),
	(120, 1, 1,'2018-10-04', '2018-10-18'),
	(104, 1, 1,'2018-10-04', '2018-10-18'),
	(117, 2, 2,'2018-10-01', '2018-10-15'),
	(121, 2, 3,'2018-10-04', '2018-10-18'),
	(111, 4, 4,'2018-09-28', '2018-10-12'),
	(120, 1, 5,'2018-09-22', '2018-10-06'),
	(113, 1, 6,'2018-10-01', '2018-10-15'),
	(123, 4, 7,'2018-10-02', '2018-10-16'),
	(106, 3, 8,'2018-10-04', '2018-10-18'),
	(110, 1, 8,'2018-10-04', '2018-10-18'),
	(114, 3, 8,'2018-10-04', '2018-10-18'),
	(118, 3, 8,'2018-10-04', '2018-10-18'),
	(122, 3, 8,'2018-09-29', '2018-10-13'),
	(108, 1, 2,'2018-06-04', '2018-06-18'),
	(112, 1, 2,'2018-06-04', '2018-06-18'),
	(116, 1, 2,'2018-06-04', '2018-06-18'),
	(120, 1, 2,'2018-06-04', '2018-06-18'),
	(104, 1, 2,'2018-06-04', '2018-06-18'),
	(117, 2, 1,'2018-06-01', '2018-06-15'),
	(121, 2, 4,'2018-06-04', '2018-06-18'),
	(111, 4, 3,'2018-05-28', '2018-06-12'),
	(120, 1, 6,'2018-05-22', '2018-06-06'),
	(113, 1, 7,'2018-06-01', '2018-06-15'),
	(123, 4, 8,'2018-06-02', '2018-06-16'),
	(106, 3, 5,'2018-05-04', '2018-06-18'),
	(110, 1, 5,'2018-06-04', '2018-06-18'),
	(114, 3, 5,'2018-06-04', '2018-06-18'),
	(118, 3, 5,'2018-06-04', '2018-06-18'),
	(122, 3, 5,'2018-05-29', '2018-06-13'),
	(108, 1, 5,'2018-03-04', '2018-03-18'),
	(112, 1, 5,'2018-03-04', '2018-03-18'),
	(116, 1, 7,'2018-03-04', '2018-03-18'),
	(120, 1, 6,'2018-03-04', '2018-03-18'),
	(104, 1, 4,'2018-03-04', '2018-03-18'),
	(117, 2, 3,'2018-03-01', '2018-03-15'),
	(121, 2, 8,'2018-03-04', '2018-03-18'),
	(111, 4, 1,'2018-02-28', '2018-03-12'),
	(120, 1, 4,'2018-02-22', '2018-03-06'),
	(113, 1, 8,'2018-03-01', '2018-03-15'),
	(123, 4, 1,'2018-03-02', '2018-03-16'),
	(106, 3, 2,'2018-03-04', '2018-03-18'),
	(110, 1, 2,'2018-03-04', '2018-03-18'),
	(114, 3, 2,'2018-03-04', '2018-03-18'),
	(118, 3, 2,'2018-10-04', '2018-10-18'),
	(122, 3, 2,'2018-09-29', '2018-10-13'),
	(118, 3, 5,'2018-10-04', '2018-10-18'),
	(122, 3, 1,'2018-09-29', '2018-10-13')
;

INSERT INTO Borrower
	(Name, Address, Phone)
	VALUES
	('John Doe','Portland, OR', 123-456-7890),
	('Jane Smith','Tigard, OR', 123-456-7890),
	('Chris Johnson','Hillsboro, OR', 123-456-7890),
	('Michael Reid','Portland, OR', 123-456-7890),
	('Sarah Dotson','Tualatin, OR', 123-456-7890),
	('Kyle Steward','Beaverton, OR', 123-456-7890),
	('Madison Jackson','Portland, OR', 123-456-7890),
	('Peter Ross','Portland, OR', 123-456-7890),
	('Nick Strong', 'Beaverton, OR', 123-456-7890)
;


--Query #1 How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"
CREATE PROCEDURE uspHowManyCopies
@Title VARCHAR(50) = NULL,
@BranchName VARCHAR(50) = NULL
AS
	SELECT Number_of_copies AS 'Number of Books: ', Title AS 'Book Title: ', BranchName AS 'Library Branch: '
	FROM Book_Copies
	INNER JOIN Books ON Book_Copies.BookID = Books.BookID
	INNER JOIN Library_Branch ON Book_Copies.BranchID = Library_Branch.BranchID
	WHERE Title = @Title AND BranchName = @BranchName
GO

EXEC uspHowManyCopies 'The Lost Tribe', 'Sharpstown'
GO


--Query #2 How many copies of the book titled "The Lost Tribe" are owned by each library branch
CREATE PROCEDURE uspTotalCopies
@Title VARCHAR (50) = NULL
AS
	SELECT Number_of_Copies AS 'Number of Books: ', Title AS 'Book Title: ', BranchName AS 'Library Branch: '
	FROM Book_Copies
	INNER JOIN Books ON Book_Copies.BookID = Books.BookID
	INNER JOIN Library_Branch ON Book_Copies.BranchID = Library_Branch.BranchID
	WHERE Title = @Title
GO

EXEC uspTotalCopies 'The Lost Tribe'
GO


--Query #3 Retrieve all names of borrowers who don't have books checked out.
CREATE PROCEDURE uspNoCheckouts
AS
	SELECT Name AS 'No Checkouts: '
	FROM Borrower
	WHERE CardNo NOT IN (SELECT CardNo FROM Book_Loans)
GO

EXEC uspNoCheckouts
GO


-- Query #4 Sharpstown due on a date
CREATE PROCEDURE uspBooksDueToday
@Today DATE,
@Library varchar(50)
AS
	SELECT Name 'Name: ', a.Address 'Address: ', c.Title 'Title: '
		FROM Borrower a
		INNER JOIN Book_Loans b ON a.CardNo = b.CardNo
		INNER JOIN Books c ON b.BookID = c.BookID
		INNER JOIN Library_Branch d ON b.BranchID = d.BranchID
			WHERE DateDue = @Today AND BranchName = @Library
GO

EXEC uspBooksDueToday '2018-10-05', 'Sharpstown' 
GO


--Query #5 For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
CREATE PROCEDURE uspTotalBooksCheckedOut
@Library VARCHAR(50)
AS
	SELECT Count(a.BranchID) as TotalNumber, BranchName
		FROM Book_Loans AS a
		INNER JOIN Library_Branch AS b ON a.BranchID =b.BranchID
			WHERE BranchName = @Library
			GROUP BY BranchName
GO

EXEC uspTotalBooksCheckedOut 'Mountain'
GO


-- Query #6 Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out.
CREATE PROCEDURE uspBooksCheckedOut
AS
	SELECT COUNT(Book_Loans.CardNo) AS 'Number of Books:', name AS 'Name:', address AS 'Address:'
	FROM Book_Loans
	INNER JOIN Borrower ON Book_Loans.CardNo = Borrower.CardNo
	GROUP BY name, address
	HAVING COUNT(Book_Loans.CardNo) >= 5
GO

EXEC uspBooksCheckedOut
GO


--Query #7 For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
CREATE PROCEDURE uspGetBookByAuthor
@Author VARCHAR(50) = NULL,
@Library VARCHAR(50) =NULL
AS
	SELECT Title, AuthorName, Number_of_Copies, BranchName
	FROM Books
	INNER JOIN Book_Authors ON Books.BookID = Book_Authors.BookID
	INNER JOIN Book_Copies ON  Books.BookID = Book_Copies.BookID
	INNER JOIN Library_Branch ON Book_Copies.BranchID = Library_Branch.BranchID
	WHERE AuthorName = @Author AND BranchName = @Library
GO

EXEC uspGetBookByAuthor 'Stephen King', 'Central'
GO