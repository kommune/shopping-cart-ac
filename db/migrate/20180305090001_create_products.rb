class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.text :description
      t.string :product_image
      t.timestamps
    end
  end
end
