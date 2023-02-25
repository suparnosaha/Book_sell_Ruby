class Book < ApplicationRecord
  has_many :reviews , dependent: :destroy
  has_many :carts, dependent: :destroy
  validates :name, :presence => true
  validates_uniqueness_of :name
  validates :author, :presence => true
  validates :publisher, :presence => true
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  validates :stock, :numericality => { :greater_than_or_equal_to => 0 }

end
