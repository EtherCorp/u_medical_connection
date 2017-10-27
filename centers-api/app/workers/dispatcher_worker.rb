# Dispatcher worker that transform data and send to unicorn
class DispatcherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  require 'mongo_connection'

  def perform(request_persistence, request_type, json_data)
    puts '**********##########< dispatcher_worker.rb >##########**************'
    puts '* params: '
    puts json_data
    puts '* request_persistence: '
    puts request_persistence
    puts '* request_type: '
    puts request_type
    puts '* hash: '
    puts JSON.parse(request_persistence)[0].to_h
    puts '**********#########</ dispatcher_worker.rb >###########**************'

    json_data = JSON.parse(json_data).to_h
    hash = JSON.parse(request_persistence)[0].to_h

    puts '>>> Driver Translator JSON'
    center_driver = 'MedicalCenter1'
    driver = Object.const_get('Drivers::' + center_driver).new
    normalized_json = driver.parse(request_type, json_data)
    puts JSON.generate(normalized_json)
    puts '>>> Send Request to Unicorn'
    Request::Patient.POST(normalized_json)
    puts '>>> TODO: Is saved data?'
    hash['status'] = 'Done'
    hash['_id'] = BSON::ObjectId.from_string(hash['_id']['$oid'])
    mongo_connection = MongoConnection.new
    mongo_connection.update_request(hash)
  end
end
