# Dispatcher worker that transform data and send to unicorn
class DispatcherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(request_type, json_data)
    puts '---- Hello from DispatcherWorker ----'
    puts JSON.generate(json_data)

    puts '>>> Transform JSON input data with Driver'
    center_driver = 'MedicalCenter1'
    driver = Object.const_get('Drivers::' + center_driver).new
    puts 'driver'
    puts driver
    normalized_json = driver.parse(request_type, json_data)
    puts JSON.generate(normalized_json)

    puts 'end transform data to Unicorn with'
    #Request::Patient.POST(normalized_json)
    puts 'TODO: Is saved data?'
    puts '-------------------------------------'
  end
end
