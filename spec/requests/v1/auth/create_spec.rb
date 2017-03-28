require 'rails_helper'

RSpec.describe "POST /v1/auth", type: :request do
  let(:user) { create :user }
  let(:jwt_encode_key) { Rails.application.secrets.fetch(:secret_key_base) }

  before(:each) { post '/v1/auth', params: { credentials: credentials } }

  context 'when using valid credentials' do
    let(:credentials) do
      { email:    user.email,
        password: user.password }
    end

    it "should return a jwt token" do
      token = JSON.parse(response.body)['token']
      payload, _ = JWT.decode(token, jwt_encode_key)
      expect(payload['user_id']).to eq(user.id)
    end
  end

  context 'when using invalid credentials' do
    let(:credentials) do
      { email:    user.email,
        password: user.password + 'perpasdasdkj' }
    end

    it "should return an error" do
      json_body = JSON.parse(response.body)
      expect(response.status).to eq(401)
      expect(json_body).to have_key('error')
    end
  end
end
