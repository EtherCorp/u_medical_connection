# Dispatcher worker that transform data and send to unicorn
class DispatcherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  # Dir['../../request/request/*.rb'].each { |file| require_relative file }

  def perform(json_data)
    puts '---- Hello from DispatcherWorker ----'
    puts '**************************'
    puts json_data['token']
    puts '**************************'
    puts 'TODO: Transform JSON input data with Driver'
    puts 'TODO: Send transform data to Unicorn with'
    Request::Base.GET() # example Reques usage
    puts 'TODO: Is saved data?'
    puts '-------------------------------------'
  end
end
