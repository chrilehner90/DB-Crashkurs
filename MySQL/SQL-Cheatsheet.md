# SQL Crash-Kurs

## Statements

### Datenbanken anzeigen

    ```
        show databases;
    ```

### vorhandene Datenbank verwenden

    ```
        use EXAMPLE_DB;
    ```

### CREATE
	```
		CREATE TABLE celebs (id INTEGER, name TEXT, age INTEGER);
	```

### INSERT
	```
		INSERT INTO celebs (id, name, age) VALUES (1, 'Angelina Jolie', 21);
	```


### SELECT
	```
		SELECT name from celebs;
	```

### UPDATE
    ```
        UPDATE celebs SET age = 22 WHERE id = 1; 
        UPDATE celebs SET twitter_handle = '@taylorswift13' WHERE id = 4;
    ```

### ALTER TABLE
    ```
        ALTER TABLE celebs ADD twitter_handle TEXT;
    ```

### DELETE
    ```
        DELETE FROM celebs WHERE twitter_handle IS NULL;
    ```

### Verknüpfung von Tabellen


## CONSTRAINTS

Constraints braucht man um Regeln zu erstellen, die für Spalten in einer Tabelle angewandt werden.
- PRIMARY KEY: Der Primärschlüssel gibt an, durch welche Spalte sich Datensätze eindeutig unterscheiden können
- FOREIGN KEY: Der Fremdschlüssel ist ein Verweis in einer Tabelle auf den Primärschlüssel in einer anderen Tabelle.
- NOT NULL: NULL Werte in einer Spalte mit NOT NULL Constraint sind nicht erlaubt
- DEFAULT: Standardwert, wenn kein Wert angegeben wurde
- UNIQUE: Alle Werte in der Spalte müssen unterschiedlich sein (z.B. PRIMARY KEYs müssen eindeutig unterscheidbar sein)
- INDEX: Wird gebraucht um die Performance zu beim Lesen von Datenbanken zu beschleunigen (http://use-the-index-luke.com/)


## Keywords

### DISTINCT

    Ein Query mit DISTINCT beinhaltet nur eindeutige Werte. Also jeden Wert nur einmal.

    ```
        SELECT DISTINCT genre FROM movies;
    ```

### WHERE

    Eines der wichtigsten Schlüsselwörter. Lässt z.B. vergleiche zu um die Rückgabe entsprechend zu filtern.

    ```
        SELECT * FROM movies WHERE rating > 8;
    ```

    Das zeichen ">" ist hierbei ein Operator. Es gibt folgende weitere Operatoren:
        - "=" gleich
        - "!=" ungleich
        - "<" kleiner
        - ">" größer
        - "<=" kleiner gleich
        - ">=" größer gleich

### LIKE
    
    Das Schlüsselword LIKE wird verwendet um ähnliche Werte abzufragen. Mit LIKE kann man sogenannte Wildcards benutzen um diese ähnlichen Werte auszudrücken.
    Wildcards sind:
        - "_" wird verwendet um einen variablen Buchstaben anzugeben
        - "%" wird verwendet um eine variable Zeichenkette anzugeben mit 0 oder mehr Zeichen

    ```
        SELECT * FROM movies WHERE name LIKE "Se_en";
        SELECT * FROM movies WHERE name LIKE "A%";
    ```

### BETWEEN

    BETWEEN braucht man um Bereiche auszudrücken. Dabei heißt z.B. "BETWEEN 1990 and 2000" vom Jahr 1990 (inklusive) bis 2000 (exklusive).
    Die Datentypen für die Bereiche ausgewählt werden können, können Zahlen (INTEGER), Buchstaben (TEXT, VARCHAR, ...) und Daten (DATE) sein.

    ```
        SELECT * FROM movies WHERE name BETWEEN "A" AND "J";
        SELECT * FROM movies WHERE year BETWEEN 1990 AND 2000;
    ```

### AND / OR
    
    AND und OR braucht man um Bedingungen von Abfragen zu verknüpfen. Bei AND müssen beide Bedingungen zutreffen, damit eine Zeile in die Ergebnistabelle kommt.

    ```
        SELECT * FROM movies WHERE year BETWEEN 1990 AND 2000 AND genre = "comedy";
    ```

    Bei OR hingegen muss mindestens eine der Bedinungen zutreffen, damit die entsprechende Zeile in die Ergebnistabelle kommt.

    ```
        SELECT * FROM movies WHERE genre = "comedy" OR year < 1980;
    ```

### ORDER BY ... DESC / ASC

    Mit ORDER BY wird festgelegt nach welcher Spalte sortiert werden soll. Dabei kann mit DESC (descending = absteigend) und ASC (ascending = aufsteigend) die Art der Sortierung festgelegt werden
    
    ```
        SELECT * FROM movies ORDER BY imdb_rating DESC;
    ```

### LIMIT

    LIMIT legt nach der Abfrage und Sortierung fest wieviele Zeilen vom Resultat tatsächlich zurück gegeben werden sollen.

    ```
        SELECT * FROM movies ORDER BY imdb_rating ASC LIMIT 3;
    ```

### GROUP BY

    Gruppieren von Ergebnissen. Wird nur in Kombination mit Aggregatsfunktionen verwendet (siehe unten).

    ```
        SELECT price, COUNT(*) FROM fake_apps GROUP BY price;
        SELECT price, COUNT(*) FROM fake_apps WHERE downloads > 20000 GROUP BY price;
    ```

### AS

    Das Schlüsselwort AS wird dazu verwendet um Tabellen im Resultat umzubenennen. Wichtig ist, dass die Tabellen nicht in der Datenbank umbenannt werden, sondern der neue Name nur ein ALIAS für das Ergebnis ist.

    ```
        SELECT albums.name AS 'Album', albums.year, artists.name AS 'Artist'
        FROM albums
        INNER JOIN artists
        ON albums.artist_id = artists.id
        WHERE albums.year > 1980;
    ``

## Aggregatsfunktionen

    Durch Aggregatsfunktionen lassen sich Berechnungen über SQL durchführen. Diese nehmen mehrere Werte als Parameter und berechnen daraus einen Wert, den sie zurück geben.

### COUNT

    Zählen der zurückgegeben Zeilen im Resultat. COUNT bekommt als Parameter den Namen einer Spalte und zählt alle Zeilen, die nicht NULL enthalten. Um alle Zeilen zu zählen, kann man als Parameter "*" übergeben.

    ```
        SELECT COUNT(*) FROM fake_apps;
        SELECT COUNT(*) FROM fake_apps WHERE price = 0;
        SELECT price, COUNT(*) FROM fake_apps GROUP BY price;
    ```

### SUM
    
    Summe der Werte der angegebenen Spalte berechnen.

### MAX

    Maximum der angegebenen Spalte.

### MIN

    Minimum der angegebenen Spalte

    ```
        select MIN(downloads) FROM fake_apps;
    ```

### AVG

    Durchschnitt der angegebenen Spalte.

    ```
        SELECT price, AVG(downloads) FROM fake_apps GROUP BY price;
    ```

### ROUND

    Funktion um z.B. das ERgebnis von AVG zu runden.

    ```
        SELECT price, ROUND(AVG(downloads), 2) FROM fake_apps GROUP BY price;
    ```


## Tabellen kombinieren

### CROSS JOINS

    Cross Joins entstehen, wenn man die Spalten mehrerer Tabellen im SELECT Statement kombiniert und bei FROM mehrere Tabellen, mit einem Komma getrennt, angibt.
    Die Ergebnistabelle enthält aber dann vermischte Daten, die nicht stimmen.
    Im folgenden Beispiel wird jeder Albumname mit jedem Interpreten aufgelistet:

    ```
        SELECT albums.name, albums.year, artists.name FROM albums, artists;
    ```

### INNER JOINS

    Inner Joins kombinieren nur die Zeilen in denen die Join-Bedingung TRUE ergibt. Es sind also keine NULL Werte in einer der beiden IDs zulässig.

    ```
        SELECT * FROM albums
        INNER JOIN artists
        ON albums.artist_id = artists.id;
    ```

### LEFT OUTER JOINS

    Left Outer Joins nehmen von der linken Tabelle (die erste die abgefragt wird -> in diesem Fall albums) alle Zeilen her und kombinieren diese mit der rechten Tabelle. Wenn allerdings ein Album keinen Interpreten hat, wird es trotzdem verwendet und die fehlenden Werte werden mit NULL aufgefüllt.
 
    ```
        SELECT * FROM albums
        LEFT OUTER JOIN artists
        ON albums.artist_id = artists.id;
    ```

## ACID (Atomicity, Consistency, Integrity, Durability)