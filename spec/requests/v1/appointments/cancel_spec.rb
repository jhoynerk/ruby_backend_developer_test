require 'rails_helper'
require Rails.root.join('spec/shared/auth.rb')

RSpec.describe "PUT /v1/appointments/:id/confirm", type: :request do
  include_context :auth

  let(:seller)      { create :user }
  let(:buyer)       { create :user }
  let(:appointment) { create :appointment, seller: seller, buyer: buyer }

  before(:each) do
    put "/v1/appointments/#{appointment.id}/cancel",
      headers: auth_headers
  end

  context 'when authenticated as another user' do
    let(:authenticated_user) { create :user }

    it 'should refuse to create the appointment' do
      expect(appointment.reload.cancelled).not_to eq(true)
      expect(response.status).to eq(403)
    end
  end

  context 'when not authenticated' do
    let(:authenticated_user) { nil }

    it 'should refuse to create the appointment' do
      expect(appointment.reload.cancelled).not_to eq(true)
      expect(response.status).to eq(401)
    end
  end

  context 'when authenticated as the buyer' do
    let(:authenticated_user) { buyer }

    it 'should confirm the appointment' do
      expect(appointment.reload.cancelled).to eq(true)
      expect(response.status).to eq(200)
    end
  end

  context 'when authenticated as the seller' do
    let(:authenticated_user) { seller }

    it 'should confirm the appointment' do
      expect(appointment.reload.cancelled).to eq(true)
      expect(response.status).to eq(200)
    end
  end
end
