class Currency < ApplicationRecord

validates_presence_of :name , :code
validates_uniqueness_of :code


end