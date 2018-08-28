--------------------------------------------------------------------------------------
-- Создать нового пользователя и задать ему права доступа на базу данных --
--------------------------------------------------------------------------------------
CREATE USER 'user_accountant'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES on employees.salary to 'user_accountant'@'localhost'
FLUSH PRIVILEGES;


--------------------------------------------------------------------------------------
-- Сделать резервную копию базы, удалить базу и пересоздать из бекапа. --
--------------------------------------------------------------------------------------

mysqldump -uroot -p1234 employees > dump_employees.sql

DROP DATABASE IF EXISTS employees;

mysql -uroot -p1234 employees < dump_employees.sql

