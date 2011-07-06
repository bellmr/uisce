require './data_logger.rb'

@@dbh = Mysql.real_connect("localhost", "bellmr", "", "test")

class Water_Waster


	def initialize
		@data_logger = Data_Logger.new
		@data_logger_watcher = Data_Logger_Watcher.new(data_logger)
		@data_logger.run
	end


	def run
	
		loopcount=0
		loop do
			loopcount=loopcount+1
			if (loopcount>5) then
				@data_logger.volume=80
				@data_logger.time_now=10+10*loopcount
			end
			
			if (loopcount>15) then
				@data_logger.volume=0
			end
			
			if (loopcount>20) then
				@data_logger.volume=0.5
				@data_logger.time_now=10+10*loopcount
			end
			
			if (loopcount>30) then
				@data_logger.volume=0
			end
			@data_logger.run
			sleep 1
		end

	end


end
water_waster Water_Waster.new
water_waster.run
