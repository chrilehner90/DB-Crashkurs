require "mysql"

begin
	connection = Mysql.new "localhost", "root", ""

	connection.query "drop database if exists Blog"
	connection.query "create database Blog"

	connection.query "use Blog"

	result = connection.query "show databases"

	n_rows = result.num_rows

	n_rows.times do
		p result.fetch_row.join ""
	end

	connection.query("CREATE TABLE authors(
		id INTEGER AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(30) NOT NULL
	);")

	connection.query("CREATE TABLE posts(
		id INTEGER AUTO_INCREMENT PRIMARY KEY,
		title VARCHAR(256) NOT NULL,
		author_id INTEGER,
		body TEXT NOT NULL,
		FOREIGN KEY(author_id) REFERENCES authors(id)
	);")

	connection.query("CREATE TABLE sites(
		id INTEGER AUTO_INCREMENT PRIMARY KEY,
		title VARCHAR(256) NOT NULL,
		author_id INTEGER UNIQUE NOT NULL,
		FOREIGN KEY(author_id) REFERENCES authors(id)
	);")

	author = connection.prepare("INSERT INTO authors(name) VALUES (?);")
	author.execute("Hans Huber")
	author = connection.prepare("INSERT INTO authors(name) VALUES (?);")
	author.execute("Johann Goethe")
	author = connection.prepare("INSERT INTO authors(name) VALUES (?);")
	author.execute("Douglas Adams")
	author = connection.prepare("INSERT INTO authors(name) VALUES (?);")
	author.execute("Douglas Crockford")


	# SQL injection example
	# author = connection.prepare("delete from authors where id = ?")
	# author.execute("1 OR 1 = 1")

	# author = connection.query("delete from authors where id = 1 OR 1 = 1")


	result = connection.query "select * from authors"

	n_rows = result.num_rows

	n_rows.times do
		p result.fetch_row.join "\s"
	end



rescue Mysql::Error => e
	puts e
ensure
	connection.close if connection
end