class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  has_secure_password

  validates :password, presence: true, length: {minimum: 6}, on: :create
  validates :email, presence: true, uniqueness: true

end
