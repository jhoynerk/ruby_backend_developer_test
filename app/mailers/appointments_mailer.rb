class AppointmentsMailer < ActionMailer::Base
  default from: 'no-repy@example.com'

  def notification(appointment_id)
    appointment = Appointment.find(appointment_id)
    mail(
      to: [
        appointment.seller.email,
        appointment.buyer.email
      ],
      subject: 'Appointment in 30 minutes',
      body: 'Your appointment begins in 30 minutes'
    )
  end
end
