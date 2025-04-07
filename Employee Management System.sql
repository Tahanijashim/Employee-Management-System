
DROP DATABASE employee_management;
Create Database Employee_management;
use Employee_management;
CREATE DATABASE employee_management;
USE employee_management;

CREATE TABLE employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100),
  phone_number VARCHAR(20),
  hire_date DATE,
  job_title VARCHAR(50),
  department_id INT
);


CREATE TABLE departments (
  department_id INT AUTO_INCREMENT PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL,
  manager_id INT,
  FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    basic_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    total_salary DECIMAL(10,2)
);

CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE NULL,
    status ENUM('Ongoing', 'Completed', 'On Hold')
);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    assigned_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    PRIMARY KEY (employee_id, project_id)
);

CREATE TABLE leaves (
    leave_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    leave_type ENUM('Sick', 'Casual', 'Paid', 'Unpaid'),
    start_date DATE,
    end_date DATE,
    status ENUM('Pending', 'Approved', 'Rejected'),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);



INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_title, department_id) 
VALUES 
   ('John', 'Doe', 'john.doe@example.com', '123-456-7890', '2024-01-15', 'Software Engineer', 1),
   ('Johny', 'Doe', 'johny.doe@example.com', '123-456-7891', '2024-01-18', 'Engineer', 2);

Select *from Employees

-- Drop existing tables if they exist
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;

-- Create employees table
CREATE TABLE employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100),
  phone_number VARCHAR(20),
  hire_date DATE,
  job_title VARCHAR(50),
  department_id INT
);

-- Insert sample employees
INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_title, department_id)
VALUES 
  ('John', 'Doe', 'john.doe@example.com', '123-456-7890', '2024-01-15', 'Software Engineer', 1),
  ('Johny', 'Doe', 'johny.doe@example.com', '123-456-7891', '2024-01-18', 'Engineer', 2);

-- Now create departments table with foreign key to employees
CREATE TABLE departments (
  department_id INT AUTO_INCREMENT PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL,
  manager_id INT,
  FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- Insert sample departments
INSERT INTO departments (department_name, manager_id)
VALUES 
  ('Engineering', 1),
  ('IT Support', 2);

-- View departments with manager names
SELECT 
  d.department_id,
  d.department_name,
  e.first_name AS manager_first_name,
  e.last_name AS manager_last_name
FROM 
  departments d
LEFT JOIN 
  employees e ON d.manager_id = e.employee_id;

  

-- Drop salary table if it already exists
DROP TABLE IF EXISTS salaries;

-- Create salaries table
CREATE TABLE salaries (
  salary_id INT AUTO_INCREMENT PRIMARY KEY,
  employee_id INT NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  pay_date DATE NOT NULL,
  bonus DECIMAL(10, 2),
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Insert sample salary records
INSERT INTO salaries (employee_id, amount, pay_date, bonus)
VALUES 
  (1, 5000.00, '2024-03-31', 500.00),
  (1, 5000.00, '2024-04-30', 250.00);

-- View all salary records with employee names
SELECT 
  s.salary_id,
  e.first_name,
  e.last_name,
  s.amount,
  s.bonus,
  s.pay_date
FROM 
  salaries s
JOIN 
  employees e ON s.employee_id = e.employee_id;




INSERT INTO projects (project_name, start_date, end_date, status)
VALUES 
  ('E-commerce Platform', '2024-01-10', NULL, 'Ongoing'),
  ('HR Software Migration', '2023-11-01', '2024-02-28', 'Completed');
  
  -- Assign employee 1 to project 2
INSERT INTO employee_projects (employee_id, project_id, assigned_date)
VALUES (1, 2, '2024-03-01');

-- Request leave for employee 1
INSERT INTO leaves (employee_id, leave_type, start_date, end_date, status)
VALUES (1, 'Sick', '2024-04-01', '2024-04-03', 'Pending');


INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_title, department_id)
VALUES ('John', 'Doe', 'john.doe@example.com', '123-456-7890', '2024-01-15', 'Software Engineer', 1);

UPDATE employees
SET job_title = 'Senior Software Engineer'
WHERE employee_id = 1;

DELETE FROM employees
WHERE employee_id = 1;

SELECT * FROM employees
WHERE department_id = 1;

SELECT * FROM employees
WHERE job_title = 'Software Engineer';

SELECT e.*
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
WHERE ep.project_id = 1;

SELECT d.department_name, e.first_name AS manager_first_name, e.last_name AS manager_last_name
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id;

SELECT e.*
FROM employees e
WHERE e.department_id = 1;

INSERT INTO salaries (employee_id, basic_salary, bonus, total_salary)
VALUES (1, 60000.00, 5000.00, 65000.00);

UPDATE salaries
SET basic_salary = 65000.00, bonus = 6000.00, total_salary = 71000.00
WHERE employee_id = 1;

SELECT e.first_name, e.last_name, s.total_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id;

INSERT INTO employee_projects (employee_id, project_id, assigned_date)
VALUES (1, 1, '2024-02-01');

SELECT project_name, start_date, end_date, status
FROM projects;

SELECT *
FROM projects
WHERE status = 'Completed';

INSERT INTO leaves (employee_id, leave_type, start_date, end_date, status)
VALUES (1, 'Sick', '2024-03-05', '2024-03-07', 'Pending');

SELECT *
FROM leaves
WHERE employee_id = 1;

SELECT e.first_name, e.last_name, l.leave_type, l.start_date, l.end_date, l.status
FROM employees e
JOIN leaves l ON e.employee_id = l.employee_id;

SELECT e.first_name, e.last_name, d.department_name, s.total_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id;

SELECT e.first_name, e.last_name
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
WHERE ep.project_id = 1;  -- Replace 1 with the actual project_id

SELECT SUM(s.total_salary) AS total_salary_expense
FROM salaries s
JOIN employees e ON s.employee_id = e.employee_id
WHERE MONTH(e.hire_date) = 1 AND YEAR(e.hire_date) = 2024;  -- Replace with the desired month and year

SELECT SUM(s.total_salary) AS total_salary_expense
FROM salaries s
JOIN employees e ON s.employee_id = e.employee_id
WHERE MONTH(e.hire_date) = 1 AND YEAR(e.hire_date) = 2024;  -- Replace with the desired month and year

SELECT e.first_name, e.last_name
FROM employees e
JOIN leaves l ON e.employee_id = l.employee_id
WHERE l.status = 'Pending';

SELECT d.department_name, COUNT(e.employee_id) AS number_of_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

