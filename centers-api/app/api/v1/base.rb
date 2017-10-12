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
      conn.save_patient(patient)
      DispatcherWorker.perform_async('patients', patient[:body])
      puts patient
    end
  end
end
