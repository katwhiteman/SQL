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