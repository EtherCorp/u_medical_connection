require 'mongo'
# lib of MongoDB conections
class ActivityLogger
  @@connection = nil
  def initialize
    # set logger level to FATAL (only show serious errors)
    Mongo::Logger.logger.level = ::Logger::FATAL
    # set up a connection to the mongod instance which is running locally,
    # on the default port 27017
    if @@connection.nil?
      @@connection = Mongo::Client.new(['127.0.0.1:27017'], database: 'test')
    end
  end

  def connection
    @@connection
  end

  # get connection to one collection
  def movements
    @@connection['movements']
  end

  def patients
    @@connection['patients']
  end

  def save_movement(params)
    @@connection['movements'].insert_one(params)
  end

  def save_patient(params)
    @@connection['patients'].insert_one(params)
  end

  def close
    @@connection.close
  end

  def pending_request
    @@connection['request_patients'].find(status: 'Pending')
  end

  def save_request_patient(params)
    @@connection['request_patients'].insert_one(params)
  end
end

if __FILE__ == $0
  ActivityLogger.log(asd: '123', ewr: '543')
end
