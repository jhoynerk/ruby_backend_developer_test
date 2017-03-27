class RubyBackendDeveloperTest::API::V1::Appointments < Grape::API
  version :v1, using: :path

  resources :appointments do
    get { {pete: :rete} }
  end
end
