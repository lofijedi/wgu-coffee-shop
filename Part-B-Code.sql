-- Part 1

CREATE DATABASE jaunty_coffee_erd;

USE jaunty_coffee_erd;

CREATE TABLE supplier (
    supplier_id INT NOT NULL,
    company_name VARCHAR(50),
    country VARCHAR(30),
    sales_contact_name VARCHAR(60),
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (supplier_id)
);

CREATE TABLE coffee_shop (
    shop_id INT NOT NULL,
    shop_name VARCHAR(50),
    city VARCHAR(50),
    state CHAR(2),
    PRIMARY KEY (shop_id)
);

CREATE TABLE employee (
    employee_id INT NOT NULL,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    hire_date DATE,
    job_title VARCHAR(30),
    shop_id INT,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (shop_id) REFERENCES coffee_shop (shop_id)
);

CREATE TABLE coffee (
    coffee_id INT NOT NULL,
    shop_id INT,
    supplier_id INT,
    coffee_name VARCHAR(30),
    price_per_pound NUMERIC(5,2),
    PRIMARY KEY (coffee_id),
    FOREIGN KEY (shop_id) REFERENCES coffee_shop (shop_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id)
);

-- Part 2

INSERT INTO supplier (supplier_id, company_name, country, sales_contact_name, email)
    VALUES
        (150, "Davids Coffee Hut", "United States", "David", "david@thecoffeehut.com"),
        (323, "Coffee Barz", "Mexico", "Micheal", "supplier@coffeebarz.com"),
        (228, "Roasted and Toasted", "Canada", "Victoria", "victoria.williams@randt.com"
);


INSERT INTO coffee_shop (shop_id, shop_name, city, state)
    VALUES
        (987, "Java the Hutt", "Austin", "TX"),
        (111, "The Coffee Spot", "Boston", "MA"),
        (154, "Koffee World", "Buffalo", "NY");

INSERT INTO employee (employee_id, first_name, last_name, hire_date, job_title, shop_id)
    VALUES
        (91812, "Peter", "Parker", '2019-12-02', "Manager", 987),
        (33215, "Susan", "Storm", '2020-04-21', "Barista", 111),
        (99323, "Steven", "Rogers", '2020-11-10', "Shift Lead", 154);


INSERT INTO coffee (coffee_id, shop_id, supplier_id, coffee_name, price_per_pound)
    VALUES
        (123, 987, 150, "Medium Roast", 21.33),
        (765, 111, 323, "Decaf", 15.99),
        (882, 154, 228, "Pecan Roast", 13.99);

-- Part 3

CREATE VIEW employee_name AS
    SELECT *, CONCAT(first_name, " ", last_name) AS employee_full_name
    FROM employee;

SELECT * FROM employee_name;

-- Part 4

CREATE INDEX coffee_name ON coffee (coffee_name);

SHOW INDEX FROM coffee;

-- Part 5

SELECT city FROM coffee_shop WHERE state="TX" OR shop_name="Koffee World";

-- Part 6

SELECT coffee_shop.shop_name, employee.first_name, coffee.coffee_name
    FROM coffee_shop
    INNER JOIN employee
    ON coffee_shop.shop_id=employee.shop_id
    INNER JOIN coffee
    ON coffee_shop.shop_id=coffee.shop_id;