class Discount < ApplicationRecord

    validates_presence_of :name
    validates_presence_of :percentage, :if => lambda { self.is_percentage_type.present? }
    validates_presence_of :minimum_products, :if => lambda { self.is_product_type.present? || self.is_percentage_type.present? }
    validates_presence_of :maximum_products, :if => lambda { self.is_product_type.present? }
    validates_presence_of :free_products, :if => lambda { self.is_product_type.present? }

    validate :check_discount_type

    has_many :product_discounts
    has_many :products, through: :product_discounts


    def check_discount_type
        if self.is_percentage_type.blank? && self.is_product_type.blank?
            errors.add(:is_percentage_type, "Please set either is_percentage_type or is_product_type attribute to create a discount")
            errors.add(:is_product_type, "Please set either is_percentage_type or is_product_type attribute to create a discount")
        elsif self.is_percentage_type.present? && self.is_product_type.present?
            errors.add(:is_percentage_type, "Please set either is_percentage_type or is_product_type attribute to create a discount")
            errors.add(:is_product_type, "Please set either is_percentage_type or is_product_type attribute to create a discount")
        end
    end
end
