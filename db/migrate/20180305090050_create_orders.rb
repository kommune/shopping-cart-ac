class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :ship_to, null: false
      t.float :order_total, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
