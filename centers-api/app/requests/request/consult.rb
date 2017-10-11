module Request
  class Consult < Request::Base
    @entity = "consults"

    def self.GET_movement(id)
      dir = @@url + @entity + "/" + id.to_s + "/" + "movements"
      req = HTTP.get(dir)
    end

    def self.POST_movement_details(id, movement_id, params)
      dir = @@url + @entity + "/" + id.to_s + "/" + "movements/" + movement_id.to_s + "/details"
      req = HTTP.post(dir, :json => JSON.parse params)
    end

    def self.POST_movement_documents(id, movement_id, params)
      dir = @@url + @entity + "/" + id.to_s + "/" + "movements/" + movement_id.to_s + "/documents"
      req = HTTP.post(dir, :json => JSON.parse params)
    end
  end
end
