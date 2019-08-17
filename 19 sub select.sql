use productsdb;

drop table if exists Orders;
drop table if exists Products;

CREATE TABLE Products
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL NOT NULL
);
CREATE TABLE Orders
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT NOT NULL,
    ProductCount INT DEFAULT 1,
    CreatedAt DATE NOT NULL,
    Price DECIMAL NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE
);

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES ('iPhone X', 'Apple', 2, 76000),
('iPhone 8', 'Apple', 2, 51000),
('iPhone 7', 'Apple', 5, 42000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 46000),
('Honor 10', 'Huawei', 2, 26000),
('Nokia 8', 'HMD Global', 6, 38000);

insert into Orders (ProductId, CreatedAt, ProductCount, Price)
values
(
    (SELECT Id FROM Products WHERE ProductName='Galaxy S8'),
    '2018-05-21', 
    2, 
    (SELECT Price FROM Products WHERE ProductName='Galaxy S8')
),
( 
    (SELECT Id FROM Products WHERE ProductName='iPhone X'),
    '2018-05-23',  
    1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone X')
),
( 
    (SELECT Id FROM Products WHERE ProductName='iPhone 8'),
    '2018-05-21',  
    1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone 8')
);

select * from Products
where price = (select min(price) from Products);

select * from Products
where price > (select avg(Price) from Products);

select CreatedAt, Price,
	(select ProductName from Products
    where Products.Id = Orders.ProductId) as Product
from Orders;

select ProductName,
		Manufacturer,
        Price,
        (select avg(price) from Products as SubProds
        where SubProds.Manufacturer=Prods.Manufacturer) as AvgPrice
from Products as Prods
where Price >
	(select avg(Price) from Products as SubProds
    where SubProds.Manufacturer=Prods.Manufacturer);

