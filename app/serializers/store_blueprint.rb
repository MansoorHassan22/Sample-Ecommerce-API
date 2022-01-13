class StoreBlueprint < Blueprinter::Base
  identifier :id
  fields :name

  view :detail do 
    association :products, blueprint: ProductBlueprint
    field :product_count do |store|
      store.products.count
    end
  end
end
