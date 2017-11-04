# Dispatcher worker that transform data and send to unicorn
class DispatcherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  require 'mongo_connection'

  def perform(request_persistence, request_type, json_data)
    json_data = JSON.parse(json_data).to_h
    hash = JSON.parse(request_persistence)[0].to_h
    center_driver = 'MedicalCenter1' # getDriverByToken(json_data[:token]) result to token validation for center
    driver = Object.const_get('Drivers::' + center_driver).new
    normalized_json = driver.parse(request_type, json_data)
    RequestAck.post(request_type, normalized_json, hash)
  end
end
