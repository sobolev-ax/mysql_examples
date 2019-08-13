drop table if exists Orders;
drop table if exists Customers;

create table Customers
(
	Id int primary key auto_increment,
    Age int,
    FirstName varchar(20) not null,
    LastName varchar(20) not null,
    Phone varchar(20) not null unique
);

create table Orders
(
	id int primary key auto_increment,
    CustomerId int,
    CreateAt date,
    constraint orders_cstomers_fk
    foreign key (CustomerId) references Customers(Id) on delete cascade
);
