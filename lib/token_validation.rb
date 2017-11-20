class TokenValidation
  def initialize; end

  def validate_token(headers)
    begin
      response = RequestUtils.get('connection_tokens/token', headers)
    rescue
      response = nil
    end
    response
  end
end
