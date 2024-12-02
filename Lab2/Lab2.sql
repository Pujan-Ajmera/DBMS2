CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),-- aa no use identity thi auto increment dai saki
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);
INSERT INTO Department (DepartmentID, DepartmentName)
VALUES 
(1, 'Admin'),
(2, 'IT'),
(3, 'HR'),
(4, 'Account');
select * from Department


INSERT INTO Designation (DesignationID, DesignationName)
VALUES 
(11, 'Jobber'),
(12, 'Welder'),
(13, 'Clerk'),
(14, 'Manager'),
(15, 'CEO');
select * from Designation
INSERT INTO Person (FirstName, LastName, Salary, JoiningDate, DepartmentID, DesignationID) 
VALUES 
('Rahul', 'Anshu', 56000.00, '1990-01-01', 1, 12),
('Hardik', 'Hinsu', 18000.00, '1990-09-25', 2, 11),
('Bhavin', 'Kamani', 25000.00, '1991-05-14', NULL, 11),
('Bhoomi', 'Patel', 39000.00, '2014-02-20', 1, 13),
('Rohit', 'Rajgor', 17000.00, '1990-07-23', 2, 15),
('Priya', 'Mehta', 25000.00, '1990-10-18', 2, NULL),
('Neha', 'Trivedi', 18000.00, '2014-02-20', 3, 15);
select * from person