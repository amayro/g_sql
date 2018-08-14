---------------------------------------------------------------------------
-- geodata --
---------------------------------------------------------------------------
use geodata;

-- 1.
SELECT _countries.title as country, _regions.title as region, _cities.title as city FROM _cities 
	INNER JOIN _countries on _cities.country_id = _countries.id
    INNER JOIN _regions on _cities.region_id = _regions.id;
	
-- 2.
SELECT _countries.title as country, _regions.title as region, _cities.title as city FROM _cities 
	INNER JOIN _countries on _cities.country_id = _countries.id
    INNER JOIN _regions on _cities.region_id = _regions.id
    WHERE _regions.title = 'Московская область';
	
	
	
---------------------------------------------------------------------------
-- employees --  254466
---------------------------------------------------------------------------

use employees;

-- 1. Выбрать среднюю зарплату по отделам.
SELECT dept_name, AVG(salary) as avg_salary FROM dept_emp 
	INNER JOIN salaries on dept_emp.emp_no = salaries.emp_no
    INNER JOIN departments on dept_emp.dept_no = departments.dept_no
    WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
    group by dept_name;

-- 2. Выбрать максимальную зарплату у сотрудника.
SELECT salaries.emp_no, CONCAT(last_name, ' ', first_name) AS full_name, max(salary) as max_salary FROM salaries 
	INNER JOIN employees on salaries.emp_no = employees.emp_no
    WHERE salaries.to_date = '9999-01-01'
    group by salaries.emp_no;
    
    
-- 3. Удалить одного сотрудника, у которого максимальная зарплата.
DELETE FROM employees 
	WHERE employees.emp_no = (SELECT salaries.emp_no FROM salaries 
    WHERE salaries.to_date = '9999-01-01' and salary = (select max(salary) FROM salaries));
    
    
-- 4. Посчитать количество сотрудников во всех отделах.
SELECT count(dept_emp.emp_no) AS count_emp FROM dept_emp 
	INNER JOIN salaries on dept_emp.emp_no = salaries.emp_no
    INNER JOIN departments on dept_emp.dept_no = departments.dept_no
    WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01';    
    
    
-- 5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
SELECT dept_name, count(dept_emp.dept_no) AS count_emp, sum(salary) AS sum_salary FROM dept_emp 
	INNER JOIN salaries on dept_emp.emp_no = salaries.emp_no
    INNER JOIN departments on dept_emp.dept_no = departments.dept_no
    WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
    group by dept_name;  