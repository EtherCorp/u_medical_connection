class TokenValidation
  def initialize; end

  def validate_token(headers)
    puts headers['Medical-Center-Token']
    requester = Requests::RequestUtils.new
    response = requester.get('connection_tokens/token', headers)
    response
  end
end
