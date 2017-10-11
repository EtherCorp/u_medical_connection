require 'json'
require File.expand_path('../drivercontroller.rb', __FILE__)

class DriverCM1 < DriverController
	

  	def parseCM1(data)
  		@dc = DriverController.new
      	data_hash_json = JSON.parse(data)
      	first_name = data_hash_json['body']['first_name']
      	last_name = data_hash_json['body']['last_name']
      	@dc.name = first_name
      	@dc.lastName = last_name
      	@dc.rut = "180000003"
      	@dc.age = "21"
      	token_s = data_hash_json['token']
      	@dc.token = token_s
      	save_s = data_hash_json['save']
      	@dc.save = save_s
  		print "json contiene token: ",@dc.token," medicalCenter: ",@dc.medicalCenter," save: ",@dc.save," name: ", @dc.name, " lastName: ", @dc.lastName, " age: ", @dc.age, " rut:", @dc.rut, "\n"
  	end
end
