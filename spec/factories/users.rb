FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(name) }
    password { SecureRandom.hex(8) }
  end
end
