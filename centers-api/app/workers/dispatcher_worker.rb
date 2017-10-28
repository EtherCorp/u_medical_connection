require 'unicorn_logger'

# Dispatcher worker that transform data and send to unicorn
class DispatcherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(request_type, json_data)
    logger = UnicornLogger.logger
    logger.debug JSON.generate(json_data)

    center_driver = 'MedicalCenter1'
    driver = Object.const_get('Drivers::' + center_driver).new
    logger.debug "driver: #{driver}"
    normalized_json = driver.parse(request_type, json_data)
    logger.debug JSON.generate(normalized_json)

    Request::Patient.post(normalized_json)
  end
end
