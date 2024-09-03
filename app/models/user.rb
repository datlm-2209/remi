class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :videos

  before_save { self.email = email.downcase }

  validates :email, presence: true, length: {
    maximum: Settings.validate.user.email.max_length
  }
  validates :username, presence: true, length: {
    maximum: Settings.validate.user.username.max_length
   }
  validates :password, presence: true,
    length: {
      minimum: Settings.validate.user.password.min_length,
      maximum: Settings.validate.user.password.max_length
    }
end
