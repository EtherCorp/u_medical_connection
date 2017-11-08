# Util class from request
class RequestUtils
  require 'net/http'
  require 'uri'
  @header = { 'Content-Type' => 'text/json' }

  def self.post(end_point, json_data)
    uri = URI(end_point)
    response = Net::HTTP.post_form(uri, json_data)
    puts response.body
    #_response = http.request(request)
    puts 'RESPONSE COMPLETE IN POST'
    # SAVE HTTP STATUS WITH LOGGER
  end
end
