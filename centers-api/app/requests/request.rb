module Request
  class Base
    require "http"

    @@url = "http://localhost:3000/api/v1/"

    def self.GET(id = nil)
      dir = @@url + @entity + "/" + id.to_s
      puts HTTP.get(dir)
    end

    def self.POST(id)
      dir = @@url + @entity + "/" + id.to_s
      req = HTTP.post(dir)
    end
  end
end
