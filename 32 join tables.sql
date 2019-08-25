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
)

select * from Orders, Customers;

select * from Orders, Customers
where Orders.CustomerId = Orders.Id;

select Customers.FirstName, Products.ProductName, Orders.CreatedAt
from Orders, Products, Customers
where Orders.CustomerId = Customers.Id and Orders.ProductId = Products.Id;

select Orders.CreatedAt, Orders.ProductCount, Products.ProductName
from Orders
join Products on Products.Id = Orders.ProductId;

select Orders.CreatedAt, Customers.FirstName, Products.ProductName
from Orders
join Products on Products.Id = Orders.ProductId
join Customers on Customers.Id = Orders.Id;

select FirstName, CreatedAt, ProductCount, Price
from Customers left join Orders
on Orders.CustomerId = Customers.Id;

select FirstName, CreatedAt, ProductCount, Price
from Customers right join Orders
on Orders.CustomerId = Customers.Id;

select Customers.FirstName, Orders.CreatedAt,
	Products.ProductName, Products.Manufacturer
from Orders
left join Customers on Orders.CustomerId = Customers.Id
left join Products on Orders.ProductId = Products.Id;

select FirstName from Customers
left join Orders on Customers.Id = Orders.CustomerId
where Orders.CustomerId is null;

select * from Orders cross join Customers;

select FirstName, count(Orders.Id)
from Customers join Orders
on Orders.CustomerId = Customers.Id
group by Customers.Id, Customers.FirstName;

select FirstName, count(Orders.Id)
from Customers left join Orders
on Orders.CustomerId = Customers.Id
group by Customers.Id, Customers.FirstName;

select Products.ProductName, Products.Manufacturer,
	sum(Orders.ProductCount * Orders.Price) as Units
from Products left join Orders
on Orders.ProductId = Products.Id
group by Products.Id, Products.ProductName, Products.Manufacturer;