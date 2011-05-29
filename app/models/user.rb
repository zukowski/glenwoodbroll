class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :collections

  def is_admin!
    self.update_attribute(:admin, true)
  end

  def is_not_admin!
    self.update_attribute(:admin, false)
  end
end
