class RubyBackendDeveloperTest::API::V1::Auth < Grape::API
  version :v1, using: :path

  resources :auth do

    params do
      requires :credentials, type: Hash do
        requires :email, :password
      end
    end

    post do
      email, password = params.credentials.email, params.credentials.password
      user = User.find_by_email(email)
      if user.nil?
        status :unauthorized
        { status: :unauthorized, message: 'User not found' }
      elsif user.valid_password?(password)
        status :ok
        { status: :ok, token: Authentication::jwt_encode(user) }
      else
        status :unauthorized
        { status: :unauthorized, error: 'Password does not match' }
      end
    end
  end
end
