use productsdb;

drop table if exists Products;

CREATE TABLE Products
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL NOT NULL,
    CreatedAt DATE default '2019-08-18'
);

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price, CreatedAt)
VALUES ('iPhone X', 'Apple', 2, 76000, '2018-05-21'),
('iPhone 8', 'Apple', 2, 51000, '2018-05-23'),
('iPhone 7', 'Apple', 5, 42000, '2018-05-21'),
('Galaxy S9', 'Samsung', 2, 56000, '2019-08-18'),
('Galaxy S8', 'Samsung', 1, 46000, '2019-08-18'),
('Honor 10', 'Huawei', 2, 26000, '2019-08-18'),
('Nokia 8', 'HMD Global', 6, 38000, '2019-08-18');

select DATE_ADD('2018-05-25', INTERVAL 1 DAY);
select DATE_FORMAT('2018-05-25', '%d/%m/%y');

select *,
datediff(curdate(), CreatedAt)
from Products;
