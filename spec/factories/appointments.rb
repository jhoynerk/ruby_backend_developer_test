FactoryGirl.define do
  factory :appointment do
    association :seller, factory: :user
    association :buyer, factory: :user
    date { Faker::Date.between(Date.today, 15.days.since) }
  end
end
