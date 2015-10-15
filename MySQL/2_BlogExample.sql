drop database if exists Blog;

create database Blog;
use Blog;


# RELATIONS
# Authors : Posts --> 1 : n
# Authors : Sites --> 1 : 1


CREATE TABLE authors(
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(30) NOT NULL
);

CREATE TABLE posts(
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(256) NOT NULL,
	author_id INTEGER,
	body TEXT NOT NULL,
	FOREIGN KEY(author_id) REFERENCES authors(id)
);

CREATE TABLE sites(
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(256) NOT NULL,
	author_id INTEGER UNIQUE NOT NULL,
	FOREIGN KEY(author_id) REFERENCES authors(id)
);


INSERT INTO authors(name) VALUES ("Hans Huber");
INSERT INTO authors(name) VALUES("Johann Goethe");
INSERT INTO authors(name) VALUES("Douglas Adams");
INSERT INTO authors(name) VALUES("Douglas Crockford");

INSERT INTO sites(title, author_id) VALUES("Mein Blog", 1);
INSERT INTO sites(title, author_id) VALUES("Meine Bücher", 2);
INSERT INTO sites(title, author_id) VALUES("Awesome stories", 3);

INSERT INTO posts(title, author_id, body) VALUES("Meine Erlebnisse", 1, "Blog POst!");
INSERT INTO posts(title, author_id, body) VALUES("Faust", 2, "Blog POst!");
INSERT INTO posts(title, author_id, body) VALUES("Hitchhiker's guide to the galaxy", 3, "Blog POst!");
INSERT INTO posts(title, author_id, body) VALUES("adsf", NULL, "hallo");

INSERT INTO posts(title, author_id, body) VALUES("Meine Erlebnisse 2", 1, "Blog POst!");
INSERT INTO posts(title, author_id, body) VALUES("Faust 2", 2, "Blog POst!");
INSERT INTO posts(title, author_id, body) VALUES("Hitchhiker's guide to the galaxy 2", 3, "Blog POst!");

show tables;

SELECT * FROM authors;
SELECT * FROM sites;
SELECT * FROM posts;



# JOINS

SELECT a.name, p.title, p.body FROM authors a, posts p WHERE a.id = p.author_id;

SELECT a.name, p.title, p.body FROM authors a INNER JOIN posts p ON a.id = p.author_id;

SELECT a.name, p.title, p.body FROM authors a LEFT OUTER JOIN posts p ON a.id = p.author_id;

SELECT a.name, p.title, p.body FROM authors a RIGHT OUTER JOIN posts p ON a.id = p.author_id;

