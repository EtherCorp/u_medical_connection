class CronJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'
  require 'activity_logger'
  require 'dispatcher_worker'
  def perform
    puts 'hi from CronJob!!!'
    # TODO get data from mongo db for state
    mongo_connection = ActivityLogger.new
    my_request = mongo_connection.pending_request
    puts '#################################'
    puts '#################################'
    # my_request.each { |row| puts row.inspect }
    # my_request.each { |row| puts row['request_type'] }
    # my_request.each { |row| puts row['patient'] }
    my_request.each { |row| DispatcherWorker.perform_async(row['request_type'], row['patient']['body'])
      puts row['request_type']
      puts row['patient']['body']
    }

    #DispatcherWorker.perform_async(request_type, params)
    puts '#################################'
    puts '#################################'
  end
end
