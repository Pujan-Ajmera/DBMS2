--Part – A
--1. Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures.
	--Department
	create or alter procedure PR_Insert_Department
	@departmentid int,@DepartmentName varchar(30)
	as
	Begin
	insert into Department values(@departmentid,@DepartmentName);
	end
	exec PR_Insert_Department 5,'sales';
	
	create or alter procedure PR_Update_Department
	@departmentid int,@DepartmentName varchar(30)
	as
	Begin
	update Department
	set departmentname=@departmentname
	where Departmentid=@departmentid
	end

	exec PR_Update_Department 5,'Hoogy';

	create or alter procedure PR_Delete_Department
	@departmentid int
	as
	Begin
	delete from department
	where DepartmentID = @departmentid
	end

	exec PR_Delete_Department 5
	select * from Department

	--Designation
	create or alter procedure PR_Insert_Designation
	@designationid int,@designationname varchar(30)
	as
	Begin
	insert into Designation values(@designationiD,@designationname);
	end
	exec PR_Insert_Designation 16,'vanand';
	
	create or alter procedure PR_Update_Designation
	@designationid int,@designationName varchar(30)
	as
	Begin
	update Designation
	set designationname=@designationname
	where designationid=@designationid
	end

	exec PR_Update_Designation 16,'Berozgar';

	create or alter procedure PR_Delete_Designation
	@designationid int
	as
	Begin
	delete from designation
	where designationid= @designationid
	end

	exec PR_Delete_Designation 16
	select * from designation

	--person
	create or alter proc PR_Insert_Person
	@FirstName varchar(100),@LastName varchar(50),@Salary int,@joiningdate datetime,@DepartmentID int,@DesignationID int
	as
	begin
	INSERT INTO Person (FirstName, LastName, Salary, JoiningDate, DepartmentID, DesignationID)
    VALUES (@FirstName, @LastName, @Salary, @JoiningDate, @DepartmentID, @DesignationID);
	end
	
	EXEC PR_Insert_Person 'Rajkumar', 'Gondaliya', 25000, '2022-02-20', 4, 14;
	select * from person

	create or alter procedure PR_Update_Person
	@personid int,@firstname varchar(30)
	as
	Begin
	update person
	set FirstName=@firstname
	where personid=@PERSONID
	end

	EXEC PR_Update_Person 108,'Dhruvs'
	
	create or alter procedure PR_Delete_Person
	@personid int
	as
	Begin
	delete from
	person
	where personid=@PERSONID
	end

	EXEC PR_delete_Person 108
--2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY
	--department
	create or alter Proc PR_Select_With_PK
	@pid int
	as
	begin
		select * from department where Departmentid = @pid
	end

	exec PR_Select_With_PK 1

	--designation
	create or alter Proc PR_Select_With_PK_designtion
	@desid int
	as
	begin
		select * from designation where designationid= @desid
	end

	exec PR_Select_With_PK_designtion 12


	--person
	create or alter Proc PR_Select_With_PK_person
	@pid int
	as
	begin
		select * from person where PersonID= @pid
	end

	exec PR_Select_With_PK_person 102
--3. Department, Designation & Person Table’s (If foreign key is available then do write join and take
	--columns on select list)
	--department
	create or alter procedure PR_Details
	as
	begin
		select * from department
	end

	exec PR_Details

	--Designation
	create or alter procedure PR_Details_Designation
	as
	begin
		select * from Designation
	end

	exec PR_Details_Designation

	--person
	create or alter procedure PR_Details_Person
	as
	begin
		select * from Person p join Department d on p.DepartmentID = d.DepartmentID
		join Designation de on p.DesignationID = de.DesignationID
	end



	exec PR_Details_perSon

--4. Create a Procedure that shows details of the first 3 persons.
	create or alter procedure PR_Top_3_Details
	as
	begin
		select top 3 * from Person p join Department d on p.DepartmentID = d.DepartmentID
		join Designation de on p.DesignationID = d.DesignationID
	end

	exec PR_Top_3_Details

	
	select * from person
--Part – B
--5. Create a Procedure that takes the department name as input and returns a table with all workers
--working in that department.
	create or alter procedure PR_Give_Details_from_Department
	@department_name varchar(50)-- dont forget to use the datatye this created a mess that time
	as 
	begin
		select * from Person p join department d on p.departmentid = d.departmentid where d.departmentname = @department_name
	end

	exec PR_Give_Details_from_Department 'it'
--6. Create Procedure that takes department name & designation name as input and returns a table with
--worker’s first name, salary, joining date & department name.
	create or alter procedure PR_Give_Details_from_Department_And_Designation
	@department_name varchar(50),@designation_name varchar(50)-- dont forget to use the datatye this created a mess that time
	as 
	begin
		select p.firstname , p.salary, p.joiningdate, d.departmentname from Person p join department d on p.departmentid
		= d.departmentid 
			join Designation de on de.DesignationID= p.DesignationID
		where d.departmentname = @department_name and de.DesignationName = @designation_name
	end


	exec PR_Give_Details_from_Department_And_Designation 'hr','ceo'
--7. Create a Procedure that takes the first name as an input parameter and display all the details of the
--worker with their department & designation name.
create or alter procedure PR_Give_Details_from_First_Name
	@first_name varchar(50)-- dont forget to use the datatye this created a mess that time
	as 
	begin
		select p.firstname , p.salary, p.joiningdate, d.departmentname from Person p join department d on p.departmentid
		= d.departmentid 
			join Designation de on de.DesignationID= p.DesignationID
		where p.FirstName = @first_name
	end

	exec PR_Give_Details_from_First_NaME 'bhoomi'
--8. Create Procedure which displays department wise maximum, minimum & total salaries.
	create or alter procedure PR_Required_Details
	as 
	begin
		select d.DepartmentName,max(salary) as MAX_Salary,min(salary),sum(Salary) from person p join department d on p.DepartmentID = d.departmentid
		group by d.DepartmentName
	end

	exec PR_Required_Details
--9. Create Procedure which displays designation wise average & total salaries

create or alter procedure PR_Required_Details_designation
	as 
	begin
		select d.DesignationName,avg(Salary) as Average_salary from person p join Designation d on p.DesignationID = d.DesignationID
		group by d.DesignationName
	end

	exec PR_Required_Details_designation

--	Part – C
--10. Create Procedure that Accepts Department Name and Returns Person Count.
	create or alter procedure PR_Accepts_Department_Name_and_Returns_Person_Count
	@department_name varchar(50)
	as
	begin
		select count(p.personid) from person p join department d on p.departmentid = d.departmentid where d.DepartmentName = @department_name
	end

	exec PR_Accepts_Department_Name_and_Returns_Person_Count 'admin'
	
	exec PR_Accepts_Department_Name_and_Returns_Person_Count 'ceo'
--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than
--input salary value along with their department and designation details.
	create or alter procedure PR_Return_Greater_Salary
	@salary int-- dont forget to use the datatye this created a mess that time
	as 
	begin
		select p.firstname , p.salary, d.departmentname ,de.designationname from Person p join department d on p.departmentid
		= d.departmentid 
			join Designation de on de.DesignationID= p.DesignationID
		where p.Salary>@salary
	end

	exec PR_Return_Greater_Salary 55000
--12. Create a procedure to find the department(s) with the highest total salary among all departments.
	create or alter procedure PR_Get_Highest_Of_Higest_salary_departments
	as 
	begin
		select top 1 d.departmentname,max(salary) from person p join department d on p.DepartmentID = d.DepartmentID group by d.DepartmentName order by max(salary) desc
	end

	exec PR_Get_Highest_Of_Higest_salary_departments
--13. Create a procedure that takes a designation name as input and returns a list of all workers under that
--designation who joined within the last 10 years, along with their department.
	create or alter procedure PR_Get_Required_Details
	@designationname varchar(50)
	as 
	begin
		select p.firstname , d.DepartmentName from person p join Department d on p.DepartmentID = d.DepartmentID join Designation de 
		on de.DesignationID = p.DesignationID where DATEDIFF(yy,p.joiningdate,GETDATE())<=11 and de.DesignationName = @designationname--chela 10 years che atle 
	end
	exec PR_Get_Required_Details 'ceo'
--14. Create a procedure to list the number of workers in each department who do not have a designation
--assigned.
	create or alter procedure PR_NO_Designation_Workers
	as 
	begin
		SELECT 
    COUNT(p.PersonID) AS WorkerCount, 
    d.DepartmentName
FROM 
    Person p
JOIN 
    Department d ON p.DepartmentID = d.DepartmentID
WHERE 
    p.DesignationID IS NULL
GROUP BY 
    d.DepartmentName;

		end
		execute PR_NO_Designation_Workers
--15. Create a procedure to retrieve the details of workers in departments where the average salary is above 12000
		CREATE OR ALTER PROCEDURE PR_AVG_Salary_Less_Than
AS
BEGIN
    SELECT 
        d.DepartmentName,        
        AVG(p.Salary) AS AvgSalary 
    FROM 
        Person p
    JOIN 
        Department d 
    ON 
        p.DepartmentID = d.DepartmentID
    GROUP BY 
        d.DepartmentName        
    HAVING 
        AVG(p.Salary) <= 12000; 
END;


exec PR_AVG_Salary_Less_Than