-- Data Analysis
-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
LEFT JOIN salaries s
	ON e.emp_no = s.emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE e.hire_date >= '1986-01-01' AND e.hire_date <= '1986-12-31';

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
WITH dm_cte AS(
	SELECT dm.emp_no, dm.dept_no, d.dept_name
	FROM dept_manager dm
	LEFT JOIN departments d
		ON dm.dept_no = d.dept_no
)
SELECT dm_cte.dept_no, dm_cte.dept_name, dm_cte.emp_no, e.last_name, e.first_name
FROM dm_cte
LEFT JOIN employees e
	ON dm_cte.emp_no = e.emp_no;

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
WITH de_cte AS(
	SELECT de.emp_no, de.dept_no, d.dept_name
	FROM dept_emp de
	JOIN departments as d
		ON de.dept_no = d.dept_no
)
SELECT de_cte.emp_no, e.last_name, e.first_name, de_cte.dept_name
FROM employees e
LEFT JOIN de_cte
	ON e.emp_no = de_cte.emp_no;

-- List first name, last name, and sex for employees whose first name is "Hercules" 
-- and last names begin with "B."
SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE e.first_name = 'Hercules'
	AND e.last_name ilike 'B%';

-- List all employees in the Sales department, including their 
-- employee number, last name, first name, and department name.
WITH de_cte AS(
	SELECT de.emp_no, de.dept_no, d.dept_name
	FROM dept_emp de
	LEFT JOIN departments as d
		ON de.dept_no = d.dept_no
)
SELECT de_cte.emp_no, e.last_name, e.first_name, de_cte.dept_name
FROM de_cte
LEFT JOIN employees e
	ON de_cte.emp_no = e.emp_no
WHERE de_cte.dept_name = 'Sales';


-- In descending order, list the frequency count of employee last names, i.e., 
-- how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC;
