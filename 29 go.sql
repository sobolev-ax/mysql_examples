CREATE DATABASE internetstore;
GO
 
USE internetstore;
 
CREATE TABLE Customers
(
    Id INT PRIMARY KEY IDENTITY,
    Age INT DEFAULT 18, 
    FirstName NVARCHAR(20) NOT NULL,
    LastName NVARCHAR(20) NOT NULL,
    Email VARCHAR(30) UNIQUE,
    Phone VARCHAR(20) UNIQUE
);
 
CREATE TABLE Orders
(
    Id INT PRIMARY KEY IDENTITY,
    CustomerId INT,
    CreatedAt DATE,
    FOREIGN KEY (CustomerId) REFERENCES Customers (Id) ON DELETE CASCADE
);