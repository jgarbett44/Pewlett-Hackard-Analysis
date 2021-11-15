SELECT emp_no, first_name, last_name, birth_date
INTO emp_info
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT * FROM emp_info

SELECT emp_no, title, from_date, to_date
INTO title_info
FROM titles

SELECT * FROM title_info

SELECT emp_info.emp_no,
	emp_info.first_name,
  	emp_info.last_name, 
	title_info.title,
	title_info.from_date,
  	title_info.to_date
INTO retirement_titles	
FROM emp_info
LEFT JOIN title_info
ON title_info.emp_no = emp_info.emp_no
ORDER BY emp_info.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
DROP TABLE if exists unique_titles;
SELECT DISTINCT ON (emp_no) emp_no, 
first_name, 
last_name, 
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

-- Retiring Titles
SELECT COUNT(*), title
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.title
ORDER BY count DESC;    


--Deliverable 2

--Join Employees and Department Employees on primary key
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
	employees.first_name,
  	employees.last_name,
	employees.birth_date,
	dept_emp.from_date,
	dept_emp.to_date
INTO employee_department
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no;

SELECT * FROM employee_department;

--Join Employees and Titles on primary key
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
	employees.first_name,
  	employees.last_name,
	employees.birth_date,
	titles.title
INTO employee_title
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no;

SELECT * FROM employee_title;

-- Joining employee_department and employee_title tables
SELECT employee_department.emp_no,
	employee_department.first_name,
    employee_department.last_name,
	employee_department.birth_date,
	employee_department.from_date,
    employee_department.to_date,
	employee_title.title
INTO mentorship
FROM employee_department
INNER JOIN employee_title
ON employee_department.emp_no = employee_title.emp_no;

SELECT emp_no, first_name, last_name, birth_date, from_date, to_date, title
INTO mentorship_eligibility
FROM mentorship
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (to_date BETWEEN '9999-01-01' AND '9999-12-31')
ORDER BY emp_no ASC

SELECT * FROM mentorship_eligibility
