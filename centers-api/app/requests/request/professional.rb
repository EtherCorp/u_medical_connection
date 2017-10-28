# frozen_string_literal: true

module Request
  class Professional < Request::Base
    @entity = 'professionals'

    def self.get_consults(id)
      dir = "#{self.url}/#{id}/consults"
      HTTP.get(dir)
    end

    def self.get_medical_centers(id)
      dir = "#{self.url}/#{id}/medical_centers"
      HTTP.get(dir)
    end
  end
end
