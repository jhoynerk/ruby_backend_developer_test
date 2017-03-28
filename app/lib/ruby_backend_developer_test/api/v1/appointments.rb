class RubyBackendDeveloperTest::API::V1::Appointments < Grape::API
  version :v1, using: :path

  PRESENTER = RubyBackendDeveloperTest::API::Entities::Appointment
  POLICY    = RubyBackendDeveloperTest::API::Policies::Appointment

  resources :appointments do
    params do
      group :appointment, type: Hash do
        requires :seller_id, :buyer_id, coerce: Integer
        requires :date, coerce: DateTime
      end
    end

    before { authenticate! }

    post do
      attributes  = declared(params).fetch(:appointment)
      appointment = Appointment.new(attributes)

      authorizing(POLICY, appointment, :create) do
        appointment.save!
        present appointment, with: PRESENTER
      end
    end

    route_param :id do
      helpers do
        def requested_resource
          @requested_resource ||= Appointment.find params.fetch(:id)
        end
      end

      put :confirm do
        authorizing(POLICY, requested_resource, :confirm) do
          requested_resource.update! confirmed: true
          present requested_resource, with: PRESENTER
        end
      end

      put :cancel do
        authorizing(POLICY, requested_resource, :cancel) do
          requested_resource.update! cancelled: true
          present requested_resource, with: PRESENTER
        end
      end
    end
  end
end
