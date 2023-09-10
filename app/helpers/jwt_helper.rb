gem 'jwt'

module JwtHelper
  def generate_jwt_token(payload)
    secret_key = Rails.application.secrets.secret_key_base
    JWT.encode(payload, secret_key, 'HS256')
  end

  def decode_jwt_token(token)
    secret_key = Rails.application.secrets.secret_key_base
    decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
    decoded_token.first
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
    nil
  end
end