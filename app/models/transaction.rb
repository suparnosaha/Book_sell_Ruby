class Transaction < ApplicationRecord
  belongs_to :user
  has_many :carts, dependent: :destroy
  validates :credit_card_number, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :total_price, numericality: { greater_than: 0 }
  validates :quantity, numericality: { greater_than: 0 }
  validates :credit_card_number, numericality: { only_integer: true, message: "can contain numbers only" }, length: { is: 16, message: "Exactly 16 digits needed" }
  validates :phone_number, numericality: { only_integer: true, message: "can contain numbers only" }, length: { is: 10, message: "Exactly 10 digits needed" }
end
