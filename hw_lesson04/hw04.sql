---------------------------------------------------------------------------
-- employees --  
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- Создать VIEW запросы --  
---------------------------------------------------------------------------
use employees;

-- 1. Выбрать среднюю зарплату по отделам.
	
CREATE VIEW view_salary_dept_avg as
	SELECT dept_name, round(avg(salary), 2) as avg_salary 
	FROM dept_emp 
	JOIN salaries on dept_emp.emp_no = salaries.emp_no
    JOIN departments on dept_emp.dept_no = departments.dept_no
    WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
    group by departments.dept_no;

-- 2. Выбрать сотрудников с максимальной зарплатой.
CREATE VIEW view_salary_max as
	SELECT concat (employees.first_name,' ',employees.last_name) as full_name, salary 
	FROM employees 
	JOIN salaries on employees.emp_no = salaries.emp_no
	WHERE salary in (
		SELECT max(salary)
		FROM salaries
		where salaries.to_date = '9999-01-01');
    
-- 3. Посчитать количество сотрудников во всех отделах.
CREATE VIEW view_emp_count as
	SELECT count(dept_emp.emp_no) AS count_emp 
	FROM dept_emp 
	INNER JOIN salaries on dept_emp.emp_no = salaries.emp_no
	INNER JOIN departments on dept_emp.dept_no = departments.dept_no
	WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01';    
    
    
-- 4. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
CREATE VIEW view_DeptEmp_CountSalary as
	SELECT dept_name, count(dept_emp.dept_no) AS count_emp, sum(salary) AS sum_salary 
	FROM dept_emp 
	JOIN salaries on dept_emp.emp_no = salaries.emp_no
	JOIN departments on dept_emp.dept_no = departments.dept_no
	WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
	group by departments.dept_no;  
	

---------------------------------------------------------------------------
-- Создать функцию для поиска менеджера по имени и фамилии --  
---------------------------------------------------------------------------
----------------------------------------------------------------------------------------
SHOW FUNCTION STATUS WHERE Db = DATABASE();
----------------------------------------------------------------------------------------

delimiter //

DROP FUNCTION IF EXISTS get_manager;
CREATE FUNCTION get_manager (fullname VARCHAR(50))
returns VARCHAR(800)
begin
	return(
		SELECT concat (employees.first_name,' ',employees.last_name, ' | Emp_no: ', employees.emp_no, ' | Departament: ', dept_name, ' | Salary: ', salary )
		FROM dept_manager
		JOIN employees on dept_manager.emp_no = employees.emp_no
		JOIN departments on dept_manager.dept_no = departments.dept_no
		JOIN salaries on employees.emp_no = salaries.emp_no
		WHERE salaries.to_date > now() and dept_manager.to_date > now() and concat (employees.first_name, ' ', employees.last_name) = fullname);
end //

delimiter ;
	
SELECT get_manager('Vishwani Minakawa');



---------------------------------------------------------------------------
-- Создать триггер выплаты бонуса новому сотруднику --  
---------------------------------------------------------------------------

DROP TRIGGER if EXISTS trig_salary_bonus;

delimiter //

CREATE TRIGGER trig_salary_bonus
AFTER INSERT on employees
for each row
begin
	INSERT INTO salaries VALUES 
	(NEW.emp_no, 5000, NEW.hire_date, NEW.hire_date);
end //

delimiter ;

INSERT INTO `employees` VALUES 
(500000,'2000-01-01','Georgi','Simmel','M','2019-01-01'),
(500001,'2000-01-01','Georgi','Simmel','M','2019-01-01');
