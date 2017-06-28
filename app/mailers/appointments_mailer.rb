class AppointmentsMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notifications(buyer, seller)
    @buyer = buyer
    @seller = seller
    mail(to: [ @buyer.email, @seller.email ],
         subject: 'Appointments')
  end
end
