class RubyBackendDeveloperTest::API::V1::Appointments < Grape::API
  version :v1, using: :path

  resources :appointments do
    params do
      group :appointment, type: Hash do
        requires :seller_id, :buyer_id, coerce: Integer
        requires :date, coerce: DateTime
      end
    end

    post do
      attributes  = declared(params).fetch(:appointment)
      appointment = Appointment.create!(attributes)
      presenter   = RubyBackendDeveloperTest::API::Entities::Appointment

      present appointment, with: presenter
    end
  end
end
