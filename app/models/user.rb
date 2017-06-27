class User < ApplicationRecord

  has_many :appointments_seller, class_name: 'Appointment', foreign_key: :seller_id
  has_many :appointments_buyer, class_name: 'Appointment', foreign_key: :buyer_id

  validates :email, uniqueness: true

  # should be used devise or other gem to user auth
  def valid_password?(password)
    self.password == password
  end
end
