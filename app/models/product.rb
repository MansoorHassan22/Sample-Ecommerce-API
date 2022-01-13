class Product < ApplicationRecord

  validates_presence_of :name, :code, :price
  validates_uniqueness_of :code

  belongs_to :store
  has_many :product_discounts
  has_many :discounts, through: :product_discounts
end
