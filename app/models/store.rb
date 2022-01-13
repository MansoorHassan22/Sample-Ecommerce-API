class Store < ApplicationRecord

  validates_presence_of :name
  
  belongs_to :currency
  has_many :products
end
