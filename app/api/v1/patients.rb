require 'activity_logger'
require 'mongo_connection'
module V1
  class Patients < Grape::API
    desc 'Patients request'
    post 'patients' do

      token = headers['Medical-Center-Token']
      request_data = params
      unicorn_response = TokenValidation.validate_token(headers)
      #puts unicorn_response
      #return ActivityLogger.log(type: 'error', message: 'Invalid Token') unless unicorn_response.code == '200'
      request = {
        token: token,
        request_type: 'patients',
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
