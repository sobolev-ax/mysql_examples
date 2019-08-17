use productsdb;

drop table if exists Orders;
drop table if exists Customers;
drop table if exists Products;

CREATE TABLE Products
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL NOT NULL
);
CREATE TABLE Customers
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL
);
CREATE TABLE Orders
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT NOT NULL,
    CustomerId INT NOT NULL,
    CreatedAt DATE NOT NULL,
    ProductCount INT DEFAULT 1,
    Price DECIMAL NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id) ON DELETE CASCADE
);

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES ('iPhone X', 'Apple', 2, 76000),
('iPhone 8', 'Apple', 2, 51000),
('iPhone 7', 'Apple', 5, 42000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 46000),
('Honor 10', 'Huawei', 2, 26000),
('Nokia 8', 'HMD Global', 6, 38000);
 
INSERT INTO Customers(FirstName) VALUES ('Tom'), ('Bob'),('Sam');
 
INSERT INTO Orders (ProductId, CustomerId, CreatedAt, ProductCount, Price)
VALUES
( 
    (SELECT Id FROM Products WHERE ProductName='Galaxy S8'),
    (SELECT Id FROM Customers WHERE FirstName='Tom'),
    '2018-05-21', 
    2, 
    (SELECT Price FROM Products WHERE ProductName='Galaxy S8')
),
( 
    (SELECT Id FROM Products WHERE ProductName='iPhone X'),
    (SELECT Id FROM Customers WHERE FirstName='Tom'),
    '2018-05-23',  
    1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone X')
),
( 
    (SELECT Id FROM Products WHERE ProductName='iPhone X'),
    (SELECT Id FROM Customers WHERE FirstName='Bob'),
    '2018-05-21',  
    1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone X')
);

select FirstName, CreatedAt, ProductCount, Price, ProductId
from Orders left join Customers
on Orders.CustomerId = Customers.Id;

select FirstName, CreatedAt, ProductCount, Price
from Customers join Orders
on Orders.CustomerId = Customers.Id;

select firstName, CreatedAt, ProductCount, Price
from Customers left join Orders
on Orders.CustomerId = Customers.Id;

select Customers.FirstName, Orders.CreatedAt,
	Products.ProductName, Products.Manufacturer
from Orders
left join Customers on Orders.CustomerId = Customers.Id
left join Products on Orders.ProductId = Products.Id;

select FirstName from Customers
left join Orders on Customers.Id = Orders.CustomerId
where Orders.CustomerId is null;

select Customers.FirstName, Orders.CreatedAt,
	Products.ProductName, Products.Manufacturer
from Orders
join Products on Orders.ProductId = Products.Id and Products.Price > 45000
left join Customers on Orders.CustomerId = Customers.Id
order by Orders.CreatedAt;
