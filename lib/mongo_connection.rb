require 'mongo'
require 'json'

# lib of MongoDB conections for request persistence and queries
class MongoConnection
  @@connection = nil
  @@uri = '127.0.0.1:27017'
  @@database = 'request_persistence'
  
  def initialize
    # set up a connection to the mongod instance which is running locally,
    # on the default port 27017
    if @@connection.nil?
      @@connection = Mongo::Client.new([@@uri], database: @@database)
    end
  end
  
  def connection
    @@connection
  end
  
  def close
    connection.close
  end
  
  def find_request_by_id(mongo_id)
    response =  connection['request'].find(_id: mongo_id)
    return nil unless response
    JSON.parse(response.to_json)[0].to_h
  end
  
  def update_request(mongo_request)
    connection['request'].update_one({ '_id' => mongo_request['_id'] },
                                       mongo_request)
  end
  
  def pending_requests
    result = connection['request'].find(status: 'Pending')
    result.collect do |row|
      JSON.parse(row.to_json).to_h
    end
  end
  
  def delete_done_requests
    connection['request'].delete_many(status: 'Done')
  end
  
  def save_request(params)
    result = connection['request'].insert_one(params)
    find_request_by_id(result.inserted_id)
  end
end