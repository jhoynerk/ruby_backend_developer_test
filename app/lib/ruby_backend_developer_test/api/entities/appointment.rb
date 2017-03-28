class RubyBackendDeveloperTest::API::Entities::Appointment < Grape::Entity
  expose :id, :date
  expose :buyer,  using: RubyBackendDeveloperTest::API::Entities::User
  expose :seller, using: RubyBackendDeveloperTest::API::Entities::User
end
