declare @name nvarchar(20), @age int;
set @name = 'Tom';
set @age = 18;
print 'Name: ' + @name;
print 'Age: ' + convert(char, @age);


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

declare @maxPrice money,
	@minPrice money,
	@diff money,
	@count int;

set @count = (select sum(ProductCount) from Orders);
select @minPrice = min(Price),
	@maxPrice = max(Price) from Products;
set @diff = @maxPrice - @minPrice;

declare @lastDate date;
select @lastDate = max(createdAt) from Orders;
if DATEDIFF(day, @lastDate, GETDATE()) > 10
	begin
		print 'There were orders last 10 days'
	end;
else
	begin
		print 'There were not orders las 10 days';
	end;

declare @number int,
	@factorial int;
set @factorial = 1;
set @number = 5;

while @number > 0
	begin
		set @factorial = @factorial * @number;
		set @number = @number - 1;
	end;
print @factorial;

CREATE TABLE Accounts (FirstName NVARCHAR NOT NULL, Age INT NOT NULL)
 
BEGIN TRY
	INSERT INTO Accounts VALUES(NULL, NULL)
	PRINT 'Данные успешно добавлены!'
END TRY
BEGIN CATCH
	PRINT 'Error ' + CONVERT(VARCHAR, ERROR_NUMBER()) + ':' + ERROR_MESSAGE()
END CATCH;