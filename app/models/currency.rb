class Currency < ApplicationRecord

    validates_presence_of :name , :code
    validates_uniqueness_of :code

    has_many :stores
end
