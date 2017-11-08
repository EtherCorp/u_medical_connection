class CronJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'
  require 'dispatcher_worker'
  require 'mongo_connection'
  def perform
    mongo_connection = MongoConnection.new
    pending_requests = mongo_connection.pending_requests
    pending_requests.each do |row|
      DispatcherWorker.perform_async(row)
    end
    puts "#{pending_requests.count} pending requests has been requeued"
    response = mongo_connection.delete_done_requests
    puts "#{response.deleted_count} done requests has been deleted"
  end
end
