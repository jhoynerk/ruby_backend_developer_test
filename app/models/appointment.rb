class Appointment < ApplicationRecord
  with_options class_name: 'User' do
    belongs_to :seller, inverse_of: :appointments_as_seller
    belongs_to :buyer, inverse_of: :appointments_as_buyer
  end

  validates :buyer, :seller, :date, presence: true
end
