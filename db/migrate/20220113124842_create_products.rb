class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.decimal :price, precision: 4, scale: 2
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
