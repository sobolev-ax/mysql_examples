use productsdb;
drop table if exists Products;

create table Products
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL NOT NULL
);
   
INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price) 
VALUES
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('iPhone 7', 'Apple', 5, 32000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 46000),
('Honor 10', 'Huawei', 5, 28000),
('Nokia 8', 'HMD Global', 6, 38000);

select avg(Price) as AveragePrice from Products;

select avg(Price) as AveragePriceApple from Products
where Manufacturer = 'Apple';

select count(*) from Products;
select count(Manufacturer) from Products;

select min(Price), max(ProductCount) from Products;

select sum(ProductCount) from Products;
select sum(ProductCount * Price) from Products;

select count(distinct Manufacturer) from Products;
select count(all Manufacturer) from Products;

select count(*) as ProductCount,
       sum(ProductCount) as TotalCount,
       min(Price) as MinPrice,
       max(Price) as MaxPrice,
       avg(Price) as AveragePrice
from Products;
