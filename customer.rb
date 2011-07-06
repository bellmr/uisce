require 'mysql'
require './appliance.rb'

class Customer

attr_accessor :cust_id, :cust_name, :cust_address

	def initialize(cust_id)
		@cust_id = cust_id
	end


	def get_customer_appliances
		cust_apps = Array.new
		res = @@dbh.query("SELECT link.app_id, appliance.app_name, appliance.app_desc, appliance.app_spec_rate, appliance.app_spec_vol FROM link JOIN appliance ON link.app_id = appliance.app_id WHERE link.cust_id =#{@cust_id}")
		while (row = res.fetch_row)
			cust_apps << Appliance.new(row[0].to_i,row[1],row[2],row[3].to_f,row[4].to_f)
		end
		return cust_apps
	end

	def get_total_volume
		cust_volume_total = Array.new
		res = @@dbh.query("SELECT tot_vol_used FROM flow JOIN master ON flow.flow_id = master.master_flow_id WHERE master.master_cust_id =#{@cust_id}")
		while (row = res.fetch_row)
			cust_volume_total << row[0].to_f
		end
		return cust_volume_total[-1]
	end

	def get_total_by_appliance_type(appliance_type)
		cust_appliance_total = Array.new
		res = @@dbh.query("SELECT SUM( flow.vol_used ) 
			FROM appliance JOIN ( flow JOIN ( inferred
			JOIN ( customer JOIN master ON master.master_cust_id = customer.cust_id) 
			ON inferred.inferred_id = master.master_inferred_id
			) ON master.master_flow_id = flow.flow_id
			) ON appliance.app_id = inferred.inferred_app_id
			WHERE appliance.app_desc =  '#{appliance_type}' AND customer.cust_id = #{@cust_id}")
		while (row = res.fetch_row)
			cust_appliance_total << row[0].to_f
		end
		return cust_appliance_total[-1]
	end
	
	def get_avg_flow_time(appliance_type)
		hours = 0
		mins = 0
		secs = 0
		res = @@dbh.query("SELECT time.tot_event_time 
			FROM appliance JOIN ( flow JOIN ( inferred
			JOIN ( customer JOIN (time join master ON master.master_time_id = time.time_id) ON master.master_cust_id = customer.cust_id) 
			ON inferred.inferred_id = master.master_inferred_id
			) ON master.master_flow_id = flow.flow_id
			) ON appliance.app_id = inferred.inferred_app_id
			WHERE appliance.app_desc =  '#{appliance_type}' AND customer.cust_id = #{@cust_id}")
		
		tokenized = Array.new
		while (row = res.fetch_row)
			tokenized = row[0]
			hours = hours + row[0][0,1].to_i
			mins = mins + row[0][3,4].to_i
			secs = secs + row[0][6,7].to_i
		end
		total_secs = secs + mins * 60.0 + hours * 3600.0
		return total_secs / res.num_rows
	end

end