   #!/usr/bin/ruby -w
require "observer"
require "mysql"
require "./inference_engine.rb"


class FlowTest
include Observable

def initialize
	infeng = Inference_Engine.new(self)
	puts "new inference engine"
	#self.add_observer(infeng)
	
end
		
	def write_in(flow)
		@flow=flow
		dbh = Mysql.real_connect("localhost", "bellmr", "", "test")
		res = dbh.query("INSERT INTO flow (volume) VALUES (#{@flow})")
		changed
		puts "notifying observers"
		notify_observers(9999)
		
	end
	
end


flowtest = FlowTest.new
flowtest.write_in(45)
