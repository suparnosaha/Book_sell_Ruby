class User < ApplicationRecord
  has_secure_password
  has_many :transactions, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :carts, dependent: :destroy
  validates_uniqueness_of :username
  validates :username, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :credit_card_number, allow_blank: true, numericality: { only_integer: true, message: "can contain numbers only" }, length: { is: 16, message: "Exactly 16 digits needed" }
  validates :phone_number, allow_blank: true, numericality: { only_integer: true, message: "can contain numbers only" }, length: { is: 10, message: "Exactly 10 digits needed" }
end