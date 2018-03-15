class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :street_name, null: false
      t.string :unit_number
      t.string :city, null: false
      t.bigint :postal_code, null: false
      t.bigint :contact_number, null: false
      t.integer :quantity
      t.integer :order_total, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
