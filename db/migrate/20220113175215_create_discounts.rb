class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.boolean :is_product_type
      t.boolean :is_percentage_type
      t.integer :minimum_products
      t.integer :free_products
      t.integer :maximum_products
      t.integer :percentage

      t.timestamps
    end
  end
end
