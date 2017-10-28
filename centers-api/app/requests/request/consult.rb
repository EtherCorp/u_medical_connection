# frozen_string_literal: true

module Request
  class Consult < Request::Base
    @entity = 'consults'

    def self.get_movement(id)
      dir = "#{self.url}/#{id}/movements"
      HTTP.get(dir)
    end

    def self.post_movement_details(id, movement_id, params)
      dir = "#{self.url}/#{id}/movements/#{movement_id}/details"
      HTTP.post(dir, json: params)
    end

    def self.post_movement_documents(id, movement_id, params)
      dir = "#{self.url}/#{id}/movements/#{movement_id}/documents"
      HTTP.post(dir, json: params)
    end
  end
end
