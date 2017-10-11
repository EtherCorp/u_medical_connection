module Request
  class Patient < Request::Base
    @entity = "patients"

    def self.GET_consults(id)
      dir = @@url + @entity + "/" + id.to_s + "/consults"
      req = HTTP.get(dir)
    end
  end
end
