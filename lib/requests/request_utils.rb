module Requests
  # Util class from request
  class RequestUtils
    require 'net/http'

    attr_reader :uri

    def initialize(target_uri = 'http://localhost:3000/api/v1/')
      @uri = URI.parse(target_uri)
    end
  
    def post(endpoint, body, headers = {})
      headers['Content-Type'] = 'application/json'
      #headers['Medical-Center-token'] = 'eyJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl9pZCI6MX0.YBoHU254D5ts-jG3Pxd7s0i8B8Qb-Ju7OSR7k6IN4pE'
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path + endpoint, headers)
      request.body = body.to_json
      http.request(request)
    end

    def get(endpoint, headers = {})
      headers['Content-Type'] = 'application/json'
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.path + endpoint, headers)
      http.request(request)
    end
  end
end
