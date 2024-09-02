class DecodeJwtTokenService
  def initialize(token)
    @token = token
  end

  def execute
    decode_token
  end

  private
  def decode_token
    JWT.decode(
      @token,
      Rails.application.credentials.fetch(:devise_jwt_secret_key),
      algorithm: "HS256",
      verify_jti: true
    ).first.symbolize_keys
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    false
  end
end
