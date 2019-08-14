create database if not exists productsdb;
use productsdb;

create table Products
(
	Id int auto_increment primary key,
    ProductName varchar(30) not null,
    Manufacturer varchar(20) not null,
    ProductCount int default 0,
    Price decimal not null
);

insert Products(ProductName, Manufacturer, Price, ProductCount)
Values
('iPhone 8', 'Apple', 51000, 3),
('Galaxy S8', 'Samsung', 46000, 2);
