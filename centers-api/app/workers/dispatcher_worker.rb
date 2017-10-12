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

    puts 'TODO: Send transform data to Unicorn with'
    #response1 = Request::Consult.GET_movement(json_data['token'])
    #puts response1.code
    response1 = Request::Consult.GET_movement(json_data['token'])
    response2 = Request::Consult.POST(json_data)
    puts response1.code
    puts response2.code
>>>>>>> origin/feature/workers
    puts 'TODO: Is saved data?'
    puts '-------------------------------------'
  end
end
