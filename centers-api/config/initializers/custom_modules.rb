require 'activity_logger'
require 'drivers/base'
Dir['request/*.rb'].each { |file| require file }
