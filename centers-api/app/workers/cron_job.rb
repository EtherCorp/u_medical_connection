class CronJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'
  def perform
    puts 'hi from DisasterRecovery class!!!'
    now_time = Time.new
    my_file = File.new('/home/diego/Escritorio/cron-logs/file-min-' + now_time.to_s, 'w+')
    # ... process the file
    my_file.close  end
end
# ChargueWorker.perform_async
