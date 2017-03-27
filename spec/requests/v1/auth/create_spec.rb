require 'rails_helper'

RSpec.describe "Auth", type: :request do
  describe "POST /v1/auth" do
    let(:user) { create :user }
    let(:jwt_encode_key) { Rails.application.secrets.fetch(:secret_key_base) }

    context 'when using valid credentials' do
      it "should return a JWT token" do
        params = {
          credentials: {
            email:    user.email,
            password: user.password
          }
        }

        post '/v1/auth', params: params

        token = JSON.parse(response.body)['token']
        payload, _ = JWT.decode(token, jwt_encode_key)
        expect(payload['user_id']).to eq(user.id)
      end
    end
  end
end
