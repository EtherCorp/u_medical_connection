class DispatcherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(request_type, json_data)
    puts '---- Hello from DispatcherWorker ----'
    puts JSON.generate(json_data)

    puts 'TODO: Transform JSON input data with Driver'
    center_driver = 'MedicalCenter1'
    driver = Object.const_get('Driver::' << center_driver).new
    normalized_json = driver.parse(request_type, json_data)
    puts JSON.generate(normalized_json)

    puts 'TODO: Send transform data to Unicorn with'
    #response1 = Request::Consult.GET_movement(json_data['token'])
    #response2 = Request::Patient.GET_consults(normalized_json)
    puts 'TODO: Is saved data?'
    puts '-------------------------------------'
  end
end
