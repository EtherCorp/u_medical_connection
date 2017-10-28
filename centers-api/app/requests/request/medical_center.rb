# frozen_string_literal: true

module Request
  class MedicalCenter < Request::Base
    @entity = 'medical_centers'

    def self.get_professionals(id)
      dir = "#{self.url}/#{id}/professionals"
      HTTP.get(dir)
    end
  end
end
