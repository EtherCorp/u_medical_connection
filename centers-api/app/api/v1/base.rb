require 'activity_logger'
require 'mongo_connection'
require 'json'
require_relative '../../workers/dispatcher_worker'
# module v1 of a API
module V1
  # Base class of API v1
  class Base < Grape::API
    version 'v1', using: :path
    mongo_connection = MongoConnection.new
    # endpoint patients
    desc 'Accepts information and passes it to the queue as default'
    post 'patients' do
      request_patient = {
        request_type: 'patients',
        status: 'Pending',
        data: {
          token: params[:token],
          medical_center: params[:medical_center],
          status: 'Pending', # param to value to delete (duplicate)
          queued: nil,
          body: params
        }
      }
      request = mongo_connection.save_request(request_patient)
      request_persistence = mongo_connection.find_request_by_id(request.inserted_id)
      request_type = 'patients'
      DispatcherWorker.perform_async(request_persistence.to_json, request_type,
                                     params.to_json)
    end
  end
end
