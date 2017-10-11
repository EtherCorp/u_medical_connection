require 'json'
require './drivercontroller'
require './drivercm1'
require './drivercm2'

class MainDriver 
  queue = Array.new
  file1 =  File.open('ejemplojson.json','r')
  file2 =  File.open('ejemplojson2.json','r')
  queue.push file1
  queue.push file2
  dc = DriverController.new
  response = Array.new

  queue.each do|d|
    while data = d.gets
      dc.parse(data)
      data_hash_json = JSON.parse(data)
      @dc = DriverController.new
      @dc.medicalCenter = data_hash_json['medical_center']
      if @dc.medicalCenter == "medical_center"
        @driver = DriverCM1.new
        @driver.parseCM1(data)
      end
      if @dc.medicalCenter == "medical_center2"
        @driver = DriverCM2.new
        @driver.parseCM2(data)
      end
    end
  end
end


