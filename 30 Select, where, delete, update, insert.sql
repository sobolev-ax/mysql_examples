USE [master];
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

INSERT INTO Products
VALUES
('iPhone 6', 'Apple', 3, 36000),
('iPhone 6S', 'Apple', 2, 41000),
('iPhone 7', 'Apple', 5, 52000),
('Galaxy S8', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000),
('Mi6', 'Xiaomi', 5, 28000),
('OnePlus 5', 'OnePlus', 6, 38000);

select ProductName + '(' + Manufacturer + ')' as ModelName,
Price, Price * ProductCount as TotalSum from Products;

select distinct Manufacturer from Products;

select
	 ProductName + '(' + Manufacturer + ')' as ModelName
	,Price
into ProductSummary
from Products;
select * from ProductSummary;

select * from Products
order by ProductName desc;

select
	 *
	,Price * ProductCount as TotalSum
from Products
order by Price * ProductCount;

select top 4 ProductName from Products;

select top 75 percent ProductName from Products;

select * from Products
order by Id
	offset 2 rows;

select * from Products
order by Id
	offset 2 rows
	fetch next 3 rows only;

select * from Products
where Manufacturer = 'Samsung';

select * from Products
where Price > 45000;

select * from Products
where Price * ProductCount > 200000;

select * from Products
where Manufacturer = 'Samsung' and Price > 50000;

select * from Products
where Manufacturer = 'Samsung' or Price > 50000;

SELECT * FROM Products
WHERE Manufacturer = 'Samsung' OR Price > 30000 AND ProductCount > 2;

select * from Products
where Manufacturer in ('Samsung', 'Xiaomi', 'Huawei');

select * from Products
where Price between 20000 and 40000;

select * from Products
where ProductName like 'iPhone [6-8]%';

update Products
set Price = Price + 999;
select * from Products;
update Products
set Price = Price - 999;

update Products
set Manufacturer = 'Samsung inc.'
where Manufacturer = 'Samsung';

select * from Products;

update Products
set Manufacturer = 'Apple inc.'
from
(Select top 2 * from Products where Manufacturer = 'Apple') as Selected
where Products.Id = Selected.Id;
select * from Products;

delete Products
where Manufacturer = 'Huawei';

DELETE Products FROM
(SELECT TOP 2 * FROM Products
WHERE Manufacturer='Apple]') AS Selected
WHERE Products.Id = Selected.Id
