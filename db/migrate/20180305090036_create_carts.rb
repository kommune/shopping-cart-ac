class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.references :user, index: {unique: true}, foreign_key: true
      t.string :item, null: false
      t.float :subtotal, null: false
      t.integer :quantity, null: false, default: 1
      t.timestamps
    end
  end
end
