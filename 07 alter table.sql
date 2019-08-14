use usersdb;

# alter table users
# add Address varchar(50) null;

# alter table users
# drop column Address;

CREATE TABLE Customers
(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Age INT, 
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL
);
CREATE TABLE Orders
(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT,
    CreatedAt Date
);

alter table Orders
add constraint orders_customers_fk
foreign key(CustomerId) references Customers(id);

create table Products
(
	Id int,
    Model varchar(20)
);

alter table Products
add primary key (Id);


