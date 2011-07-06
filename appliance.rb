require 'mysql'

class Appliance

attr_accessor :app_id, :app_name, :app_desc, :app_spec_rate, :app_spec_vol

	def initialize (app_id, app_name, app_desc, app_spec_rate, app_spec_vol)

		@app_id = app_id
		@app_name = app_name
		@app_desc = app_desc
		@app_spec_rate = app_spec_rate
		@app_spec_vol = app_spec_vol

	end


end
