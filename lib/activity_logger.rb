require 'mongo'

class ActivityLogger
  @@config = {
    host: '127.0.0.1',
    port: '27017',
    db: 'system_logs'
  }
  
  @@connection = nil
  
  def self.mongo
    if @@connection.nil?
      puts 'creando logger'
      @@connection = @@connection ||= Mongo::Client.new(
      ["#{@@config[:host]}:#{@@config[:port]}"],
      database: @@config[:db]
      )
    end
#    @@connection ||= Mongo::Client.new(
#      ["#{@@config[:host]}:#{@@config[:port]}"],
#      database: @@config[:db]
#    )
    @@connection[:logs]
  end
  
  def self.log(object)
    mongo.insert_one(object)
  end

  def self.logcollection(collection)
    if @@connection.nil?
      puts 'creando logger'
      @@connection = @@connection ||= Mongo::Client.new(
      ["#{@@config[:host]}:#{@@config[:port]}"],
      database: @@config[:db]
      )
    end
    @@connection[collection]
  end

  def self.logto(collection, object)
    logcollection(collection).insert_one(object)
  end

end

if __FILE__ == $0
  ActivityLogger.log(asd: '123', ewr: '543')
end