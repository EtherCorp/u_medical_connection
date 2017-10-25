# Dispatcher worker that transform data and send to unicorn
class ChargueWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform()
    puts 'Hi, I am an worker!'
  end
end
