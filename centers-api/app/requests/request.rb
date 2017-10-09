class Request
  require "http"

  @@url = "localhost:3000/api/v1/"

  def self.GET(id = nil)
    dir = @@url + @entity + "/" + id.to_s
    puts HTTP.get(dir)
  end

  def self.POST(id)
    dir = @@url + @entity + "/" + id.to_s
    req = HTTP.post(dir)
  end

  def self.DELETE(id)
    dir = @@url + @entity + "/" + id.to_s
    req = HTTP.delete(dir)
  end
end
