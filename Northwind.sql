use TamrinPayani

GO

--1

--select * 
--from Shippers

--2

--select 
--	CategoryName,
--	 Description
--from Categories

--3

--Select
--FirstName
--,LastName
--,HireDate
--From Employees
--Where
--Title = 'Sales Representative'

--4

--Select
--FirstName
--,LastName
--,HireDate
--From Employees
--Where
--Title = 'Sales Representative' and Country = 'USA'

--5

--select  *
--from Orders 
--where EmployeeID = 5

--6

--Select
--SupplierID
--,ContactName
--,ContactTitle
--From Suppliers
--Where
--ContactTitle != 'Marketing Manager'

--7

--select 
--	ProductID,
--	ProductName
--from Products
--where ProductName like '%queso%'

--8

--Select
--	OrderID,
--	CustomerID,
--	ShipCountry
--From Orders
--where
--ShipCountry = 'France'
--or ShipCountry = 'Belgium'

--9

--Select
--	OrderID,
--	CustomerID,
--	ShipCountry
--From Orders
--where
--ShipCountry in
--	(
--	'Brazil',
--	'Mexico',
--	'Argentina',
--	'Venezuela'
--	)

-- 10

--Select
--FirstName
--,LastName
--,Title
--,BirthDate
--From Employees
--Order By Birthdate desc

--11

--Select
--FirstName
--,LastName
--,Title
--,DateOnlyBirthDate = convert(date, BirthDate)
--From Employees
--Order By Birthdate desc

--12

--select 
--	FirstName,
--	LastName,
--	firstname + ' ' + lastname as fullname
--from Employees

--13

--select
--	OrderID,
--	ProductID,
--	UnitPrice, 
--	Quantity,
--	UnitPrice * Quantity as totalprice
--from [Order Details]
--Order by 
--	OrderID, 
--	ProductID

--14 

--SELECT 
--	COUNT(*) AS TotalCustomers
--FROM Customers

-- 15

--select 
--	MIN(orderdate)
--from Orders

--16

--SELECT 
--	DISTINCT Country
--FROM Customers
--group by Country

--17

--Select
--	ContactTitle,
--	count(*) as TotalCustomers
--From Customers
--Group by
--	ContactTitle
--Order by
--	TotalCustomers desc

--18

--Select
--	ProductID,
--	ProductName,
--	CompanyName as Supplier 
--From Products
--Join Suppliers
--	on Products.SupplierID = Suppliers.SupplierID






















































































































































































































