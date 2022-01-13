class StoreBlueprint < Blueprinter::Base
  identifier :id
  fields :name

  view :detail do 
    association :products, blueprint: ProductBlueprint
  end
end
