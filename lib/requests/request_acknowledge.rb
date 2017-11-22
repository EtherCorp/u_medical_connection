module Requests
  # For handler request ack
  class RequestAcknowledge
    require 'mongo_connection'
    require 'activity_logger'

    def self.post(request, normalized_request)
      requester = RequestUtils.new
      type = request['request_type']
      res = requester.post(type, normalized_request)
      request['_id'] = BSON::ObjectId.from_string(request['_id']['$oid'])
      handler_acknowledge(res.code, request)
      ActivityLogger.logto('log_' + type, res, request['_id'])
    end

    def self.handler_acknowledge(acknowledge, request)
      return false unless acknowledge == '201'
      request['status'] = 'Done'

      mongo_connection = MongoConnection.new
      mongo_connection.update_request(request)
      true
    end
  end
end
