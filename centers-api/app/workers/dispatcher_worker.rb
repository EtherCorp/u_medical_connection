<<<<<<< HEAD
# Dispatcher worker that transform data and send to unicorn
=======
>>>>>>> origin/feature/workers
class DispatcherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(json_data)
    puts '---- Hello from DispatcherWorker ----'
<<<<<<< HEAD
    puts '**************************'
    puts json_data['token']
    puts '**************************'
    puts 'TODO: Transform JSON input data with Driver'
    puts 'TODO: Send transform data to Unicorn with'
    #Request::Base.POST(json_data)
=======
    puts 'TODO: Transform JSON input data with Driver'
    puts 'TODO: Send transform data to Unicorn with'
>>>>>>> origin/feature/workers
    response1 = Request::Consult.GET_movement(json_data['token'])
    response2 = Request::Consult.POST(json_data)
    puts response1.code
    puts response2.code
    puts 'TODO: Is saved data?'
    puts '-------------------------------------'
  end
end
