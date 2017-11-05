require 'activity_logger'
require 'json'
require_relative '../../workers/dispatcher_worker'
#ReportWorker.perform_async(@json.token, @json.medical_center, @json.title, @json.body)
# module v1 of a API
module V1
  # Base class of API v1
  class BaseOld < Grape::API
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
      request_type = 'patients'
      DispatcherWorker.perform_async(request_type, params)
      #DispatcherWorker.perform_async(params[:token], params[:medical_center], params[:body])
      patient
    end

    post 'professionals' do
      professional = {
        token: params[:token],
        medical_center: params[:medical_center],
        status: 'Pending',
        queued: nil,
        body: params
      }
      conn.save_professional(professional)
      request_type= 'professionals'
      professional
      DispatcherWorker.perform_async(request_type, params)
    end

    post 'consults' do
      consult = {
        token: params[:token],
        medical_center: params[:medical_center],
        status: 'Pending',
        queued: nil,
        body: params
      }
      conn.save_consult(consult)
      request_type= 'consults'
      consult
      DispatcherWorker.perform_async(request_type, params)
    end

    post 'movements' do
      movement = {
        token: params[:token],
        medical_center: params[:medical_center],
        status: 'Pending',
        queued: nil,
        body: params
      }
      conn.save_movement(movement)
      request_type= 'movements'
      movement
      DispatcherWorker.perform_async(request_type, params)
    end 
  end
end
