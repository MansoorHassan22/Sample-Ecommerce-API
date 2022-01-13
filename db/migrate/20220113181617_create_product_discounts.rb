class CreateProductDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :product_discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.references :discount,  null: false, foreign_key: true
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
