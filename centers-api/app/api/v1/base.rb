require 'activity_logger'
require 'json'
require_relative '../../workers/dispatcher_worker'
#ReportWorker.perform_async(@json.token, @json.medical_center, @json.title, @json.body)
# module v1 of a API
module V1
  # Base class of API v1
  class Base < Grape::API
    version 'v1', using: :path
    conn = ActivityLogger.new
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
        patient: {
          token: params[:token],
          medical_center: params[:medical_center],
          status: 'Pending',
          queued: nil,
          body: params
        }
      }
      conn.save_patient(patient)
      conn.save_request_patient(request_patient)
      request_type = 'patients'
      puts '************************'
      puts request_type
      puts params[:nombre]
      puts patient[:body]
      puts '************************'

      DispatcherWorker.perform_async(request_type, params)
      #DispatcherWorker.perform_async(params[:token], params[:medical_center], params[:body])
      puts patient
    end
  end
end
