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

select top 1 * from Products
where Price > (select avg(Price) from Products);

select createdAt,
	Price,
	(select ProductName from Products
	where Products.Id = Orders.ProductId) as Product
from Orders;

select ProductName,
	Manufacturer,
	Price,
	(select avg(Price) from Products as SubProds
	where SubProds.Manufacturer = Prods.Manufacturer) as AvgPrice
from Products as Prods
where Price >
	(select avg(Price) from Products as SubProds
	where SubProds.Manufacturer = Prods.Manufacturer);

select * from Products
where Price > (select avg(Price) from Products);

select * from Customers
where Id not in (select CustomerId from Orders);

select * from Products
where Price < all(select Price from Products where Manufacturer = 'Apple');

select * from Products
where Price < any(select Price from Products where Manufacturer = 'Apple');

select *
from Customers
where exists (select * from Orders
	where Orders.CustomerId < Customers.Id);