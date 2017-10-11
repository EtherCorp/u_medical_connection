module Request
  class Professional < Request::Base
    @entity = "professionals"

    def self.GET_consults(id)
      dir = @@url + @entity + "/" + id.to_s + "/consults"
      req = HTTP.get(dir)
    end

    def self.GET_medical_centers(id)
      dir = @@url + @entity + "/" + id.to_s + "/medical_centers"
      req = HTTP.get(dir)
    end
  end
end
