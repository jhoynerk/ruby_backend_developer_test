class RubyBackendDeveloperTest::API < Grape::API
  format :json
  mount self::V1::Appointments
  mount self::V1::Auth
end
