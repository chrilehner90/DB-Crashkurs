DROP DATABASE IF EXISTS School;

CREATE DATABASE School;

USE School;

CREATE TABLE Student(
	matrnr INTEGER AUTO_INCREMENT PRIMARY KEY,
	vorname VARCHAR(30),
	nachname VARCHAR(30)
);

CREATE TABLE Kurs(
	kursnr INTEGER AUTO_INCREMENT PRIMARY KEY,
	titel VARCHAR(30)
);

Create Table Besuchen(
	matrnr INTEGER NOT NULL,
	kursnr INTEGER NOT NULL,
	FOREIGN KEY(matrnr) REFERENCES Student(matrnr),
	FOREIGN KEY(kursnr) REFERENCES Kurs(kursnr)
);


INSERT INTO Student(vorname, nachname) VALUES("Max", "Mustermann");

INSERT INTO Kurs(titel) VALUES("Datenbanken");
INSERT INTO Kurs(titel) VALUES("Algorithmik");

INSERT INTO Besuchen(matrnr, kursnr) VALUES(1, 1);
INSERT INTO Besuchen(matrnr, kursnr) VALUES(1, 2);

show tables;

SELECT s.vorname, s.nachname, k.titel FROM Student s, Kurs k, Besuchen b WHERE s.matrnr = b.matrnr AND k.kursnr = b.kursnr;

SELECT s.vorname, s.nachname, k.titel FROM Student s JOIN Besuchen b ON s.matrnr = b.matrnr JOIN Kurs k ON k.kursnr = b.kursnr;
