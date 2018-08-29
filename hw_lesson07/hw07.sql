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



--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


DROP DATABASE IF EXISTS vk;
CREATE DATABASE IF NOT EXISTS vk;

CREATE TABLE user_ (
    id          INT             NOT NULL    AUTO_INCREMENT,  
    name        VARCHAR(30)     NOT NULL,
	PRIMARY KEY (id)
);
	
CREATE TABLE like_ (
    id          INT             NOT NULL    AUTO_INCREMENT,  
    from_id     INT             NOT NULL,
    to_id       INT             NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (fk_from_id)  REFERENCES user_ (id),
	FOREIGN KEY (fk_to_id)    REFERENCES user_ (id)
);
	
	
	
SELECT user_.id, user_.name, count(like_.from_id) as get_like, count(like_.to_id) as count_liked
	FROM like_
	JOIN user_ on like_.from_id = user_.id
	GROUP BY user_.id;
	
	