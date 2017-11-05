require 'activity_logger'
require 'mongo_connection'

module V1
  class Base < Grape::API
    desc 'Bulk request'
    post do
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

      request_type = 'unknown'
      DispatcherWorker.perform_async(request_type, request)
    end
  end
end