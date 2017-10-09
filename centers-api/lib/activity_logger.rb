require 'mongo'

class ActivityLogger
  @@config = {
    host: '127.0.0.1',
    port: '27017',
    db: 'test'
  }

  def self.mongo
    @@connection ||= Mongo::Client.new(
      ["#{@@config[:host]}:#{@@config[:port]}"],
      database: @@config[:db]
    )
    @@connection[:logs]
  end

  def self.log(object)
    mongo.insert_one(object)
  end
end

if __FILE__ == $0
  ActivityLogger.log(asd: '123', ewr: '543')
end