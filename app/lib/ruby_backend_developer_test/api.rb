class RubyBackendDeveloperTest::API < Grape::API
  format :json

  helpers do
    def current_user
      token =
        headers['Authorization']
          .try(:match, /\ABearer (.+)\z/)
          .try(:[], 1)

      return unless token.present?

      key        = Rails.application.secrets.fetch(:secret_key_base)
      payload, _ = JWT.decode(token, key)
      user_id    = payload['user_id']

      return unless user_id.present?

      User.find_by(id: user_id)
    end

    def authenticate!
      return if current_user.present?
      error!('You must be authenticated to perform this action', 401)
    end

    def authorizing(policy, resource, action, &block)
      if policy.new(current_user, resource).send("#{action}?")
        yield
      else
        error!('You are not allowed to perform this action', 403)
      end
    end
  end

  rescue_from(ActiveRecord::RecordInvalid) { |e| error!(e, 422) }

  mount self::V1::Auth
  mount self::V1::Appointments
end
