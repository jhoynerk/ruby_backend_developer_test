class RubyBackendDeveloperTest::API::V1::Appointments < Grape::API
  version :v1, using: :path

  resources :appointments do
    before { authenticate! }

    params do
      group :appointment, type: Hash do
        requires :seller_id, :buyer_id, coerce: Integer
        requires :date, coerce: DateTime
      end
    end

    post do
      attributes = params.fetch(:appointment)
      if current_user.id == attributes.seller_id
        appointment = Appointment.create({
                                            seller_id: attributes.seller_id,
                                            buyer_id: attributes.buyer_id,
                                            date: attributes.date
                                          })
      else
        return status :unauthorized
      end
      if appointment.errors.any?
        status :unprocessable_entity
        { errors: appointment.errors.full_messages }
      else
        status :created
        { data: appointment }
      end
    end
  end
end
