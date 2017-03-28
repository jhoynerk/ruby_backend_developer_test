class RubyBackendDeveloperTest::API::Auth < Grape::API
  version :v1, using: :path

  namespace :auth do
    params do
      group :credentials, type: Hash do
        requires :email, :password, coerce: String
      end
    end

    post do
      credentials = declared(params).fetch(:credentials)
      email       = credentials.fetch(:email)
      password    = credentials.fetch(:password)
      user        = User.find_by(email: email)

      unless user
        status 403
        return { error: 'User not found' }
      end

      if user.password == password
        key = Rails.application.secrets.fetch(:secret_key_base)
        token = JWT.encode({user_id: user.id}, key)

        status 200
        {token: token}
      else
        status 403
        return { error: "Password doesn't match" }
      end
    end
  end
end