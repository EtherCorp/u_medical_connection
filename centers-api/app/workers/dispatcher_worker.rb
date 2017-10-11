# Dispatcher worker that transform data and send to unicorn
class DispatcherWorker
  require_relative '../../lib/request_utils'
  include Sidekiq::Worker
  sidekiq_options retry: false

  require 'net/http'
  require 'uri'
  @header = { 'Content-Type' => 'text/json' }

  def perform(end_point, json_data)
    puts '---- Hello from DispatcherWorker ----'
    puts '**************************'
    puts json_data
    puts end_point
    puts '**************************'
    puts 'TODO: Transform JSON input data with Driver'
    puts 'TODO: Send transform data to Unicorn'
    #uri = URI.parse(URI.encode_www_form(end_point.strip))
    #response = Net::HTTP.post_form(uri, json_data)
    #puts response.body
    #_response = http.request(request)

    #RequestUtils.post(end_point, json_data)
    puts 'TODO: Is saved data?'
    puts '-------------------------------------'
  end
end
