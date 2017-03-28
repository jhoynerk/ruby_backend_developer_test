class Appointment < ApplicationRecord
  with_options class_name: 'User' do
    belongs_to :seller, inverse_of: :appointments_as_seller
    belongs_to :buyer, inverse_of: :appointments_as_buyer
  end

  validates :buyer, :seller, :date, presence: true
  validate :does_not_overlap_other_appointments

  after_commit :notify, on: :create
  scope :overlapping, ->(opts) do
    start_time = opts.fetch(:start_time)
    end_time   = opts.fetch(:end_time)

    query = <<-SQL
      ("#{table_name}"."date", #{table_name}."date" + interval '30 minutes') OVERLAPS (?, ?)
    SQL

    where(query, start_time, end_time)
  end

  scope :overlapping_appointment, -> (a) do
    return none unless a.date.present?

    overlapping(
      start_time: a.date,
      end_time: a.date + 30.minutes
    ).where.not id: a.id
  end

  private

  def does_not_overlap_other_appointments
    return unless Appointment.overlapping_appointment(self).any?
    errors.add(:date, :overlaps_other_appointments)
  end

  def notify
    AppointmentsMailer
      .delay_until(self.date - 30.minutes)
      .notification(self.id)
  end
end
