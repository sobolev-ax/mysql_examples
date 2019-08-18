use productsdb;

drop table if exists Products;

CREATE TABLE Products
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL NOT NULL
);

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES ('iPhone X', 'Apple', 2, 76000),
('iPhone 8', 'Apple', 2, 51000),
('iPhone 7', 'Apple', 5, 42000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 46000),
('Honor 10', 'Huawei', 2, 26000),
('Nokia 8', 'HMD Global', 6, 38000);

select ProductName, ProductCount,
case
	when ProductCount = 1
		then 'Товар заканчивается'
	when ProductCount = 2
		then 'Мало товара'
	when ProductCount = 3
		then 'Есть в наличии'
	else 'Много товара'
end as Category
from Products;

select ProductName, Manufacturer,
	if(ProductCount > 3, 'Много товара', 'Мало товара') as Message
from Products;

drop table if exists Clients;
CREATE TABLE Clients
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Phone VARCHAR(20) NULL,
    Email VARCHAR(20) NULL
);

insert into Clients (FirstName, LastName, Phone, Email)
values ('Tom', 'Smith', '+36436734', NULL),
('Bob', 'Simpson', NULL, NULL);

select FirstName, LastName,
	ifnull(Phone, 'не определено') as Phone,
    ifnull(Email, 'неизвестно') as Email
from Clients;

select FirstName, LastName,
	coalesce(Phone, Email, 'не определено') as Contacts
from Clients;



