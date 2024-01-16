-- Create Data base
CREATE DATABASE Tables;
USE Tables;


-- Create Branch table
CREATE TABLE Branch (
  Branch_no INT PRIMARY KEY,
  Manager_id INT,
  Branch_address VARCHAR (200) NOT NULL,
  Contact_no INT NOT NULL
);

-- Create Employee Table
CREATE TABLE Employee (
  Emp_id INT PRIMARY KEY,
  Emp_name VARCHAR (40) NOT NULL, 
  Position VARCHAR (50), 
  Salary DECIMAL (10,2),
  Branch_no INT, 
  CONSTRAINT fk_E FOREIGN KEY (Branch_no) REFERENCES Branch (Branch_no)
);
 
 -- Create Customer table
CREATE TABLE Customer (
  Customer_id INT PRIMARY KEY,
  Customer_name VARCHAR (40) NOT NULL , 
  Customer_address VARCHAR (200) NOT NULL, 
  Reg_date DATE
);

-- Create IssueStatus table
CREATE TABLE IssueStatus (
  Issue_id  INT PRIMARY KEY,
  Issued_cust INT,
  CONSTRAINT fk_I FOREIGN KEY (Issued_cust) REFERENCES Customer (Customer_id), 
  Issued_book_name VARCHAR (100),
  Issue_date DATE,
  Isbn_book VARCHAR (25),
  CONSTRAINT fk2_I FOREIGN KEY (Isbn_book) REFERENCES Books (ISBN)
);

-- Create ReturnStatus table
CREATE TABLE ReturnStatus (
  Return_id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR (100), 
  Return_date DATE,
  Isbn_book2 VARCHAR (25),
  CONSTRAINT FK_R FOREIGN KEY (Isbn_book2) REFERENCES Books (ISBN)
);

-- Create Books table
CREATE TABLE Books (
  ISBN VARCHAR (25) PRIMARY KEY,
  Book_title VARCHAR (100),
  Category VARCHAR (100), 
  Rental_price DECIMAL (10,2),
  Status VARCHAR (3),
  CONSTRAINT ch_b CHECK (Status in ('Yes', 'No')),
  Author VARCHAR (40),
  Publisher VARCHAR (40)
  );
  
  
-- Insert Values into Branch table
INSERT INTO Branch (Branch_no, Manager_id, Branch_address, Contact_no) VALUES
(1, 101, '123 Main St', 5551234),
(2, 102, '456 Oak St', 5555678),
(3, 103, '789 Elm St', '5559012');

-- Insert Values into Employee table
INSERT INTO Employee (Emp_id, Emp_name, Position, Salary, Branch_no) VALUES
(101, 'John', 'Manager', 60000.00, 1),
(102, 'Alex', 'Manager', 80000.00, 2),
(103, 'Dev',  'Manager', 65000.00, 3), 
(104, 'James', 'Clerk', 25000.00, 1),
(105, 'Varun', 'Librarian', 45000.00, 1),
(106, 'Alice', 'Assistant', 40000.00, 1),
(107, 'Sulha', 'Technician', 48000.00, 1),
(108, 'Sheba', 'Deputy librarian', 36000.00, 1),
(109, 'Aslam', 'Coordinator', 50000.00, 1),
(110, 'Amegha', 'Clerk', 33500.00, 2),
(111, 'Hiba', 'Librarian', 49500.00, 2),
(112, 'Jutsin', 'Librarian', 50000.00,3);

-- Insert Values into Customer table
INSERT INTO Customer (Customer_id, Customer_name, Customer_address, Reg_date) VALUES
(1, 'Tanha', 'B52', '2021-01-12'),
(2, 'Nazil', 'B32',  '2020-01-25'),
(3, 'Ladeed', 'C11',  '2022-02-01'),
(4, 'Anu',   'A12',  '2022-01-18'),
(5, 'Ansil', 'B5',   '2023-01-01'),
(6, 'Rahul', 'C10',  '2022-10-14'),
(7, 'Prem', 'H20', '2020-11-15');

-- Insert Values into IsssueStatus table
INSERT INTO IssueStatus ( Issue_id , Issued_cust , Issued_book_name, Issue_date, Isbn_book ) VALUES
(2, 6, 'Educated', '2023-08-19', '978-0-399-59050-4'),
(3, 2, 'The Salient Patient', '2023-06-24', '978-1-250-30169-7'),
(4, 1, 'The Glass Catle', '2023-06-08', '978-0-7432-4753-5'),
(5, 3, 'The Silent Symphony', '2023-12-03', '978-1-234567-89-0');


-- Insert Values into ReturnStatus table

INSERT INTO ReturnStatus (Return_id, Return_cust, Return_book_name , Return_date, Isbn_book2) VALUES
(1, 6, 'Educated', '2024-01-01', '978-0-399-59050-4'),
(2, 3, 'The Silent Symphony', '2024-02-03', '978-1-234567-89-0'),
(3, 1, 'The Glass Catle', '2023-12-30', '978-0-7432-4753-5'),
(4, 2, 'The Salient Patient', '2024-01-15', '978-1-250-30169-7');


-- Insert values into Books table
INSERT INTO Books (ISBN, Book_title, Category, Rental_price, Status, Author, Publisher) VALUES
('978-1-250-30169-7', 'The Salient Patient', 'Psychological Thriller', 4.99, 'Yes', 'Alex Michaelides', 'Celadon Books'),
('978-0-399-59050-4', 'Educated', 'Memoir', 6.99, 'Yes', 'Tara Westover', 'Random House'),
('978-0-385-53463-5', 'The Night Circus', 'Fiction', 6.99, 'No', 'Erim Morgenstern', 'Doubleday'),
('978-0-7432-4753-5', 'The Glass Catle', 'Memoir', 5.99, 'Yes', 'Jeanette Walls', 'Scribner'),
('978-1-234567-89-0', 'The Silent Symphony', 'Mystery', 4.99, 'Yes', 'Jane Doe', 'Harper Collins'),
('978-0-987654-32-1', 'Beyond the Horizon', 'Fiction', 7.99, 'No', 'John Smith', 'Orbit Books'),
('978-6-789012-34-5', 'History Unveiled', 'History', 5.49, 'No', 'Thomas Anderson', 'Oxford University press');

SELECT * FROM Branch;
SELECT * FROM Employee;
SELECT * FROM Customer;
SELECT * FROM IssueStatus;
SELECT * FROM ReturnStatus;
SELECT * FROM Books;
  




-- 1.Retrive the book title, category, and rental prices for all avaialable books.
SELECT Book_title, Category, Rental_price FROM Books
WHERE Status='Yes'; 

-- 2. List the employee names and their respective salaries in descending order of salary
SELECT Emp_name, Salary FROM Employee
ORDER BY  Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT I.Issued_book_name, C.Customer_name FROM IssueStatus I
LEFT JOIN Customer C ON C.Customer_id = I.Issue_id;

-- 4.Display the total count of books in each category
SELECT Category, COUNT(*) AS Total_books
FROM Books GROUP BY Category;

-- 5.Retrieve the employee names and their positions for the employees whose salaries are above RS.50,000.
 SELECT Emp_name, Position FROM Employee
 WHERE Salary>50000;
 
 -- 6.List the Customers names Whose registered before 2022-01-01 and have not issued any book yet
 SELECT Customer_name FROM Customer 
 WHERE Reg_date<'2022-01-01' AND  Customer_id NOT IN (SELECT Issued_Cust FROM IssueStatus);
 
 -- 7. Display the branch numbers and the total count of employees in each branch
  SELECT Branch_no, COUNT(*) AS Total_employees FROM Employee
  GROUP BY Branch_no;
  
  -- 8.Display the names of Customers who have issued books in the month of june 2003.
  SELECT C.Customer_name FROM Customer C 
  LEFT JOIN IssueStatus I ON I.Issued_cust = C.Customer_id
  WHERE MONTH(I.Issue_date)='06'AND YEAR(I.Issue_date)='2023';
  
-- 9. Retrieve book_title from the book table containing 'history'.
SELECT Book_title FROM Books
WHERE Book_title LIKE '%History%' ;

 SELECT Book_title FROM Books
 WHERE Category = 'History';
 
 -- 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, COUNT(*) AS total_employee
FROM Employee GROUP BY Branch_no
HAVING total_employee>5;

 
  








  




