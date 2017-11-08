# Dispatcher worker that transform data and send to unicorn
class DispatcherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  require 'mongo_connection'

  def perform(request)
    # Determine driver
    center_driver = 'MedicalCenter1' # getDriverByToken(json_data[:token]) result to token validation for center
    driver = Object.const_get('Drivers::' + center_driver).new
    
    # Parse request
    normalized_request = driver.parse(request['request_type'], request['body'])
    
    # Send request to Unicorn
    RequestAcknowledge.post(request, normalized_request)
  end
end
