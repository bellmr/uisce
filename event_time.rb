#require "observer"
require 'mysql'
require 'date'
require 'time'


class Event_Time
	#include Observable
	attr_accessor :time_id, :event_start_time, :event_end_time, :tot_event_time, :master
	
	def initialize
		
	end

	def write_in
		puts ("Start time class #{@event_start_time.class}")
		puts ("Start time #{@event_start_time}")
		puts ("Start time #{@event_start_time.class}")
		puts ("End time #{@event_end_time}")
		puts ("End time #{@event_end_time.class}")
		
		@tot_event_time = (@event_end_time.to_f - @event_start_time.to_f)
		
		
		
#DateTime.parse(t.to_s)
		puts ("Duration #{@tot_event_time}")
		puts ("duration class #{@tot_event_time.class}")
		hours = (@tot_event_time/3600).to_i
		if (hours < 10 ) then
			dur_hours = "0" + hours.to_s
		else
			dur_hours = hours.to_s
		end
		minutes = (@tot_event_time/60 - hours * 60).to_i
		if (minutes < 10 ) then
			dur_mins = "0" + minutes.to_s
		else
			dur_mins = minutes.to_s
		end
		seconds = (@tot_event_time - (minutes * 60 + hours * 3600)).to_i
		if (seconds < 10 ) then
			dur_secs = "0" + seconds.to_s
		else
			dur_secs = seconds.to_s
		end
		#dbh = Mysql.real_connect("localhost", "bellmr", "", "test")
#		puts ("INSERT INTO time (event_start_time,event_end_time,tot_event_time) VALUES (
#		'#{@event_start_time.strftime("%Y-%m-%d %T")}',
#		'#{@event_end_time.strftime("%Y-%m-%d %T")}',
#		#{@tot_event_time})")

		if (@event_start_time.month < 10) then
			start_month = "0"+@event_start_time.month.to_s
		else
			start_month = ""+@event_start_time.month.to_s
		end
		
		if (@event_start_time.day < 10) then
			start_day = "0"+@event_start_time.day.to_s
		else
			start_day = ""+@event_start_time.day.to_s
		end
		
		if (@event_start_time.hour < 10) then
			start_hour = "0"+@event_start_time.hour.to_s
		else
			start_hour = ""+@event_start_time.hour.to_s
		end
		
		if (@event_start_time.min < 10) then
			start_min = "0"+@event_start_time.min.to_s
		else
			start_min = ""+@event_start_time.min.to_s
		end
		
		if (@event_start_time.sec < 10) then
			start_sec = "0"+@event_start_time.sec.to_s
		else
			start_sec = ""+@event_start_time.sec.to_s
		end
		
		
		if (@event_end_time.month < 10) then
			end_month = "0"+@event_end_time.month.to_s
		else
			end_month = ""+@event_end_time.month.to_s
		end
		
		if (@event_end_time.day < 10) then
			end_day = "0"+@event_end_time.day.to_s
		else
			end_day = ""+@event_end_time.day.to_s
		end
		
		if (@event_end_time.hour < 10) then
			end_hour = "0"+@event_end_time.hour.to_s
		else
			end_hour = ""+@event_end_time.hour.to_s
		end
		
		if (@event_end_time.min < 10) then
			end_min = "0"+@event_end_time.min.to_s
		else
			end_min = ""+@event_end_time.min.to_s
		end
		
		if (@event_end_time.sec < 10) then
			end_sec = "0"+@event_end_time.sec.to_s
		else
			end_sec = ""+@event_end_time.sec.to_s
		end
		
		
#		puts ("INSERT INTO time (event_start_time,event_end_time,tot_event_time) VALUES (
#		'#{@event_start_time.year}-#{start_month}-#{start_day} #{start_hour}:#{start_min}:#{start_sec}',
#		'#{@event_end_time.year}-#{end_month}-#{end_day} #{end_hour}:#{end_min}:#{end_sec}',
#		'#{dur_hours}:#{dur_mins}:#{dur_secs}')")
		res = @@dbh.query("INSERT INTO time (event_start_time,event_end_time,tot_event_time) VALUES (
		'#{@event_start_time.year}-#{start_month}-#{start_day} #{start_hour}:#{start_min}:#{start_sec}',
		'#{@event_end_time.year}-#{end_month}-#{end_day} #{end_hour}:#{end_min}:#{end_sec}',
		'#{dur_hours}:#{dur_mins}:#{dur_secs}')")
		#res.free
		res = @@dbh.query("SELECT * FROM time WHERE 
		event_start_time = '#{@event_start_time.year}-#{start_month}-#{start_day} #{start_hour}:#{start_min}:#{start_sec}'
		AND event_end_time = '#{@event_end_time.year}-#{end_month}-#{end_day} #{end_hour}:#{end_min}:#{end_sec}'
		AND tot_event_time = '#{dur_hours}:#{dur_mins}:#{dur_secs}'")
		time_rows = Array.new
		while (row = res.fetch_row)
			time_rows << row[0].to_i
		end
		@time_id = time_rows[-1]
		puts "Time_id #{@time_id}"
		#dbh.close if dbh
	end

end
		