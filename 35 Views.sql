USE [master];
GO

DROP DATABASE IF EXISTS productsdb;
CREATE DATABASE productsdb;
GO
USE productsdb;
CREATE TABLE Products
(
	Id INT IDENTITY PRIMARY KEY,
	ProductName NVARCHAR(30) NOT NULL,
	Manufacturer NVARCHAR(20) NOT NULL,
	ProductCount INT DEFAULT 0,
	Price MONEY NOT NULL
)
CREATE TABLE Customers
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(30) NOT NULL
);
CREATE TABLE Orders
(
	Id INT IDENTITY PRIMARY KEY,
	ProductId INT NOT NULL REFERENCES Products(Id) ON DELETE CASCADE,
	CustomerId INT NOT NULL REFERENCES Customers(Id) ON DELETE CASCADE,
	CreatedAt DATE NOT NULL,
	ProductCount INT DEFAULT 1,
	Price MONEY NOT NULL
);

INSERT INTO Products
VALUES
('iPhone 6', 'Apple', 3, 36000),
('iPhone 6S', 'Apple', 2, 41000),
('iPhone 7', 'Apple', 5, 52000),
('Galaxy S8', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000),
('Mi6', 'Xiaomi', 5, 28000),
('OnePlus 5', 'OnePlus', 6, 38000);

INSERT INTO Customers VALUES ('Tom'), ('Bob'),('Sam')

INSERT INTO Orders 
VALUES
(
	(SELECT Id FROM Products WHERE ProductName='Galaxy S8'), 
	(SELECT Id FROM Customers WHERE FirstName='Tom'),
	'2017-07-11',
	2,
	(SELECT Price FROM Products WHERE ProductName='Galaxy S8')
),
( 
	(SELECT Id FROM Products WHERE ProductName='iPhone 6S'),
	(SELECT Id FROM Customers WHERE FirstName='Tom'),
	'2017-07-13',  
	1, 
	(SELECT Price FROM Products WHERE ProductName='iPhone 6S')
),
( 
	(SELECT Id FROM Products WHERE ProductName='iPhone 6S'), 
	(SELECT Id FROM Customers WHERE FirstName='Bob'),
	'2017-07-11',  
	1,
	(SELECT Price FROM Products WHERE ProductName='iPhone 6S')
);
go

CREATE VIEW OrdersProductsCustomers as
select Orders.CreatedAt as OrderDate,
	Customers.FirstName as Customer,
	Products.ProductName as Product
from Orders inner join Products on Orders.ProductId = Products.Id
inner join Customers on Orders.CustomerId = Customers.Id;

go

select * from OrdersProductsCustomers;

go

create view ProductView
as select ProductName as Product, Manufacturer, Price
from Products;
go

insert into ProductView (Product, Manufacturer, Price)
values ('Nokia 8', 'HDC global', 18000);
select * from ProductView;

declare @ABrends table (ProductId int, ProductName nvarchar(20))

insert into @ABrends
values
	 (1, 'iPhone 8')
	,(2, 'Samsung Galaxy S8')

select * from @ABrends;

drop table if exists #ProductSummary;

CREATE TABLE #ProductSummary
(ProdId INT IDENTITY,
ProdName NVARCHAR(20),
Price MONEY)
 
INSERT INTO #ProductSummary
VALUES ('Nokia 8', 18000)
	,('iPhone 8', 56000)
 
SELECT * FROM #ProductSummary;

go

with OrdersInfo as
(
	select
		 ProductId
		,sum(ProductCount) as TotalCount
		,sum(ProductCount * Price) as TotalSum
	from Orders
	group by ProductId
)

select * from OrdersInfo;