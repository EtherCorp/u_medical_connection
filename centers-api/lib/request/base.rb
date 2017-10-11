module Request
  class Base
    require "http"

    @@url = "http://localhost:3000/api/v1/"

    def self.GET(id = nil)
      dir = @@url + @entity + "/" + id.to_s
      req = HTTP.get(dir)
    end

    def self.POST(params)
      dir = @@url + @entity
      puts '*********** before post ************'
      req = HTTP.post(dir, :json => params)
      puts '***********REQUEST CODE************'
      #puts req.code
      puts '***********************************'
    end
  end
end
