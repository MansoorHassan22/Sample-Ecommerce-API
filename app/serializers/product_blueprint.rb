class ProductBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :code, :price, :store_id

  field :price_with_symbol do |product|
    currency_code = product.store.currency.code
    Money.from_amount(product.price, currency_code).format
  end
  
end
