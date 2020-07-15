CREATE DATABASE delivery;

USE delivery;

CREATE TABLE products (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    price FLOAT(6)
);

INSERT INTO products (name, price)
    VALUES ('Heineken 600ml', 4.53);

INSERT INTO products (name, price)
    VALUES ('Brahma 600ml', 3.20);

INSERT INTO products (name, price)
    VALUES ('Budwiser 600ml', 5.30);

INSERT INTO products (name, price)
    VALUES ('Colorado Ribeirao 600ml', 4.50);

INSERT INTO products (name, price)
    VALUES ('Heineken 355ml', 3.00);

INSERT INTO products (name, price)
    VALUES ('Heineken Barril Chopp', 40.00);