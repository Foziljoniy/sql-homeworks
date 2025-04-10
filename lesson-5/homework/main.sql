DROP TABLE IF EXISTS Employees;


CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

SELECT * from Employees
--task1
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary, 
    RANK() OVER (ORDER BY Salary DESC) AS Rank
FROM Employees;

--task2
WITH EmployeeRanked AS (
    SELECT 
         EmployeeID, 
        Name, 
        Department, 
        Salary, 
        RANK() OVER (ORDER BY Salary DESC) AS Rank
    FROM Employees
)
SELECT 
     EmployeeID, 
    Name, 
    Department, 
    Salary, 
    Rank
FROM EmployeeRanked
WHERE Rank IN (
    SELECT Rank
    FROM EmployeeRanked
    GROUP BY Rank
    HAVING COUNT(*) > 1
)
ORDER BY Rank;

--task3	
WITH DepartmentSalaryRanked AS (
    SELECT 
        EmployeeID, 
        Name, 
        Department, 
        Salary, 
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Rank
    FROM Employees
)
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary
FROM DepartmentSalaryRanked
WHERE Rank <= 2
ORDER BY Department, Rank;

--task4
WITH DepartmentSalaryRanked AS (
    SELECT 
        EmployeeID, 
        Name, 
        Department, 
        Salary, 
        RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS Rank
    FROM Employees
)
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary
FROM DepartmentSalaryRanked
WHERE Rank = 1
ORDER BY Department;

--task5

SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Employees
ORDER BY Department, HireDate;
--task6
SELECT 
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalSalary
FROM Employees;
--7
SELECT 
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgSalary
FROM Employees;
--8
SELECT 
    Department,
    Name,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgSalary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS SalaryDifference
FROM Employees;
--9
SELECT 
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Last3Salaries
FROM Employees;
--10
SELECT 
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Last3Salaries
FROM Employees;
--11
SELECT 
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningAvgSalary
FROM Employees;
--12
SELECT 
    Name,
    Department,
    Salary,
    MAX(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MaxSalaryInWindow
FROM Employees;
--13
SELECT 
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalDeptSalary,
    (Salary * 100.0 / SUM(Salary) OVER (PARTITION BY Department)) AS SalaryPercentage
FROM Employees;





