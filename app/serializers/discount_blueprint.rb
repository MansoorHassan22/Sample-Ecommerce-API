class DiscountBlueprint < Blueprinter::Base
    identifier :id
    fields :name, :minimum_products, :maximum_products, :is_product_type, :is_percentage_type, :free_products

    fields :percentage do |discount|
        discount.percentage + "%"
    end

    view :detail do
        association :products, blueprint: ProductBlueprint
        field :product_count do |discount|
            discount.products.count
        end
    end
  
end
  