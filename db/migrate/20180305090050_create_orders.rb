class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :street_name, null: false
      t.string :unit_number
      t.string :city, null: false
      t.string :postal_code, null: false
      t.integer :contact_number, null: false
      t.float :order_total, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
