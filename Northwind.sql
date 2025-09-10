use TamrinPayani

GO

--1

select * 
from Shippers

--2

select 
	CategoryName,
	 Description
from Categories

--3

Select
FirstName
,LastName
,HireDate
From Employees
Where
Title = 'Sales Representative'

--4

Select
FirstName
,LastName
,HireDate
From Employees
Where
Title = 'Sales Representative' and Country = 'USA'

--5

select  *
from Orders 
where EmployeeID = 5

--6

Select
SupplierID
,ContactName
,ContactTitle
From Suppliers
Where
ContactTitle != 'Marketing Manager'

--7

select 
	ProductID,
	ProductName
from Products
where ProductName like '%queso%'

--8

Select
	OrderID,
	CustomerID,
	ShipCountry
From Orders
where
ShipCountry = 'France'
or ShipCountry = 'Belgium'

--9

Select
	OrderID,
	CustomerID,
	ShipCountry
From Orders
where
ShipCountry in
	(
	'Brazil',
	'Mexico',
	'Argentina',
	'Venezuela'
	)

-- 10

Select
FirstName
,LastName
,Title
,BirthDate
From Employees
Order By Birthdate desc

--11

Select
FirstName
,LastName
,Title
,DateOnlyBirthDate = convert(date, BirthDate)
From Employees
Order By Birthdate desc

--12

--select 
	FirstName,
	LastName,
	firstname + ' ' + lastname as fullname
from Employees

--13

select
	OrderID,
	ProductID,
	UnitPrice, 
	Quantity,
	UnitPrice * Quantity as totalprice
from [Order Details]
Order by 
	OrderID, 
	ProductID

--14 

SELECT 
	COUNT(*) AS TotalCustomers
FROM Customers

-- 15

select 
	MIN(orderdate)
from Orders

--16

SELECT 
	DISTINCT Country
FROM Customers
group by Country

--17

Select
	ContactTitle,
	count(*) as TotalCustomers
From Customers
Group by
	ContactTitle
Order by
	TotalCustomers desc

--18

Select
	ProductID,
	ProductName,
	CompanyName as Supplier 
From Products
Join Suppliers
	on Products.SupplierID = Suppliers.SupplierID

--19

Select
	OrderID,
	convert(date, OrderDate) as OrderDate,
	CompanyName as Shipper
From Orders
join Shippers
	on Orders.ShipVia = Shippers.ShipperID
Where
	Orders.OrderID < 10300
Order by
	Orders.OrderID

--20

Select
	CategoryName,
	count(*) as TotalProducts
From Categories
join Products
	on Categories.CategoryID = Products.CategoryID
Group by
	CategoryName
Order by
	TotalProducts desc

--21

Select
	Country,
	City,
	count(*) as TotalCustomer
From Customers
Group by
	Country,
	City
Order by
	TotalCustomer desc

--22

Select
	ProductID,
	ProductName,
	UnitsInStock,
	ReorderLevel
From Products
Where
	UnitsInStock <= ReorderLevel
Order by
	ProductID

--23

Select
	ProductID,
	ProductName,
	UnitsInStock,
	UnitsOnOrder,
	ReorderLevel,
	Discontinued
From Products
Where
	(UnitsInStock + UnitsOnOrder) <= ReorderLevel
	and Discontinued = 0
Order by
	ProductID

--24

Select
	CustomerID,
	CompanyName,
	Region
From Customers
Order by
	Case
		when Region is null then 1
		else 0
	End,
	Region,
	CustomerID

--25

Select Top 3
	ShipCountry,
	Avg(Freight) as AverageFreight
From Orders
Group by
	ShipCountry
Order by
	AverageFreight desc

--26

Select Top 3
	ShipCountry,
	avg(Freight) as AverageFreight
From Orders
Where
	OrderDate >= '20150101'
	and OrderDate < '20160101'
Group by
	ShipCountry
Order by
	AverageFreight desc

--27 (correct from)

Select Top 3
	ShipCountry,
	avg(Freight) as AverageFreight
From Orders
Where
	OrderDate >= '2015-01-01'
	and OrderDate < '2016-01-01'
Group by
	ShipCountry
Order by
	AverageFreight desc

--28

Select Top 3
	ShipCountry,
	Avg(Freight) as AverageFreight
From Orders
Where
	OrderDate >= DATEADD(month, -12, (Select MAX(OrderDate) from Orders))
Group by
	ShipCountry
Order by
	AverageFreight desc

--29

Select
	Orders.OrderID,
	Products.ProductID,
	Products.ProductName,
	[Order Details].Quantity,
	[Order Details].UnitPrice,
	([Order Details].Quantity * [Order Details].UnitPrice) as TotalPrice
From Orders
join [Order Details]
	on Orders.OrderID = [Order Details].OrderID
join Products
	on Products.ProductID = [Order Details].ProductID
Order by
	Orders.OrderID,
	Products.ProductID

--30

Select
	Customers.CustomerID as Customers_CustomerID,
	Orders.CustomerID as Orders_CustomerID
From Customers
Left Outer Join Orders
	on Orders.CustomerID = Customers.CustomerID
Where
	Orders.CustomerID is null

--31

Select
	Customers.CustomerID as Customers_CustomerID,
	Orders.CustomerID as Orders_CustomerID
From Customers
Left Outer Join Orders
	on Orders.CustomerID = Customers.CustomerID
	and Orders.EmployeeID = 4
Where
	Orders.CustomerID is null

--32

Select
	Customers.CustomerID,
	Customers.CompanyName,
	Orders.OrderID,
	TotalOrderAmount = Sum(OrderDetails.Quantity * OrderDetails.UnitPrice)
From Customers
Inner Join Orders
	on Orders.CustomerID = Customers.CustomerID
Inner Join [Order Details] as OrderDetails
	on Orders.OrderID = OrderDetails.OrderID
Where
	Orders.OrderDate >= '20160101'
	and Orders.OrderDate < '20170101'
Group by
	Customers.CustomerID,
	Customers.CompanyName,
	Orders.OrderID
Having
	Sum(OrderDetails.Quantity * OrderDetails.UnitPrice) > 10000
Order by
	TotalOrderAmount desc

--33 (using CTE)

Select
	CustomerID,
	CompanyName,
	TotalOrderAmount
From
(
	Select
		Customers.CustomerID,
		Customers.CompanyName,
		TotalOrderAmount = Sum(OrderDetails.Quantity * OrderDetails.UnitPrice)
	From Customers
	Inner Join Orders
		on Orders.CustomerID = Customers.CustomerID
	Inner Join [Order Details] as OrderDetails
		on Orders.OrderID = OrderDetails.OrderID
	Where
		Orders.OrderDate >= '20160101'
		and Orders.OrderDate < '20170101'
	Group by
		Customers.CustomerID,
		Customers.CompanyName
) as one
Where
	one.TotalOrderAmount > 15000
Order by
	one.TotalOrderAmount desc


--34 (using CTE)

Select
	CustomerID,
	CompanyName,
	TotalsWithoutDiscount,
	TotalsWithDiscount
From
(
	Select
		Customers.CustomerID,
		Customers.CompanyName,
		TotalsWithoutDiscount = Sum(OrderDetails.Quantity * OrderDetails.UnitPrice),
		TotalsWithDiscount = Sum(OrderDetails.Quantity * OrderDetails.UnitPrice * (1 - OrderDetails.Discount))
	From Customers
	Inner Join Orders
		on Orders.CustomerID = Customers.CustomerID
	Inner Join [Order Details] as OrderDetails
		on Orders.OrderID = OrderDetails.OrderID
	Where
		Orders.OrderDate >= '20160101'
		and Orders.OrderDate < '20170101'
	Group by
		Customers.CustomerID,
		Customers.CompanyName
) as [table]
Where
	[table].TotalsWithDiscount > 10000
Order by
	[table].TotalsWithDiscount desc


--35 (using CTE)

With OrdersWithEndOfMonth as
(
	Select
		Orders.EmployeeID,
		Orders.OrderID,
		Orders.OrderDate,
		EndOfMonthDate = EOMONTH(Orders.OrderDate)
	From Orders
)
Select
	EmployeeID,
	OrderID,
	OrderDate
From OrdersWithEndOfMonth
Where
	OrderDate = EndOfMonthDate
Order by
	EmployeeID,
	OrderID

--36

Select *
From Orders
Inner Join [Order Details] as OrderDetails
	on Orders.OrderID = OrderDetails.OrderID


--36 is NOT finished





















































































































































































































