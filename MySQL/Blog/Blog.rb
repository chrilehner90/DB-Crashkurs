require "mysql"

begin
	connection = Mysql.new "localhost", "root", ""

	connection.query "drop database if exists Blog"
	connection.query "create database Blog"

	result = connection.query "show databases"

	n_rows = result.num_rows

	n_rows.times do
		p result.fetch_row.join ""
	end

	


	

rescue Mysql::Error => e
	puts e
ensure
	connection.close if connection
end