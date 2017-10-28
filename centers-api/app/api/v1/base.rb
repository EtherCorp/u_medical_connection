require 'activity_logger'
require 'json'
require 'dispatcher_worker'
require 'unicorn_logger'

# module v1 of a API
module V1
  # Base class of API v1
  class Base < Grape::API
    version 'v1', using: :path
    conn = ActivityLogger.new
    logger = UnicornLogger.logger

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
      request_type = 'patients'

      DispatcherWorker.perform_async(request_type, params)
      # DispatcherWorker.perform_async(params[:token], params[:medical_center], params[:body])
      logger.debug patient
    end
  end
end
