FactoryGirl.define do
  factory :appointment do
    association :seller, factory: :user
    association :buyer, factory: :user
    date { rand Time.now..Time.now.+(3.months) }
  end
end
