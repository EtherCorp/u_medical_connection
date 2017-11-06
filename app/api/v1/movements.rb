require 'activity_logger'
require 'mongo_connection'
module V1
  class Movements < Grape::API
    desc 'Movements request'
    post 'movements' do
      token = headers['Medical-Center-Token']
      request_data = params
      ActivityLogger.log(type: 'error', message: 'No token provided') unless token
  
      request = {
        token: token,
        request_type: 'movements',
        status: 'Pending',
        queued: nil,
        body: request_data
      }
  
      mongo_connection = MongoConnection.new
      persisted_request = mongo_connection.save_request(request)
  
      DispatcherWorker.perform_async(persisted_request)
    end
  end
end