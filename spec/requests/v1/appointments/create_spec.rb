require 'rails_helper'
require Rails.root.join('spec/shared/auth.rb')

RSpec.describe "POST /v1/appointments", type: :request do
  include_context :auth

  let(:seller)           { create :user }
  let(:buyer)            { create :user }
  let(:appointment_date) { Time.now + 1.hour }

  let(:params) do
    {
      appointment: {
        seller_id: seller.id,
        buyer_id:  buyer.id,
        date:      appointment_date
      }
    }
  end

  before(:each) do
    Sidekiq::Testing.inline! do
      post '/v1/appointments',
        params:  params,
        headers: auth_headers
    end
  end

  # An appointment can only be created if the
  # authenticated user is the seller in the appointment
  context 'when authenticated as another user' do
    let(:authenticated_user) { buyer }

    it 'should refuse to create the appointment' do
      expect(Appointment.count).to eq(0)
      expect(response.status).to eq(403)
    end
  end

  context 'when not authenticated' do
    let(:authenticated_user) { nil }

    it 'should refuse to create the appointment' do
      expect(Appointment.count).to eq(0)
      expect(response.status).to eq(401)
    end
  end

  context 'when authenticated as the seller' do
    let(:authenticated_user) { seller }

    context 'and using valid parameters' do
      it 'should create and return an appointment' do
        data = JSON.parse(response.body)

        expect(response.status).to eq(201)
        expect(Appointment.count).to eq(1)
        expect(data['seller_id']).to eq(seller.id)
        expect(data['buyer_id']).to eq(buyer.id)
      end

      context ', 30 minutes before the appointment date' do
        it 'should send a notification email to the involved parts' do
          mails = ActionMailer::Base.deliveries.last(2)

          recipients = mails.flat_map(&:to).sort
          expected_recipients = [buyer, seller].map(&:email).sort

          expect(recipients).to eq(expected_recipients)
        end
      end
    end

    context 'when overlaping other appointment' do
      it 'should refuse to create the appointment' do
        post '/v1/appointments', params: params, headers: auth_headers
        expect(response.status).to eq(422)
        expect(Appointment.count).to eq(1)
      end
    end
  end
end
