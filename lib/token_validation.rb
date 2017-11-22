class TokenValidation
  def initialize; end

  def self.validate_token(headers)
    token = headers['Medical-Center-Token']
    return ActivityLogger.log(type: 'error', message: 'No token provided') unless token
    requester = Requests::RequestUtils.new
    response = requester.get('connection_tokens/token', headers)
    response
  end
end
