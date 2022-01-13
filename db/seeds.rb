# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Currency.create(name: "Euros", code: "EUR")
currency = Currency.where(code: "EUR").first

Store.create(name: "Test Store", currency_id: currency.id)
store = Store.first

Product.create(name: "Reedsy Mug", code: "MUG", price: 6.00, store_id: store.id )
Product.create(name: "Reedsy T-shirt", code: "TSHIRT", price: 15.00, store_id: store.id )
Product.create(name: "Reedsy Hoodie", code: "HOODIE", price: 20.00, store_id: store.id )

Discount.create(name: "2-for-1", is_product_type: true, is_percentage_type: false, minimum_products: 2, maximum_products: 2, free_products: 1, percentage: 0)
discount = Discount.where(name: "2-for-1").first
product = Product.where(code: "MUG").first
discount.products << [product]

Discount.create(name: "30% off on all T-shirts", is_product_type: false, is_percentage_type: true, minimum_products: 2, maximum_products: 0, free_products: 0, percentage: 30)
discount2 = Discount.where(name: "30% off on all T-shirts").first
product2 = Product.where(code: "TSHIRT").first
discount2.products << [product2]