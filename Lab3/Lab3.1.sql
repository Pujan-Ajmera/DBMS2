CREATE TABLE Departments (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE,
 ManagerID INT NOT NULL,
 Location VARCHAR(100) NOT NULL
);CREATE TABLE Employee (
 EmployeeID INT PRIMARY KEY,
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 DoB DATETIME NOT NULL,
 Gender VARCHAR(50) NOT NULL,
 HireDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 Salary DECIMAL(10, 2) NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);CREATE TABLE Projects (
 ProjectID INT PRIMARY KEY,
 ProjectName VARCHAR(100) NOT NULL,
 StartDate DATETIME NOT NULL,
 EndDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location)
VALUES
 (1, 'IT', 101, 'New York'),
 (2, 'HR', 102, 'San Francisco'),
 (3, 'Finance', 103, 'Los Angeles'),
 (4, 'Admin', 104, 'Chicago'),
 (5, 'Marketing', 105, 'Miami');

 INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID,
Salary)
VALUES
 (101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00),
 (102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00),
 (103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00),
 (104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00),
 (105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00);
 select * from Employee

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
VALUES
 (201, 'Project Alpha', '2022-01-01', '2022-12-31', 1),
 (202, 'Project Beta', '2023-03-15', '2024-03-14', 2),
 (203, 'Project Gamma', '2021-06-01', '2022-05-31', 3),
 (204, 'Project Delta', '2020-10-10', '2021-10-09', 4),
 (205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);

--Part – A
--1. Create Stored Procedure for Employee table As User enters either First Name or Last Name and based
--on this you must give EmployeeID, DOB, Gender & Hiredate.
		create or alter procedure PR_Find_By_FirstName_Or_LastName
		@name varchar(20)
		as
		begin
		select EmployeeId,Dob,Gender,Hiredate from Employee where FirstName = @name or LastName = @name
		end
		exec PR_Find_By_FirstName_Or_LastName "John"
		exec PR_Find_By_FirstName_Or_LastName "davis"
--2. Create a Procedure that will accept Department Name and based on that gives employees list who
--belongs to that department. 
	create or alter procedure PR_Department_Details
	@departmentname varchar(20)
	as
	begin
		select firstname from employee where departmentid = (select departmentid from department where DepartmentName = @departmentname)
	end

		exec PR_Department_Details "It"
		exec PR_Department_Details "hr"
--3. Create a Procedure that accepts Project Name & Department Name and based on that you must give
--all the project related details.
	create or alter procedure PR_Department_Details_new
	@projectname varchar(20),@departmentname varchar(20)
	as
	begin
		select * from projects where departmentid = (select Departmentid from Department where departmentname = @departmentname)
	end

	exec PR_Department_Details_new "Project Alpha","it" 
--4. Create a procedure that will accepts any integer and if salary is between provided integer, then those
--employee list comes in output.
	create or alter procedure PR_Get_Details_From_Salary
	@min int,@max int
	as
	begin
	select * from employee where salary >=@min and salary<=@max 
	end

	exec PR_Get_Details_From_Salary 61000,68000
--5. Create a Procedure that will accepts a date and gives all the employees who all are hired on that date. 
create or alter procedure PR_Get_Details_From_Date
	@date datetime
	as
	begin
	select * from employee where hiredate =@date
	end

	exec PR_Get_Details_From_Date '2010-06-15 '



--	Part – B
--6. Create a Procedure that accepts Gender’s first letter only and based on that employee details will be
--served.
create or alter procedure PR_Get_Details_From_First_Letter_Of_Gender
@char char(1)
as
begin
	select * from employee where gender like @char+'%'
end

exec PR_Get_Details_From_First_Letter_Of_Gender 'f'
--7. Create a Procedure that accepts First Name or Department Name as input and based on that employee
--data will come.
create or alter procedure PR_Find_By_FirstName_Or_Department
		@name varchar(20)
		as
		begin
		select * from Employee join department on department.DepartmentID = Employee.DepartmentID where FirstName = @name or DepartmentName = @name
		end
		exec PR_Find_By_FirstName_Or_Department "John"
		exec PR_Find_By_FirstName_Or_Department "it"
--8. Create a procedure that will accepts location, if user enters a location any characters, then he/she will
--get all the departments with all data.
--Part – C
--9. Create a procedure that will accepts From Date & To Date and based on that he/she will retrieve Project
--related data.
create or alter procedure PR_Details_From_Dates
		@from datetime,@to datetime
		as
		begin
		select * from projects where StartDate = @from and EndDate = @to
		end
		exec PR_Details_From_DatES "2022-01-01","2022-12-31"
--10. Create a procedure in which user will enter project name & location and based on that you must
--provide all data with Department Name, Manager Name with Project Name & Starting Ending Dates. 
create or alter procedure PR_Get_Last_Details_From_Different_Fields_Like_Location
@project_name varchar(20) ,@location varchar(20)
as
begin
select * from departments d join Employee e on d.DepartmentID=e.DepartmentID join projects p on p.DepartmentID = d.DepartmentID
where p.projectname = @project_name and d.Location = @location
end
PR_Get_Last_Details_From_Different_Fields_Like_Location "Project Gamma" ,"Los Angeles"