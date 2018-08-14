---------------------------------------------------------------------------
-- geodata --
---------------------------------------------------------------------------
use geodata;

SELECT _countries.title as country, _regions.title as region, _cities.title as city FROM _cities 
	INNER JOIN _countries on _cities.country_id = _countries.id
    INNER JOIN _regions on _cities.region_id = _regions.id;

SELECT _countries.title as country, _regions.title as region, _cities.title as city FROM _cities 
	INNER JOIN _countries on _cities.country_id = _countries.id
    INNER JOIN _regions on _cities.region_id = _regions.id
    WHERE _regions.title = 'Московская область';
	
	
	
---------------------------------------------------------------------------
-- employees --
---------------------------------------------------------------------------

use employees;

SELECT dept_name, AVG(salary) FROM dept_emp 
	INNER JOIN salaries on dept_emp.emp_no = salaries.emp_no
    INNER JOIN departments on dept_emp.dept_no = departments.dept_no
    WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
    group by dept_name;


SELECT CONCAT(last_name, ' ', first_name) AS full_name, max(salary) FROM salaries 
	INNER JOIN employees on salaries.emp_no = employees.emp_no
    group by full_name;
    
    
    
SELECT CONCAT(last_name, ' ', first_name) AS full_name, max(salary) as max_salary FROM dept_emp 
	INNER JOIN salaries on dept_emp.emp_no = salaries.emp_no
    INNER JOIN departments on dept_emp.dept_no = departments.dept_no
    INNER JOIN employees on dept_emp.emp_no = employees.emp_no
    WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'; 
    
    
    
    
    
    
SELECT count(dept_emp.dept_no) AS count_emp FROM dept_emp 
	INNER JOIN salaries on dept_emp.emp_no = salaries.emp_no
    INNER JOIN departments on dept_emp.dept_no = departments.dept_no
    WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01';    
    
SELECT dept_name, count(dept_emp.dept_no) AS count_emp, sum(salary) AS sum_salary FROM dept_emp 
	INNER JOIN salaries on dept_emp.emp_no = salaries.emp_no
    INNER JOIN departments on dept_emp.dept_no = departments.dept_no
    WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
    group by dept_name;    
