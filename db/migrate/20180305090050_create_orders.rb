class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :order_number, null: false, index: {unique: true}
      t.string :ship_to, null: false
      t.float :order_total, null: false
      t.string :view_order, null: false
      t.integer :status, null: false
      t.timestamps
    end
  end
end
