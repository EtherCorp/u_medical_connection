require 'activity_logger'
require 'mongo_connection'
module V1
  class Professionals < Grape::API
    desc 'Professionals request'
    post 'professionals' do
      token = headers['Medical-Center-Token']
      request_data = params
      ActivityLogger.log(type: 'error', message: 'No token provided') unless token
  
      request = {
        token: token,
        status: 'Pending',
        queued: nil,
        body: request_data
      }
  
      mongo_connection = MongoConnection.new
      mongo_connection.save_request(request)
  
      request_type = 'professionals'
      DispatcherWorker.perform_async(request_type, request)
    end
  end
end