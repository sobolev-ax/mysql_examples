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


select avg(Price) as AveragePrice from Products;
select avg(Price) as AveragePrice from Products
where Manufacturer = 'Apple';

select count(*) from Products;
select count(Manufacturer) from Products;

select min(Price) from Products;
select max(Price) from Products;

select sum(ProductCount) from Products;

select count(distinct Manufacturer) from Products;

select Manufacturer, count(*) as ModelsCount, sum(ProductCount) as ProductsCount
from Products
group by Manufacturer;

select Manufacturer, ProductCount, Count(*) as ModelsCount
from Products
group by Manufacturer, ProductCount;

select Manufacturer, count(*) as ModelsCount
from Products
group by Manufacturer
having count(*) > 1;

select Manufacturer, count(*) as Models, sum(ProductCount) as Units
from Products
where Price * ProductCount > 80000
group by Manufacturer
having sum(ProductCount) > 2
Order by Units desc;

select Manufacturer, count(*) as Models, Sum(ProductCount) as Units
from Products
group by Manufacturer with rollup;

select Manufacturer, count(*) as Models, Sum(ProductCount) as Units
from Products
group by Manufacturer, ProductCount with rollup;

select Manufacturer, count(*) as Models, sum(ProductCount) as Units
from Products
group by Manufacturer, ProductCount with cube;

select Manufacturer, count(*) as Models, sum(ProductCount) as Units
from Products
group by grouping sets(Manufacturer, ProductCount);

select ProductName, Manufacturer, ProductCount,
	count(*) over (partition by Manufacturer) as Models,
	sum(ProductCount) over (partition by Manufacturer) as Units
from Products;