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

select Manufacturer, count(*) as ModelsCount
from Products
group by Manufacturer;

select ProductCount, count(*) as ModelsCount
from Products
group by ProductCount;

select Manufacturer, ProductCount, count(*) as ModelsCount
from Products
group by Manufacturer, ProductCount;

select Manufacturer, count(*) as ModelsCount
from Products
where Price > 30000
group by Manufacturer
order by ModelsCount desc;

select Manufacturer, count(*) as ModelsCount
from Products
group by Manufacturer
having count(*) > 1;

select Manufacturer, count(*) as ModelsCount
from Products
where Price * ProductCount > 80000
group by Manufacturer
having count(*) > 1;

select Manufacturer, count(*) as Models, sum(ProductCount) as Units
from Products
where Price * ProductCount > 80000
group by Manufacturer
having sum(ProductCount) > 2
order by Units desc;


