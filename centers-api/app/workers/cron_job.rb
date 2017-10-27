class CronJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'
  require 'dispatcher_worker'
  require 'mongo_connection'
  def perform
    puts 'hi from CronJob!!!'
    # TODO get data from mongo db for state
    mongo_connection = MongoConnection.new
    my_request = mongo_connection.pending_request
    puts '#################################'
    puts '********< cron_job.rb >**********'
    puts '#################################'
    my_request.each { |row| DispatcherWorker.perform_async('[' + row.to_json + ']', row['request_type'], row['data']['body'].to_json)
    }
    puts '#################################'
    puts '*******<\ cron_job.rb >**********'
    puts '#################################'
  end
end
