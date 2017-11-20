module Requests
  # For handler request ack
  class RequestAcknowledge
    require 'mongo_connection'
    require 'activity_logger'
  
    def self.post(request, normalized_request)
      requester = RequestUtils.new
  
      if request['request_type'] == 'patients'
        res = requester.post('patients', normalized_request)
        handler_acknowledge(res.code, request)
        ActivityLogger.logto('log_patients',request)
      end
    end
  
    def self.handler_acknowledge(acknowledge, request)
      return false unless acknowledge == '201'
      request['status'] = 'Done'
      request['_id'] = BSON::ObjectId.from_string(request['_id']['$oid'])
      mongo_connection = MongoConnection.new
      mongo_connection.update_request(request)
      true
    end
  end
end
