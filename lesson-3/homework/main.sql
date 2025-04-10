CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

Select * from Employees


INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(1, 'Alice', 'Smith', 'Engineering', 95000.00, '2019-03-15'),
(2, 'Bob', 'Johnson', 'HR', 48000.00, '2020-06-22'),
(3, 'Charlie', 'Lee', 'Engineering', 87000.00, '2018-11-05'),
(4, 'Diana', 'Khan', 'Marketing', 52000.00, '2021-01-10'),
(5, 'Ethan', 'Brown', 'Finance', 65000.00, '2022-02-18'),
(6, 'Fiona', 'White', 'Engineering', 75000.00, '2020-09-25'),
(7, 'George', 'Davis', 'Finance', 83000.00, '2017-07-30'),
(8, 'Hannah', 'Wilson', 'HR', 42000.00, '2019-05-19'),
(9, 'Ian', 'Clark', 'Marketing', 88000.00, '2016-12-01'),
(10, 'Julia', 'Miller', 'Finance', 47000.00, '2023-03-10'),
(11, 'Kevin', 'Lopez', 'Engineering', 91000.00, '2018-04-17'),
(12, 'Lara', 'Martin', 'Marketing', 77000.00, '2020-10-08'),
(13, 'Mike', 'Garcia', 'HR', 51000.00, '2021-11-20'),
(14, 'Nora', 'Walker', 'Finance', 59000.00, '2022-07-04'),
(15, 'Oscar', 'Hall', 'Engineering', 99000.00, '2015-01-01');



WITH Top10Percent AS (
    SELECT *,
           PERCENT_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
),
Categorized AS (
    SELECT Department,
           Salary,
           CASE
               WHEN Salary > 80000 THEN 'High'
               WHEN Salary BETWEEN 50000 AND 80000 THEN 'Medium'
               ELSE 'Low'
           END AS SalaryCategory
    FROM Top10Percent
    WHERE SalaryRank <= 0.10
),
DepartmentAvg AS (
    SELECT Department,
           SalaryCategory,
           AVG(Salary) AS AverageSalary
    FROM Categorized
    GROUP BY Department, SalaryCategory
)
SELECT *
FROM DepartmentAvg
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;
--task2

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status)
VALUES
(1, 'Alice', '2023-01-15', 1200.00, 'Shipped'),
(2, 'Bob', '2023-02-10', 4500.00, 'Pending'),
(3, 'Charlie', '2023-03-05', 3200.00, 'Delivered'),
(4, 'Diana', '2023-04-20', 1000.00, 'Cancelled'),
(5, 'Ethan', '2023-06-15', 800.00, 'Shipped'),
(6, 'Fiona', '2023-07-01', 1500.00, 'Delivered'),
(7, 'George', '2023-08-25', 2000.00, 'Pending'),
(8, 'Hannah', '2022-12-12', 1800.00, 'Delivered'),
(9, 'Ian', '2023-10-30', 3000.00, 'Cancelled'),
(10, 'Julia', '2023-11-15', 4000.00, 'Shipped');

Select * from Orders

SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31';


SELECT *,
    CASE
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31';

WITH OrderSummary AS (
    SELECT
        CASE
            WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
            WHEN Status = 'Pending' THEN 'Pending'
            WHEN Status = 'Cancelled' THEN 'Cancelled'
        END AS OrderStatus,
        TotalAmount
    FROM Orders
    WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
)
SELECT
    OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM OrderSummary
GROUP BY OrderStatus
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;


INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES
(1, 'Laptop Pro', 'Electronics', 1200.00, 5),
(2, 'Mouse', 'Electronics', 25.00, 20),
(3, 'Coffee Mug', 'Kitchen', 15.00, 0),
(4, 'Blender', 'Kitchen', 60.00, 3),
(5, 'Desk Chair', 'Furniture', 150.00, 0),
(6, 'Monitor', 'Electronics', 300.00, 8),
(7, 'Bookshelf', 'Furniture', 180.00, 15),
(8, 'Spoon Set', 'Kitchen', 30.00, 1),
(9, 'Smartphone', 'Electronics', 999.00, 2),
(10, 'Dining Table', 'Furniture', 800.00, 0);

Select * from Products

SELECT DISTINCT Category
FROM Products;


SELECT *
FROM Products p
WHERE Price = (
    SELECT MAX(Price)
    FROM Products
    WHERE Category = p.Category
);

SELECT *,
    IIF(Stock = 0, 'Out of Stock',
        IIF(Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM Products p
WHERE Price = (
    SELECT MAX(Price)
    FROM Products
    WHERE Category = p.Category
)

ORDER BY Price DESC
OFFSET 5 ROWS;



