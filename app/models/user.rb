class User < ApplicationRecord

  # should be used devise or other gem to user auth
  def valid_password?(password)
    self.password == password
  end
end
