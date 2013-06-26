require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt
  validates :email, :presence => true, :format => { :with => /\w+@\w+.\w+/ }
  validates :password, :confirmation => true
  has_many :urls

  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.hashed_password = @password
  end

  def self.create(params)
    @user = User.new(params)
    @user.password = params[:password]
    @user.save!
    @user
  end

  def self.check_login(params)
    @user = User.find_by_email(params[:email])
    @user.password == params[:password] ? @user : nil
  end
end

