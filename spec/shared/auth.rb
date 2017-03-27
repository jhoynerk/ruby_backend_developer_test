RSpec.shared_context :auth, shared_context: :metadata do
  let(:authenticated_user) { create :user }

  let(:auth_token) do
    next unless authenticated_user
    key = Rails.application.secrets.fetch(:secret_key_base)
    JWT.encode({user_id: authenticated_user.id}, key)
  end

  let(:auth_headers) do
    next {} unless auth_token
    {'Authorization': "Bearer #{auth_token}"}
  end
end
