class Authentication
  KEY_BASE = Rails.application.secrets.fetch(:secret_key_base)

  def self.jwt(user)
    JWT.encode({user_id: user.id}, Authentication::KEY_BASE)
  end
end
