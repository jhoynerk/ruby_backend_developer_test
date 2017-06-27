class RubyBackendDeveloperTest::API < Grape::API
  format :json

   helpers do
    def current_user
      @current_user ||= set_user
    end

    def set_user
      pattern = /^Bearer /
      header_token  = headers['Authentication']
      header_token.gsub(pattern, '') if header_token && header_token.match(pattern)
      return if header_token.nil?
      user_id = Authentication::jwt_decode(header_token)
      user_id = user_id[0]['user_id']
      return if user_id.nil?
      User.find_by(id: user_id)
    end

    def authenticate!
      error!('401 Unauthorized', :unauthorized) unless current_user.present?
    end
  end

  mount self::V1::Appointments
  mount self::V1::Auth
end
