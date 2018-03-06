class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.text :description
      t.string :filestack_url, default: ""
      t.timestamps
    end
  end
end
