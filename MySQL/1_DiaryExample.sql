drop database if exists simple_example;
create database simple_example;

use simple_example;



CREATE TABLE diary (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	title varchar(128) NOT NULL UNIQUE,
	text TEXT,
	length INT NOT NULL,
	date DATE NOT NULL
);

INSERT INTO diary(title, text, length, date) VALUES ("entry 1", "today i found 1€. yeah!", 2300, "2013-04-25");
INSERT INTO diary(title, text, length, date) VALUES ("entry 2", NULL, 523, "2013-09-10");
INSERT INTO diary(title, text, length, date) VALUES ("entry 3", "another entry…", 1300, "2014-12-31");
INSERT INTO diary(title, text, length, date) VALUES ("entry 4", "some text written here", 523, CURRENT_DATE());
INSERT INTO diary(title, text, length, date) VALUES ("entry 4", "some text written here", 523, "2016-05-13");


SELECT * FROM diary;
SELECT * FROM diary WHERE title = "entry 2";
SELECT * FROM diary ORDER BY date DESC;
SELECT title, text FROM diary WHERE id = 3;
SELECT * FROM diary WHERE length = 523 AND title = "entry 2";

UPDATE diary SET text = "Typing a diary entry." WHERE id = 3;
SELECT * FROM diary WHERE id = 3;

ALTER TABLE diary ADD new_col INTEGER;
SELECT * FROM diary;

ALTER TABLE diary DROP new_col;
SELECT * FROM diary;

DELETE FROM diary WHERE text IS NULL;
SELECT * FROM diary;

select * from diary where text like "%te_t%";

INSERT INTO diary(title, text, length, date) VALUES ("entry 5", "some text written here", 523, CURRENT_DATE());
SELECT DISTINCT text FROM diary;

SELECT length, count(*) FROM diary GROUP BY length;

# ---------------------------------------

SELECT count(*) FROM diary;
SELECT max(length) FROM diary;
SELECT min(length) FROM diary;
SELECT avg(length) FROM diary;
SELECT round(avg(length)) FROM diary;