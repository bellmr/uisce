require 'mysql'

class Master

attr_accessor :time_id, :flow_id, :inferred_id, :cust_id


def initialize
end

def write_in
	puts ("Master")
	puts ("time_id #{@time_id}")
	puts ("flow_id #{@flow_id}")
	puts ("inferred_id #{@inferred_id}")
	puts ("cust_id #{@@customer.cust_id}")
	res = @@dbh.query("INSERT INTO master (master_time_id,master_flow_id,master_cust_id,master_inferred_id) VALUES (#{@time_id},#{@flow_id},#{@@customer.cust_id},#{@inferred_id})")
end

end

	