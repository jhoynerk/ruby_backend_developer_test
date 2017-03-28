class User < ApplicationRecord
  has_many :appointments_as_seller, inverse_of: :seller
  has_many :appointments_as_buyer, inverse_of: :buyer

  validates :email, presence: true
end
