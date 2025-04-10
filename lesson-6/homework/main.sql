DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)  -- Ensures that DepartmentID exists in Departments table
);
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)  -- Ensures that EmployeeID exists in Employees table
);

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES 
    (101, 'IT'),
    (102, 'HR'),
    (103, 'Finance'),
    (104, 'Marketing');

INSERT INTO Employees (Name, DepartmentID, Salary)
VALUES 
    ('Alice', 101, 60000),
    ('Bob', 102, 70000),
    ('Charlie', 101, 65000),
    ('David', 103, 72000),
    ('Eva', NULL, 68000);  -- Eva is not assigned to any department, hence NULL for DepartmentID

INSERT INTO Projects (ProjectID, ProjectName, EmployeeID)
VALUES 
    (1, 'Alpha', 1),  -- Alice is assigned to project Alpha
    (2, 'Beta', 2),   -- Bob is assigned to project Beta
    (3, 'Gamma', 1),  -- Alice is assigned to project Gamma
    (4, 'Delta', 4),  -- David is assigned to project Delta
    (5, 'Omega', NULL);  -- No employee assigned to project Omega


--1
SELECT 
    E.EmployeeID, 
    E.Name, 
    D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

--2
SELECT 
    E.EmployeeID, 
    E.Name, 
    D.DepartmentName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;
--3
SELECT 
    D.DepartmentID, 
    D.DepartmentName, 
    E.Name AS EmployeeName
FROM Departments D
RIGHT JOIN Employees E ON D.DepartmentID = E.DepartmentID;
--4
SELECT 
    E.EmployeeID, 
    E.Name AS EmployeeName, 
    D.DepartmentName
FROM Employees E
FULL OUTER JOIN Departments D ON E.DepartmentID = D.DepartmentID;
--5
SELECT 
    D.DepartmentName,
    SUM(E.Salary) AS TotalSalaryExpense
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName;
--6
SELECT 
    D.DepartmentName, 
    P.ProjectName
FROM Departments D
CROSS JOIN Projects P;
--7
SELECT 
    E.EmployeeID, 
    E.Name AS EmployeeName, 
    D.DepartmentName, 
    P.ProjectName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID
LEFT JOIN Projects P ON E.EmployeeID = P.EmployeeID;

