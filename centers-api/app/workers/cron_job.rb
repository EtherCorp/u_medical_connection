class CronJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'
  require 'dispatcher_worker'
  require 'mongo_connection'
  def perform
    mongo_connection = MongoConnection.new
    my_request = mongo_connection.pending_request
    my_request.each { |row| DispatcherWorker.perform_async('[' + row.to_json + ']', row['request_type'], row['data']['body'].to_json)
    }
  end
end
