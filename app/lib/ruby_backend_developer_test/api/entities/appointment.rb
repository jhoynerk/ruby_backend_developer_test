class RubyBackendDeveloperTest::API::Entities::Appointment < Grape::Entity
  expose :id, :date, :buyer_id, :seller_id
end
