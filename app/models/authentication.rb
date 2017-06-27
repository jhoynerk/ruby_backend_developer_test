class Authentication
  KEY_BASE = Rails.application.secrets.fetch(:secret_key_base)

  def self.jwt_encode(user)
    JWT.encode({ user_id: user.id }, Authentication::KEY_BASE)
  end

  def self.jwt_decode(token)
    JWT.decode(token, Authentication::KEY_BASE)
  end
end
