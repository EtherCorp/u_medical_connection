require 'activity_logger'
require 'mongo_connection'
require 'json'
require_relative '../../workers/dispatcher_worker'
#ReportWorker.perform_async(@json.token, @json.medical_center, @json.title, @json.body)
# module v1 of a API
module V1
  # Base class of API v1
  class Base < Grape::API
    version 'v1', using: :path
    conn = ActivityLogger.new
    mongo_connection = MongoConnection.new
    # endpoint example
    desc 'Accepts information and passes it to the queue as default'
    post 'patients' do
      patient = {
        token: params[:token],
        medical_center: params[:medical_center],
        status: 'Pending',
        queued: nil,
        body: params
      }
      request_patient = {
        request_type: 'patients',
        status: 'Pending',
        data: {
          token: params[:token],
          medical_center: params[:medical_center],
          status: 'Pending',
          queued: nil,
          body: params
        }
      }
      conn.save_patient(patient)
      result = mongo_connection.save_request(request_patient)
      request_persistence = mongo_connection.find_request_by_id(result.inserted_id)
      request_type = 'patients'
      puts '**********##########< base.rb >##########**************'
      puts 'save data with _id: ' + result.inserted_id
      puts '* request_persistence.to_json: '
      puts request_persistence.to_json
      puts '* request_type: '
      puts request_type
      puts '* params: '
      puts params.to_json
      puts '**********#########</ base.rb >###########**************'
      DispatcherWorker.perform_async(request_persistence.to_json, request_type, params.to_json)
    end
  end
end
