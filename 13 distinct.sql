use productsdb;
drop table if exists Products;

create table Products
(
	Id int auto_increment primary key,
    ProductName varchar(30) not null,
    Manufacturer varchar(20) not null,
    ProductCount int default 0,
    Price decimal not null
);

insert into Products (ProductName, Manufacturer, ProductCount, Price)
values
('iPhone X', 'Apple', 3, 71000),
('iPhone 8', 'Apple', 3, 56000),
('Galaxy S9', 'Samsung', 6, 56000),
('Galaxy S8', 'Samsung', 2, 46000),
('Honor 10', 'Huawei', 3, 26000);

select distinct Manufacturer from Products;
