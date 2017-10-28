# frozen_string_literal: true

module Request
  class Patient < Request::Base
    @entity = 'patients'

    def self.get_consults(id)
      dir = "#{self.url}/#{id}/consults"
      HTTP.get(dir)
    end
  end
end
