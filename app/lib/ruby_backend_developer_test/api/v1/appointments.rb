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
        #buyer = User.find_by_id attributes.buyer_id.to_i
        #seller = Seller.find_by_id attributes.seller_id.to_i
        #AppointmentsMailer.notifications(buyer, seller).deliver_later
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

    route_param :id do
      put :confirm do
        apponitment = Appointment.find(params.fetch(:id))
        if current_user.id == apponitment.buyer_id
          apponitment.update!(status: true)
          status :ok
        else
          status :forbidden
        end
      end

      put :cancel do
        apponitment = Appointment.find params.fetch(:id)
        if current_user.id == apponitment.buyer_id || current_user.id == apponitment.seller_id
          apponitment.update!(status: false)
          status :ok
        else
          status :forbidden
        end
      end
    end
  end
end
