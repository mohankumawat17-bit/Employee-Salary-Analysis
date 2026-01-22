
-- Employee Salary Analysis Project
-- Database: practice_db

-- Use database
USE practice_db;

-- View employees table
SELECT * FROM employees;

-- Basic select
SELECT id, name, department, salary FROM employees;

-- Aggregations
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

-- CASE WHEN: Salary band
SELECT 
    id,
    name,
    department,
    salary,
    CASE
        WHEN salary >= 45000 THEN 'High'
        WHEN salary >= 35000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_band
FROM employees;

-- HAVING: Filter aggregated data
SELECT 
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 40000;

-- Subquery: Salary above average
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- Departments table
CREATE TABLE IF NOT EXISTS departments (
    dept_id INT,
    department VARCHAR(20)
);

INSERT INTO departments (dept_id, department) VALUES
(1, 'IT'),
(2, 'HR');

-- Add dept_id to employees
ALTER TABLE employees ADD COLUMN dept_id INT;

UPDATE employees SET dept_id = 1 WHERE department = 'IT';
UPDATE employees SET dept_id = 2 WHERE department = 'HR';

-- INNER JOIN
SELECT 
    e.id,
    e.name,
    d.department,
    e.salary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;

-- JOIN + GROUP BY (Final Summary)
SELECT 
    d.department,
    COUNT(e.id) AS employee_count,
    SUM(e.salary) AS total_salary,
    AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.department;
