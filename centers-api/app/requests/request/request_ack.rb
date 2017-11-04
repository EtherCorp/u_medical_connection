# For handler request ack
class RequestAck
  require 'mongo_connection'

  def self.post(request_type, normalized_json, hash)
    if request_type == 'patients'
      res = Request::Patient.POST(normalized_json)
      handler_ack(res.code, hash)
    end
  end

  def self.handler_ack(ack, hash)
    return false if ack == '201'
    hash['status'] = 'Done'
    hash['_id'] = BSON::ObjectId.from_string(hash['_id']['$oid'])
    mongo_connection = MongoConnection.new
    mongo_connection.update_request(hash)
    true
  end
end
