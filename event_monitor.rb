require './data_logger.rb'
require './customer.rb'
require 'date'

#@@dbh = Mysql.real_connect("137.43.166.175", "bellmr", "", "test")
@@dbh = Mysql.real_connect("csserver.ucd.ie", "osullivan", "V36kxrv", "osullivan")


class Event_Monitor

attr_accessor :data_logger, :data_logger_watcher, :customer

	def initialize
		@data_logger = Data_Logger.new
		@data_logger_watcher = Data_Logger_Watcher.new(data_logger)
#		@data_logger.run
	end

	def run
	
		loopcount=0
		loop do
			loopcount=loopcount+1
			if (loopcount>5) then
				@data_logger.volume=1.666667
				@data_logger.time_now=Time.now
			end
			
			if (loopcount>17) then
				@data_logger.volume=0
			end
			
			if (loopcount>20) then
				@data_logger.volume=0.5
				@data_logger.time_now=Time.now
			end
			
			if (loopcount>30) then
				@data_logger.volume=0
			end
			@data_logger.run
			sleep 1
		end

	end


end
event_monitor = Event_Monitor.new


@res = @@dbh.query("SELECT * FROM customer")
@cust_ids = Array.new
@cust_names = Array.new

		while (row = @res.fetch_row)
			@cust_ids<<row[0]
			@cust_names<<row[1]
		end
		puts @cust_ids
		puts @cust_names
@input=-999
@exists = false
def get_Customer

puts "Please select your customer id from below"
		
	@cust_ids.each_with_index { |id,index|
		
			puts ("Customer ID : #{id} Customer Name : #{cust_names[index]}")
#			puts id.to_i.class
			puts @input.class
			if (customer[0].to_i==@input) then
				@exists = true
			else
				@exists = false
			end

	}
		
		@input = gets.to_i
		puts ("You entered #{@input}")
	
		if (!@exists) then 
			get_Customer
		end
	
	
end

get_Customer




@@customer = Customer.new(@input)
bill = @@customer.get_customer_appliances
puts bill.class
bill.each { |x| puts x.app_desc}

puts ("Customer total volume #{@@customer.get_total_volume}")

puts ("Customer total for Toilet #{@@customer.get_total_by_appliance_type('Toilet')}")

puts ("Customer average time for Power Shower #{@@customer.get_avg_flow_time('Power Shower')} seconds")


event_monitor.run


