require 'activity_logger'
<<<<<<< HEAD
require 'drivers/base'
=======
# require 'request/base' # base of lib/request
>>>>>>> origin/feature/queue
Dir['request/*.rb'].each { |file| require file }
