class RubyBackendDeveloperTest::API::Policies::Appointment < Struct.new(:user, :appointment)
  def create?() is_seller? end
  def confirm?() is_buyer?  end
  def cancel?() is_seller? || is_buyer?  end

  private

  def is_buyer?() user && appointment.buyer.id == user.id end
  def is_seller?() user && appointment.seller.id == user.id end
end
