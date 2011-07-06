require './event_time.rb'
require './flow.rb'
require './inference_engine.rb'
require './master.rb'
require 'observer'



class Data_Logger

include Observable

attr_accessor :time_now, :volume, :new_event

def initialize
	@new_event = true
	@volume = 0
	@time_now = 0
	@volume_last = 0
	@time_start = 0
	@total_volume = 0	
end

	def run

			puts "Data Logger Volume #{@volume}"
			if ((@volume )>0&&@new_event) then
				@time_start = @time_now
				@volume_last = @volume
				puts "In first if, time_now #{@time_now}"
				@new_event = false
			end
		
			if ((@volume )==0&&!@new_event) then
				@new_event = true
				changed
				notify_observers(@time_start,@time_now,@total_volume)
				@total_volume = 0
				@volume = 0
				@volume_last = 0
				puts "In second if, time_now #{@time_now}"
			end
			@total_volume = @total_volume + @volume

	end

end

class Data_Logger_Watcher
# A class to watch the data logger, and if data is recorded, to write the data to the appropriate tables in the database

attr_accessor :volume, :time1, :time2, :recorded
	
	def initialize(observable)
		observable.add_observer(self)
		@time1 = 0
		@time2 = 0
		@recorded = false
		@volume = 0
		
	end
	
	def update(time1,time2,volume)

	event_time = Event_Time.new
	event_time.event_start_time = time1
	event_time.event_end_time = time2
	puts ("Time1 = #{time1} Time2 = #{time2}")
	event_time.write_in

	flow = Flow.new
	flow.vol_used = volume
	flow.write_in
	puts ("Volume used this event #{volume}")

	inference_engine = Inference_Engine.new
	inference_engine.run(time1,time2,volume)

	master = Master.new
	master.time_id = event_time.time_id
	master.flow_id = flow.flow_id
	master.inferred_id = inference_engine.inferred_id
# CHANGE BELOW TO GET REAL CUST_ID
	master.cust_id = 2
	master.write_in
	
	end
	
end


