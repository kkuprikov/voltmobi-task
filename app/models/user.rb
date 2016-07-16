class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  has_secure_password

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email

end
