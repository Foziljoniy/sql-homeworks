CREATE TABLE test_identity (
    id INT IDENTITY(1,1),
    name VARCHAR(50)
);

INSERT INTO test_identity (name)
VALUES ('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eve');

SELECT * FROM test_identity;

DELETE FROM test_identity;

-- Insert again
INSERT INTO test_identity (name)
VALUES ('Frank');

SELECT * FROM test_identity;

TRUNCATE TABLE test_identity;

-- Insert again
INSERT INTO test_identity (name)
VALUES ('George');

SELECT * FROM test_identity;

DROP TABLE test_identity;


--task 2

CREATE TABLE data_types_demo (
    id INT,
    name VARCHAR(50),
    is_active BIT,
    created_at DATETIME,
    salary DECIMAL(10,2),
    data XML,
    file_data VARBINARY(MAX)
);

INSERT INTO data_types_demo
VALUES (
    1,
    'Foziljon',
    1,
    GETDATE(),
    1500.50,
    '<info><tag>test</tag></info>',
    NULL
);

SELECT * FROM data_types_demo;
--task3
CREATE TABLE photos (
    id INT IDENTITY(1,1),
    image_data VARBINARY(MAX)
);

INSERT INTO photos (image_data)
SELECT * FROM OPENROWSET(BULK N'D:\ai-and-bi-talents-sql-main\lesson-2\images\apple.jpg', SINGLE_BLOB) AS img;

--task4
CREATE TABLE student (
    id INT,
    name VARCHAR(50),
    classes INT,
    tuition_per_class DECIMAL(10,2),
    total_tuition AS (classes * tuition_per_class)
);

INSERT INTO student (id, name, classes, tuition_per_class)
VALUES
(1, 'Ali', 5, 200.00),
(2, 'Malika', 3, 250.00),
(3, 'Xojiaka', 4, 180.00);

SELECT * FROM student;


--task4 
CREATE TABLE worker (
    id INT,
    name VARCHAR(50)
);
BULK INSERT worker
FROM 'D:\study\sql-homeworks\lesson-2\homework\workers.csv'
WITH (
  
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM worker;
