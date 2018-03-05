class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.string :item, null: false
      t.float :subtotal, null: false
      t.integer :quantity, null: false, default: 1
      t.float :total, null: false
      t.float :gst, null: false
      t.timestamps
    end
  end
end
