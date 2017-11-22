require 'mongo'
require 'time'

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

  def self.logto(collection, res, id)
    log = { code: res.code,
            message: res.message,
            timestamp: Time.now,
            ObjectId: id }
    logcollection(collection).insert_one(log)
  end
end

ActivityLogger.log(asd: '123', ewr: '543') if $PROGRAM_NAME == __FILE__
