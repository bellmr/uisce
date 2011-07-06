   #!/usr/bin/ruby -w
   # simple.rb - simple MySQL script using Ruby MySQL module
#export RUBYOPT=rubygems
   require 'mysql'

   begin
     # connect to the MySQL server
     dbh = Mysql.real_connect("localhost", "bellmr", "", "shop")
     # get server version string and display it
     puts "Server version: " + dbh.get_server_info
	 
	 res = dbh.query("SELECT * FROM orders")

   while row = res.fetch_row do
     printf "%s, %s\n", row[0], row[1]
   end
   puts "Number of rows returned: #{res.num_rows}"

   res.free
   
   rescue Mysql::Error => e
     puts "Error code: #{e.errno}"
     puts "Error message: #{e.error}"
     puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
   ensure
     # disconnect from server
     dbh.close if dbh
   end