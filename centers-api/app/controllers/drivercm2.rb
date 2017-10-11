require 'json'
require './jsonfileestandar'
require File.expand_path('../drivercontroller.rb', __FILE__)

class DriverCM2 < DriverController

  def parseCM2(data)
    @dc = DriverController.new
    jsonfile = JsonFileEstandar.new
    data_hash_json = JSON.parse(data)
    nameOne = data_hash_json['body']['name']
    aux = nameOne.gsub(/\s+/m, ' ').strip.split(" ")
    @dc.name = aux[0]
    @dc.lastName = aux[1]
    @dc.rut = "180000003"
    @dc.age = "21"
    medicalCenter= data_hash_json['medical_center']
    @dc.medicalCenter = medicalCenter
    token_s = data_hash_json['token']
    @dc.token = token_s
    save_s = data_hash_json['save']
    @dc.save = save_s
    @dc.medicalCenter = medicalCenter
    status = data_hash_json['status']
    @dc.status = status
    queued = data_hash_json['queued']
    @dc.queued = queued
    print "json contiene token: ",@dc.token," medicalCenter: ",@dc.medicalCenter," save: ",@dc.save," name: ", @dc.name, " lastName: ", @dc.lastName, " age: ", @dc.age, " rut:", @dc.rut," status: ",@dc.status, " queued: ",@dc.queued, "\n"
    jsonfile.createJson(@dc.token, @dc.medicalCenter, @dc.save, @dc.name, @dc.lastName,  @dc.age, @dc.rut, @dc.queued, @dc.status)
    return @dc
  end
end

