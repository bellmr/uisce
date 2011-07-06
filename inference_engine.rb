
require 'mysql'

class Inference_Engine
	#include Observable
	attr_accessor :inferred_id, :app_id
	
	def initialize
	end

#	def update(bill)
#		@bill=bill
#		dbh = Mysql.real_connect("localhost", "bellmr", "", "test")
#		res = dbh.query("INSERT INTO inferred (app_id) VALUES (#{@bill})")
#		dbh.close if dbh
#		@master.inferred_id = @inferred_id
#		@master.write_in
#	end

	def run(time1,time2,volume)
		found = false
#		LOGIC FOR INFERENCE ENGINE IN HERE
		#dbh = Mysql.real_connect("localhost", "bellmr", "", "test")
		
# NEED TO USE AN APPLIANCE CLASS FOR GETTING APPLIANCE STUFF
#		res = @@dbh.query("SELECT * FROM appliance")
		customer_appliances = @@customer.get_customer_appliances
		puts("Inference engine time1 = #{time1}, time2 = #{time2}, volume = #{volume}")
		flow_rate = volume.to_f / (time2.to_f - time1.to_f)
		puts ("Flow rate = #{flow_rate}")
		result_appliance = Array.new
		result_id = Array.new
		
		
		customer_appliances.each { |x| puts x.app_desc}
		
		
#		while (row = res.fetch_row)
#			puts (volume.class)
#			puts ("Flow_rate #{flow_rate} app flow rate lbound #{(row[3].to_f/60)*0.9} app flow rate ubound #{row[3].to_f/(60*0.9)}")

		customer_appliances.each { |appliance| 
		
		puts appliance.app_id
		puts appliance.app_desc
		puts appliance.app_name
		puts appliance.app_spec_rate
		puts appliance.app_spec_vol
		
			if ((flow_rate >= (appliance.app_spec_rate.to_f/60)*0.95&&flow_rate <= appliance.app_spec_rate.to_f/(60*0.95))&&!found && appliance.app_spec_vol.to_f==0.0) then
				result_appliance << appliance.app_desc
				result_id << appliance.app_id
				puts ("Appliance match found on flow rate #{appliance.app_desc}")
				found=true
			elsif (volume.to_f >= appliance.app_spec_vol.to_f*0.95 && volume.to_f <= appliance.app_spec_vol.to_f/0.95 && appliance.app_spec_rate ==0 && !found) then 
				result_appliance << appliance.app_desc
				result_id << appliance.app_id
				puts ("Appliance match found on volume #{appliance.app_desc}")
				found=true
			elsif (!found)
				puts("No appliance match found")
			end
			
		}
			
#		end
		
		
		if (found) then
			app_id = result_id[0]
		else
			app_id = -999
		end
			write_in(app_id)
	end
	
	def write_in(app_id)
		@app_id=app_id
		infer_rows = Array.new
		#dbh = Mysql.real_connect("localhost", "bellmr", "", "test")
		#if (@app_id!=-999) then 
			res = @@dbh.query("INSERT INTO inferred (inferred_app_id) VALUES (#{@app_id})")
			#puts ("res class #{res.class}")
			#res.free
			res = @@dbh.query("SELECT inferred_id from inferred ORDER BY inferred_id ASC")
			while (row = res.fetch_row)
				infer_rows << row[0].to_i
#				puts row[0].to_i
			end
			puts ("Number of inferred records #{infer_rows.length}")
			@inferred_id = infer_rows[-1]
			puts "Infer_id #{@inferred_id}"
			#dbh.close if dbh
		#end
	end

end
		