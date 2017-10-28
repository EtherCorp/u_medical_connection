# frozen_string_literal: true

module Request
  class Base
    require 'http'
    require 'unicorn_logger'

    @@url = 'http://localhost:3000/api/v1/'

    def self.url
      @@url+@entity
    end

    def self.get(id = nil)
      dir = "#{self.url}/#{id}"
      HTTP.get(dir)
    end

    def self.post(params)
      dir = self.url
      puts dir
      HTTP.post(dir, json: params)
    end

  end
end
