class RubyBackendDeveloperTest::API::Entities::User < Grape::Entity
  expose :id, :email
end
