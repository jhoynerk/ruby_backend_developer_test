require 'rails_helper'

RSpec.describe "POST /v1/auth", type: :request do
  let(:seller)           { create :user }
  let(:car)              { create :car, seller_id: seller.id }
  let(:buyer)            { create :user }
  let(:appointment_date) { Time.now }
  let(:params) do
    {
      seller_id: seller.id,
      buyer_id:  buyer.id,
      date:      appointment_date
    }
  end

  before(:each) do
    post '/v1/appointments', params: params
  end

  context 'when using valid parameters' do
    it 'should create and return an appointment' do
      data = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(Appointment.count).to eq(1)
      expect(data['seller_id']).to eq(seller.id)
      expect(data['buyer_id']).to eq(buyer.id)
    end
  end

  context 'when overlaping other appointment' do
    it 'should refuse to create the appointment' do
      post '/v1/appointments', params: params
      expect(Appointment.count).to eq(1)
      expect(response.status).to eq(422)
    end
  end
end
