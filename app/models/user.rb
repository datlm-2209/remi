class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :videos

  validates :username, presence: true, length: { maximum: 64 }
  validates :email, presence: true, length: { maximum: 64 }
  validates :password, presence: true, length: { minimum: 8 }

  before_save { self.email = email.downcase }
end
