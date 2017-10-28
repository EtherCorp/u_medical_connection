# frozen_string_literal: true

module UnicornLogger
  class << self
    require 'logger'

    attr_accessor :logger
  end

  self.logger = Logger.new(STDOUT)
  self.logger.level = Logger::DEBUG
end
