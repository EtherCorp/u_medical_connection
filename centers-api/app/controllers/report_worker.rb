class ReportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(token, medical_center, title, body)
    puts "SIDEKIQ WORKER GENERATING A REPORT FROM #{"medical_center"} WITH #{"token"}, #{"title"} and #{"body"}"
    puts 'translate = driver(data)'
    puts 'POST unicorn(translate)'
  end
end
