# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

#Rails::Initializer.run do |config|
#config.load_paths << File.join(Rails.root, "app", "classes")
#end

run MyRailsApp::Application
