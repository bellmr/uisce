#require 'observer'
require 'mysql'
require './inference_engine.rb'

class Flow 
#include Observable

attr_accessor :flow_id, :vol_used, :tot_vol_used, :master
#	def self.initialize
#		infeng = Inference_Engine.new(self)
#	
#	end

def initialize
	
end
		
#	def self.write_in(flow)
#		@flow=flow
#		dbh = Mysql.real_connect("localhost", "bellmr", "", "test")
#		res = dbh.query("INSERT INTO flow (volume) VALUES (#{@flow})")
#		changed
#		puts "notifying observers"
#		self.notify_observers("bill")
#	end
	
	def write_in
		@tot_vol_used=0.0
		tot_vols=Array.new
		flow_rows = Array.new
		#dbh = Mysql.real_connect("localhost", "bellmr", "", "test")
		res = @@dbh.query("SELECT * FROM flow ORDER BY flow_id ASC")
				while (row = res.fetch_row)
					tot_vols << row[2].to_f
				end
		if tot_vols.empty? then 
			@tot_vol_used = @vol_used
		else
			@tot_vol_used = @vol_used + tot_vols[-1]
		end
		res = @@dbh.query("INSERT INTO flow (vol_used,tot_vol_used) VALUES (#{@vol_used},#{@tot_vol_used})")
#		res.free
		res = @@dbh.query("SELECT flow_id from flow ORDER BY flow_id ASC")
		while (row = res.fetch_row)
			flow_rows << row[0].to_i
		end
		@flow_id = flow_rows[-1]
		puts "Flow_id #{@flow_id}"
	end
	
end
