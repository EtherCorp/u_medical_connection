require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
Dir[File.expand_path 'centers/**/*.rb'].each{|f| require_relative(f)}

class MedicalCenterFaker
  attr_reader :uri

  def initialize(target_uri = 'http://localhost:3001/api/v1/')
    @uri = URI.parse(target_uri)
    @patientsFile = File.open("patients.json","a")
    @profesionalsFile = File.open("professionals.json","a")
  end

  def post_request(endpoint, body)
    header = {'Content-Type': 'application/json'}
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path + endpoint,header)
    request.body = body.to_json
    response = http.request(request)
    puts response
  end

  def run(requests=[{source:'MedicalCenter1', request_type:'patient', request_number:10}])
    requests.each do |request|
      (1..request[:request_number]).each do
        request_type = request[:request_type]
        request_source = request[:source]
        puts request_type
        request_body = Object.const_get(request_source).public_send(request_type)
        puts request_body.to_json  #Print the resul
        @patientsFile.puts(request_body.to_json)
        post_request(request_type+'s',request_body)
      end
    end
  end
  def run2(requests=[{source:'MedicalCenter1', request_type:'professional', request_number:10}])
    requests.each do |request|
      (1..request[:request_number]).each do
        request_type = request[:request_type]
        request_source = request[:source]
        puts request_type
        request_body = Object.const_get(request_source).public_send(request_type)
        puts request_body.to_json  #Print the result
        @profesionalsFile.puts(request_body.to_json)
        post_request(request_type+'s',request_body)
      end
    end
  end
  def run3(requests=[{source:'MedicalCenter1', request_type:'consult', request_number:10}])
    requests.each do |request|
      (1..request[:request_number]).each do
        request_type = request[:request_type]
        request_source = request[:source]
        puts request_type
        request_body = Object.const_get(request_source).public_send(request_type)
        puts request_body.to_json  #Print the result
        post_request(request_type+'s',request_body)
      end
    end
  end
end

