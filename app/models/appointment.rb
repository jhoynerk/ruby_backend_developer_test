class Appointment < ApplicationRecord
  belongs_to :seller, class_name: 'User', inverse_of: :appointments_seller
  belongs_to :buyer, class_name: 'User', inverse_of: :appointments_buyer

  validates :seller, uniqueness: { scope: [ :seller, :buyer] }
  validates :buyer, :seller, :date, presence: true
end
