require 'bcrypt'

class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :hashed_password, presence: true

  include BCrypt

  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.hashed_password = @password
  end

  def self.authenticate(params={})
    user = self.find_by(email: params[:email])
    return user if user && user.password == params[:password]
    nil
  end

end
