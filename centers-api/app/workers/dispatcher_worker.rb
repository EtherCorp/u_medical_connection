# Dispatcher worker that transform data and send to unicorn
class DispatcherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  require 'mongo_connection'

  def perform(request_persistence, request_type, json_data)
    json_data = JSON.parse(json_data).to_h
    hash = JSON.parse(request_persistence)[0].to_h
    center_driver = 'MedicalCenter1' # result to hash validation for center
    driver = Object.const_get('Drivers::' + center_driver).new
    normalized_json = driver.parse(request_type, json_data)
    Request::Patient.POST(normalized_json)

    hash['status'] = 'Done' # update Done state validating request response
    hash['_id'] = BSON::ObjectId.from_string(hash['_id']['$oid'])
    mongo_connection = MongoConnection.new
    mongo_connection.update_request(hash)
  end
end
