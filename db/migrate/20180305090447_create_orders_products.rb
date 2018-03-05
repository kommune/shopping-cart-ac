class CreateOrdersProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :orders_products do |t|
      t.references :orders, foreign_key: true
      t.references :products, foreign_key: true
      t.timestamps
    end
    add_index :orders_products, [:orders_id, :products_id], unique: true
  end
end
