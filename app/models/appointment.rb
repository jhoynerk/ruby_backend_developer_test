class Appointment < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  belongs_to :buyer, class_name: 'User'

  validates :seller, uniqueness: { scope: [ :seller, :buyer] }
  validates :buyer, :seller, :date, presence: true
end
