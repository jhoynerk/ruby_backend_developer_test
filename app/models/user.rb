class User < ApplicationRecord

  has_many :appointments_as_seller, inverse_of: :seller
  has_many :appointments_as_buyer, inverse_of: :buyer

  validates :email, uniqueness: true

  # should be used devise or other gem to user auth
  def valid_password?(password)
    self.password == password
  end
end
