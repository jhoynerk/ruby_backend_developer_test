class RubyBackendDeveloperTest::API < Grape::API
  format :json

  mount self::V1::Auth
  mount self::V1::Appointments
end
