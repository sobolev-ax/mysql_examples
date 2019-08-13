CREATE DATABASE usersdb;
USE usersdb;
CREATE TABLE users (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(30),
    age INTEGER
);
INSERT INTO users (firstname, age) VALUES ('Tom', 34);