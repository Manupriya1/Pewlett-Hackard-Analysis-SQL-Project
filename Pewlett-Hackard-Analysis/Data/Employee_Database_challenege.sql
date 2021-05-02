Drop TABLE titles CASCADE;
CREATE TABLE titles(
	emp_no INT NOT NULL,
    title VARCHAR(20) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (emp_no) REFERENCES salaries (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);
SELECT * FROM titles;


Drop TABLE retirement_title CASCADE;
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ts.title,
	ts.from_date,
	ts.to_date
INTO retirement_title
FROM employees as e
INNER JOIN titles as ts
on (e.emp_no = ts.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31');
SELECT * FROM retirement_title

-- Use Dictinct with Orderby to remove duplicate rows
Drop TABLE unique_title CASCADE;
SELECT DISTINCT ON (emp_no)
emp_no, 
first_name, 
last_name, 
title
INTO unique_title
FROM retirement_title
ORDER BY emp_no Asc;
select * from unique_title

-- Creating Retiring titles table
Drop table retiring_table cascade
SELECT COUNT(unique_title.emp_no), unique_title.title
INTO retiring_table
FROM unique_title 
GROUP BY unique_title.title
ORDER BY unique_title.count DESC;
SELECT * FROM retiring_table

-- Mentorship eligibility table
SELECT DISTINCT ON (emp_no)
 e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ts.title
INTO membership_eligibility
FROM employees as e
INNER JOIN dept_emp as de
on (e.emp_no = de.emp_no)
INNER JOIN titles as ts
ON (e.emp_no = ts.emp_no)
WHERE (e.birth_date BETWEEN'1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;

SELECT * FROM membership_eligibility








	