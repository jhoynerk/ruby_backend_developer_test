class RubyBackendDeveloperTest::API < Grape::API
  format :json
  mount self::V1::Appointments
end
