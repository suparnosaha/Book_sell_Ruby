class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :transaction_cart, foreign_key: 'transaction_id', class_name: 'Transaction', optional: true
end
