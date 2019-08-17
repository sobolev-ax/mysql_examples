use productsdb;

drop table if exists Orders;
drop table if exists Employees;
drop table if exists Customers;

CREATE TABLE Customers
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    AccountSum DECIMAL
);
CREATE TABLE Employees
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL
);
  
INSERT INTO Customers(FirstName, LastName, AccountSum) 
VALUES
('Tom', 'Smith', 2000),
('Sam', 'Brown', 3000),
('Mark', 'Adams', 2500),
('Paul', 'Ins', 4200),
('John', 'Smith', 2800),
('Tim', 'Cook', 2800);
  
INSERT INTO Employees(FirstName, LastName)
VALUES
('Homer', 'Simpson'),
('Tom', 'Smith'),
('Mark', 'Adams'),
('Nick', 'Svensson');

select FirstName, LastName
from Customers
union select FirstName, LastName from Employees;

select FirstName, LastName
from Customers
union all select FirstName, LastName from Employees
order by FirstName;

select FirstName, LastName, AccountSum + AccountSum * 0.1 as TotalSum
from Customers where AccountSum < 3000
union select FirstName, LastName, AccountSum + AccountSum * 0.3 as TotalSum
from Customers where AccountSum > 3000;

