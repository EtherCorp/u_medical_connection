require 'mongo'
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
    @@connection.close
  end

  def find_request_by_id(mongo_id)
    @@connection['request'].find(_id: mongo_id)
  end

  def update_request(mongo_request)
    @@connection['request'].update_one({ '_id' => mongo_request['_id'] },
                                       mongo_request)
  end

  def pending_request
    @@connection['request'].find(status: 'Pending')
  end

  def save_request(params)
    @@connection['request'].insert_one(params)
  end
end
