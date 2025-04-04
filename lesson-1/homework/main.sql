--1. NOT NULL Constraint
DROP TABLE if exists student; 
CREATE TABLE student (
    id INTEGER,
    name VARCHAR(100),
    age INTEGER
);

ALTER TABLE student
ALTER COLUMN id INT NOT NULL;


--2. UNIQUE Constraint
DROP TABLE if exists product; 
CREATE TABLE product (
    product_id INT UNIQUE,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

ALTER TABLE product
DROP CONSTRAINT [UQ__product__47027DF4E55B00F0];

ALTER TABLE product
ADD CONSTRAINT UQ__product__ID UNIQUE (product_id);

ALTER TABLE product
ADD CONSTRAINT UQ__product__BOTH UNIQUE (product_id, product_name);



--3. PRIMARY KEY Constraint
DROP TABLE if exists orders;
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE
);

ALTER TABLE orders
DROP CONSTRAINT [PK__orders__4659622929F678C4];

ALTER TABLE orders
ADD CONSTRAINT PK__orders_ID PRIMARY KEY (order_id);



--4. FOREIGN KEY Constraint
DROP TABLE if exists category;
CREATE TABLE category (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE item (
    item_id INTEGER PRIMARY KEY,
    item_name VARCHAR(100),
    category_id INTEGER,
    fk_category INT FOREIGN KEY REFERENCES category(category_id)
);

ALTER TABLE item
DROP CONSTRAINT FK__item__fk_categor__49E3F248;

ALTER TABLE item
ADD CONSTRAINT FK__item__fk_categor_ID FOREIGN KEY (category_id) REFERENCES category(category_id);

--5. CHECK Constraint
DROP TABLE if exists account;
CREATE TABLE account (
    account_id INTEGER PRIMARY KEY,
    balance DECIMAL(10, 2) CHECK (balance >= 0),
    account_type VARCHAR(20) CHECK (account_type IN ('Saving', 'Checking'))
);

ALTER TABLE account
DROP CONSTRAINT [CK__account__account__536D5C82];

ALTER TABLE account
ADD CONSTRAINT [CK__account__account] CHECK (balance >= 0);

ALTER TABLE account
DROP CONSTRAINT [CK__account__balance__52793849];

ALTER TABLE account
ADD CONSTRAINT [CK__account__balance] CHECK (account_type IN ('Saving', 'Checking'));


-- 6. DEFAULT Constraint
DROP TABLE if exists customer;
CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100) DEFAULT 'Unknown'
);

ALTER TABLE customer
DROP CONSTRAINT [DF__customer__city__5B0E7E4A];

ALTER TABLE customer
ADD CONSTRAINT [DF__customer__city] DEFAULT 'Unknown' FOR city;


--7. IDENTITY Column
DROP TABLE if exists invoice;
CREATE TABLE invoice (
    invoice_id int NOT NULL IDENTITY,
    amount DECIMAL(10, 2)
);

INSERT INTO invoice (amount) VALUES (100.50), (200.00), (150.75), (300.25), (80.00);

SET IDENTITY_INSERT invoice ON;
INSERT INTO invoice (invoice_id, amount) VALUES (100, 500.00);
SET IDENTITY_INSERT invoice OFF;

--8. All at once
DROP TABLE if exists books;
CREATE TABLE books (
    book_id INTEGER IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL CHECK (title <> ''),
    price DECIMAL(10, 2) CHECK (price > 0),
    genre VARCHAR(100) DEFAULT 'Unknown'
);

INSERT INTO books (title, price) VALUES ('1984', 9.99), ('Sapiens', 12.50);

-- Test constraint violations
-- INSERT INTO books (title, price) VALUES ('', 5.00); -- Fails (empty title)
-- INSERT INTO books (title, price) VALUES ('Test Book', 0); -- Fails (price <= 0)

--9. Scenario: Library Management System

CREATE TABLE Book (
    book_id INTEGER PRIMARY KEY IDENTITY,
    title TEXT,
    author TEXT,
    published_year INTEGER
);

CREATE TABLE Member (
    member_id INTEGER PRIMARY KEY IDENTITY,
    name TEXT,
    email TEXT,
    phone_number TEXT
);

CREATE TABLE Loan (
    loan_id INTEGER PRIMARY KEY IDENTITY,
    book_id INTEGER,
    member_id INTEGER,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

INSERT INTO Book (title, author, published_year) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 1925),
('To Kill a Mockingbird', 'Harper Lee', 1960),
('1984', 'George Orwell', 1949);

INSERT INTO Member (name, email, phone_number) VALUES
('Alice', 'alice@example.com', '123-456-7890'),
('Bob', 'bob@example.com', '987-654-3210');

INSERT INTO Loan (book_id, member_id, loan_date, return_date) VALUES
(1, 1, '2025-04-01', NULL),
(2, 1, '2025-04-02', '2025-04-03'),
(3, 2, '2025-04-03', NULL);