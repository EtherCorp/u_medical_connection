module Request
  class MedicalCenter < Request::Base
    @entity = "medical_centers"

    def self.GET_professionals(id)
      dir = @@url + @entity + "/" + id.to_s + "/professionals"
      req = HTTP.get(dir)
    end
  end
end
