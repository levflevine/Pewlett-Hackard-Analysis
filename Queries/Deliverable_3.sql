-- Deliverable 3 --

DROP TABLE IF EXISTS temp_dept;
SELECT DISTINCT ON (me.emp_no) me.emp_no, de.dept_no, d.dept_name
INTO temp_dept
FROM mentorship_eligibility AS me
LEFT JOIN dept_emp AS de
ON me.emp_no=de.emp_no
LEFT JOIN departments as d
ON d.dept_no = de.dept_no;

DROP TABLE IF EXISTS temp_sum;
SELECT count(dept_no) AS "# of Mentors", dept_no, dept_name
INTO temp_sum
FROM temp_dept
GROUP BY dept_no, dept_name;

DROP TABLE IF EXISTS temp_d;
SELECT DISTINCT ON (ut.emp_no) ut.emp_no, d.dept_no, d.dept_name
INTO temp_d
FROM unique_titles AS ut
LEFT JOIN dept_emp AS de
ON ut.emp_no=de.emp_no
LEFT JOIN departments as d
ON d.dept_no = de.dept_no;

DROP TABLE IF EXISTS temp_d_sum;
SELECT count(emp_no) AS "# of Retirement Employees", dept_no
INTO temp_d_sum
FROM temp_d
GROUP BY dept_no;

DROP TABLE IF EXISTS temp_fin;
SELECT ts.dept_no, ts.dept_name, ts."# of Mentors", tds."# of Retirement Employees"
INTO temp_fin
FROM temp_sum as ts
INNER JOIN temp_d_sum as tds
ON ts.dept_no = tds.dept_no;

SELECT * FROM temp_fin ORDER BY "# of Mentors" DESC;